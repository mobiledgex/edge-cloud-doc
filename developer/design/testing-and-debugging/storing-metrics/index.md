---
title: Storing Metrics and Insights
long_title:
overview_description:
description:
Learn how to use our application metrics to detect performance anomalies

---

The MobiledgeX platform provides the ability to retrieve metrics on your applications and clusters via both the Web Console and the MobiledgeX API. MobiledgeX controls the granularity and retention policy for these metrics. If you wish more control over your metrics, you can write an ETL pipeline to move the metrics that you are interested into your own [Time Series Database](https://en.wikipedia.org/wiki/Time_series_database)(TSDB).

## InfluxDB Example

This example uses InfluxDB as a TSDB to store application metric data.

### Exclusions

The example script provided is not suited for production use, and is intended solely as a proof of concept. Additionally, please be aware of the following additional limitations of the script:

- Samples are taken at 10-second intervals.
- Metrics being sampled are CPU, disk, and memory.
- The MobiledgeX provided timestamp is not being used;instead, we are utilizing InfluxDB to create a timestamp for us.
- The InfluxDB installation being used has no security enabled.
- The script assumes you have logged into the MobiledgeX console with `mcctl` and have an active JWT token.
- The script relies on data being returned in json format from the `mcctl` utility.
- Please see the script header for additional information.


### Assumptions

- You have the `mcctl` utility installed.
- You have an account with access to the application you wish to monitor.
- You have an InfluxDB installation with a database named `mex`.
- You can read/write to/from the InfluxDB database.

### Script Flow

The script flow is very simple:

- Pull data from the MobiledgeX API.
- Transform the data into the InfluxDB line protocol.
- Post the data to InfluxDB using cURL.
- Sleep for 10 seconds.
- Return to step 1.


### Pulling Data

The `mcctl` command is used to pull data from the MobiledgeX API.

`mcctl --addr https://console.mobiledgex.net --output-format json metrics app \ region=$REGION app-org=$APPORG appname=$APPNAME appvers=$APPVER last=1"`

You will need to replace REGION, APPORG, APPNAME, and APPVER with the data that corresponds to the application you wish to monitor. The use of `last=1` restricts the data returned to the most recently collected metrics. This can be omitted, in which case the API will return multiple rows (unique by timestamp). You can also specify start and end times for metrics. For this example, we will just be using the last collected set of metrics.

#### Return Format

The data from the above will be returned in json format, and will be presented as follows:

```
{
  "data": [
    {
      "Series": [
        {
          "columns": [
            "time",
            "app",
            "ver",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "apporg",
            "pod",
            "cpu"
          ],
          "name": "appinst-cpu",
          "values": [
            [
              "2020-08-11T14:51:54.687583518Z",
              "compose-file-test",
              "10",
              "autoclustercompose-file-test",
              "demoorg",
              "hamburg-main",
              "TDG",
              "demoorg",
              "compose-file-test",
              0
            ]
          ]
        }
      ]
    }
  ]

}

```

The structure is as follows:


`data`: This is the top-level key that all returned data will be presented beneath.

- `series`: This is the level below data and contains information on the metrics you have requested.
- `columns`: An array of the columns that are being presented. This occurs once in the series.
- `name`: The name of the metric being returned. This can occur several times in the series, depending on the metrics selected.
- `values`: An array of the values that correspond to the keys specified in the columns section. This can occur several times in the series, depending on the time/intervals selected.



### Converting Data to Line Format

To load this data into a TSDB we will need to transform it into a format that the DB understands. For our example, we will be changing this data into InfluxDB's [Line Protocol](https://docs.influxdata.com/influxdb/v2.0/reference/syntax/line-protocol/). To do this, we will need to parse the JSON output. To accomplish this, we will be using the [jq](https://stedolan.github.io/jq/) utility, along with [awk](https://ss64.com/osx/awk.html). This could also be accomplished using other JSON and text processing tools if desired.

**Note:** This document is not intended to guide the usage of `jq`. The example presented here has been tested and works correctly with the MobiledgeX API's JSON output. This particular example is parsing memory information.

#### Line Protocol Definition

In its simplest form line protocol provides the name of the metric, a list of one or more key/value paris of tags, a list of one or more key/value pairs of measurements, and an optional timestamp. The syntax is defined as:

```
&lt;measurement&gt;[,&lt;tag_key&gt;=&lt;tag_value&gt;[,&lt;tag_key&gt;=&lt;tag_value&gt;]] &lt;field_key&gt;=&lt;field_value&gt;[,&lt;field_key&gt;=&lt;field_value&gt;] [&lt;timestamp&gt;]

```

For our purposes we will be constructing a very basic data payload. The following is an example of what that payload will look like for the memory metric:

```
mem.app=compose-file-test,ver=10 mem="1990197"

```

#### Conversion

We will use the `jq` utility to convert our data; the following line will take as input the data returned from the MobiledgeX API and parse the JSON to prepare it for final transformation:

```
jq -r  '.data[0].Series[0] | (.columns | map(.)) as $headers| .values | \
 map(. as $row | $headers | with_entries({"key": .value, "value": $row[.key]})) |\
 {measurement: "mem", mem: .[].mem | tostring, app: .[].app, ver: .[].ver, \
 timestamp: .[].time }| \
 to_entries|map(.value)|@csv

```

#### Breaking down that command, we are doing the following:

- Telling `jq` to provide the output in raw format (-r) so we can parse the output with `awk`.
- Breaking the data into key/value pairs from the input data provided by the `column` array and array(s) of `values` (Lines 1-2).
- Creating a new data object containing the measurement, application, version, timestamp, and metric value (Line 3).
- Dumping the new data object to CSV output (Line 4).

This provides us with the following output:

```
"mem","1990197","compose-file-test","10","2020-08-11T15:15:59.135953533Z"

```

The next step is finalizing the conversion. To do this we need to manipulate the data into the Line Protocol format. We will be using `awk` to complete the transformation:

```
awk -F, '{gsub("\"","",$0);printf("%s.app=%s,ver=%s mem=\"%s\"\n",$1,$3,$4,$2)}'

```

Breaking down that command, we are doing the following:

- Using `,` as our separator character.
- Re-ordering the output and adding headers.


The final output to be sent to InfluxDB is:

```
mem.app=compose-file-test,ver=10 mem="1990197"

```

#### Timestamps

The reason we are allowing the InfluxDB installation to generate a timestamp rather than using the value returned from the API is due to the way that the MobiledgeX API provides the timestamp, and the way that InfluxDB requires timestamps to be presented.

The MobiledgeX API provides timestamps in [RFC3339](https://tools.ietf.org/html/rfc3339) format, whereas InfluxDB wants the timestamps to be in [Unix Epoch](https://en.wikipedia.org/wiki/Unix_time#:~:text=Unix%20time%20,also%20known%20as,UTC%20on%201%20January%201970) format. Although it is possible to convert between these two (for example, using the GNU [date](https://www.gnu.org/software/coreutils/manual/html_node/Examples-of-date.html) program), this has not been done in this POC script to keep the complexity low.

#### Loading Data to InfluxDB

The InfluxDB API can be used to load the processed data into InfluxDB. The format for inserting data into InfluxDB using curl is:

```
curl -i -XPOST 'http://localhost:8086/write?db=mex'
--data-binary 'measurement-name.tag1=value1,tag2=value2 value=123 1434055562000000000'

```

Breaking down the command, we are doing the following:

- Issuing a POST to the server listening on port 8086 on the localhost.
- Using the `--data-binary` flag to enables us to pass data without it being interpreted.
- The `-i` flag shows us the return headers from the server (useful in debugging).
The string passed conforms to the syntax described above under "Line Protocol".
For this test, we are going to be inserting the following data:

```
mem.app=compose-file-test,ver=10 mem="1990197"

```

To do this, we can write the following cURL command:

```
$ curl -i -XPOST 'http://localhost:8086/write?db=mex' --data-binary  'mem.app=compose-file-test,ver=10 mem="1990197"'
HTTP/1.1 204 No Content
Content-Type: application/json
Request-Id: de38aed6-dc1d-11ea-8002-acde48001122
X-Influxdb-Build: OSS
X-Influxdb-Version: v1.8.1
X-Request-Id: de38aed6-dc1d-11ea-8002-acde48001122
Date: Tue, 11 Aug 2020 21:59:02 GMT

```

The 204 return code indicates that the data was accepted.

#### Verification

There are several ways to verify the data being added to InfluxDB. Visualization tools such as [Grafana](https://grafana.com/) or [Chronograf](https://www.influxdata.com/time-series-platform/chronograf/) can be used, as can the `influx` CLI utility. For this example, we are going to use the CLI.

```
$ influx
Connected to http://localhost:8086 version v1.8.1
InfluxDB shell version: v1.8.1
&gt; use mex;
Using database mex
&gt; SELECT * FROM "mex"."autogen"."mem.app=compose-file-test" WHERE  "ver"='10' limit 1;
name: mem.app=compose-file-test
time                mem     ver
----                ---     ---
1597096338602015000 1990197 10
&gt;

```

### Putting it Together

The following script uses all of the components that have been discussed in this document. Again, please note that this is intended as a proof of concept demonstration only and is not intended for production usage.

```

#!/usr/bin/env bash

###########################################################################

#
# This is a simple shell script to show the process of pulling data from the MeX

# metrics API endpoint and pushing them into a local influxdb data store.

#
# This script is intended as a demonstration of how this process can be

# accomplished. This is not intended to be a script that can be productionized without

# major rewriting.

#
# This script makes the following assumptions:

# 1\. You are able to use the `mcctl` program to access the MeX API.

# 2\. You have authenticated the `mcctl` program and saved an access token;

#    this script does not authenticate.

# 3\. You have an influxdb server running on the standard port (8086)

# 4\. There is no security on the influxdb database.

# 5\. You have an existing database called `mex` without security.

#
# The script performs the following tasks:

# 1\. Connects to the api and pulls the most recent update for the given metric.

# 2\. Transforms the returned data using `jq` and `awk` to create influxdb line

#    protocol compatible output.

# 3\. Writes the resulting data into the influxdb `mex` database using `curl`

#
# Notes:

# 1\. Influxdb does not accept RFC3339 formatted dates as returned by the MeX API;

#    Because of this the example allows influxdb to generate a timestamp. In an

#    actual production implementation you would want to use the MeX provided

#    timestamp, which can be converted to epoch time using either the GNU `date`

#    command, or programatically.

#
###########################################################################

# General Variables

MCCTL=/usr/local/bin/mcctl
JQ=/usr/local/bin/jq
INFLUXDB=mex
INFLUXURI=http://localhost:8086

# MeX Vars

APPNAME=compose-file-test
APPVER="1.0"
APPORG=demoorg
REGION=EU
CONSOLE="https://console.mobiledgex.net"
MCCTLCONS="$MCCTL --addr $CONSOLE --output-format json metrics app region=$REGION app-org=$APPORG appname=$APPNAME appvers=$APPVER last=1"

#cURL
CURLC="curl -X POST  -d @- http://localhost:8086/write?db=mex"

# CPU

$MCCTLCONS selector=cpu | $JQ -r '.data[0].Series[0] | (.columns | map(.)) as $headers| .values | map(. as $row | $headers | with_entries({"key": .value, "value": $row[.key]}))| {measurement: "cpu", cpu: .[].cpu | tostring, app: .[].app, ver: .[].ver, timestamp: .[].time }| to_entries|map(.value)|@csv' | awk -F, '{gsub("\"","",$0);printf("%s.app=%s,ver=%s mem=\"%s\"\n",$1,$3,$4,$2)}' | $CURLRC

# MEM

$MCCTLCONS selector=mem | $JQ -r  '.data[0].Series[0] | (.columns | map(.)) as $headers| .values | map(. as $row | $headers | with_entries({"key": .value, "value": $row[.key]}))| {measurement: "mem", mem: .[].mem | tostring, app: .[].app, ver: .[].ver, timestamp: .[].time }| to_entries|map(.value)|@csv' | awk -F, '{gsub("\"","",$0);printf("%s.app=%s,ver=%s mem=\"%s\"\n",$1,$3,$4,$2)}' | $CURLRC

# NET

$MCCTLCONS selector=network | $JQ -r  '.data[0].Series[0] | (.columns | map(.)) as $headers| .values | map(. as $row | $headers | with_entries({"key": .value, "value": $row[.key]}))| {measurement: "recvBytes", recvBytes: .[].recvBytes | tostring, app: .[].app, ver: .[].ver, timestamp: .[].time }| to_entries|map(.value)|@csv' | awk -F, '{gsub("\"","",$0);printf("%s.app=%s,ver=%s mem=\"%s\"\n",$1,$3,$4,$2)}' | $CURLRC
$MCCTLCONS selector=network | $JQ -r  '.data[0].Series[0] | (.columns | map(.)) as $headers| .values | map(. as $row | $headers | with_entries({"key": .value, "value": $row[.key]}))| {measurement: "sendBytes", sendBytes: .[].sendBytes | tostring, app: .[].app, ver: .[].ver, timestamp: .[].time }| to_entries|map(.value)|@csv' | awk -F, '{gsub("\"","",$0);printf("%s.app=%s,ver=%s mem=\"%s\"\n",$1,$3,$4,$2)}' | $CURLRC

# Disk

$MCCTLCONS selector=disk | $JQ -r  '.data[0].Series[0] | (.columns | map(.)) as $headers| .values | map(. as $row | $headers | with_entries({"key": .value, "value": $row[.key]}))| {measurement: "disk", disk: .[].disk | tostring, app: .[].app, ver: .[].ver, timestamp: .[].time }| to_entries|map(.value)|@csv' | awk -F, '{gsub("\"","",$0);printf("%s.app=%s,ver=%s mem=\"%s\"\n",$1,$3,$4,$2)}' | $CURLRC

```

### Other Datastores

The same techniques shown here can be used to write data from the MobiledgeX metrics API to any other datastore, provided can create an ETL pipeline to load data into your datastore of choice.

## Writing Metrics to CSV

This example shows how to export metrics from the MobiledgeX API and write them to a CSV file, suitable for import to the spreadsheet or analysis program of your choice.

Metrics pulled will include:

- CPU
- MEM
- Disk
- Network
- Connections

## Exclusions

The example script provided is not suited for production use, and is intended solely as a proof of concept. Additionally, please be aware of the following additional limitations of the script:

- Samples are taken at 10-second intervals.
- Metrics being sampled are CPU, disk, network, and memory.
- The script assumes you have logged into the MobiledgeX console with mcctl and have an active JWT token.
- The script relies on data being returned in json format from the mcctl utility.
- Please see the script header for additional information.

## Assumptions

- You have the mcctl utility installed.
- You have an account with access to the application you wish to monitor.
- You have an InfluxDB installation with a database named mex.
- You can read/write to/from the InfluxDB database.

## Script Flow

The script flow is very simple:

- Pull data from the MobiledgeX API.
- Transform the data into CSV.
- Write the data out to *.csv files for each metric class.
- Sleep for 30 seconds.
- Return to step 1.


## Usage

The first step is to define the variables for your use case.

### Data Output

The following variables define the CSV files to write to; note that the script will clear out any existing data at startup.

`cpuCSV`
`memCSV`
`diskCSV`
`networkCSV`
`connectionsCSV`

### Application Detail

The following variables define the application to be monitored.

`theregion`
`theapporg`
`theappname`
`theappvers`

As written, the script runs at 30 second intervals and loops 80 times, which will result in a run time of roughly 40 minutes for data collection. Note that this is a rough estimate only, since the script does not take into account the amount of time the metrics collection takes. If you wish to change this, the relevant line to modify is `for KOUNT in {1..80} ; do`

Once you have adjusted the script appropriately, your next steps are:

- Using mcctl, login to console.mobiledgex.net which will generate a JWT token for you to use.
- Run the script.


Once the script has completed it’s run you can use the CSV files for analysis as required. Note that the script can be interrupted at any time; the data is written to the files as it is received (ie, there is no buffering in the script).

```

### Data Collection Script

#!/bin/env bash

###########################################################################

#
# This is a simple shell script to show the process of pulling data from the MeX

# metrics API endpoint, converting it to CSV, and writing it to a file.

#
# This script is intended as a demonstration of how this process can be

# accomplished. This is not intended to be a script that can be productionized without

# major rewriting.

#
# Version 1.0

# JAS

# 20-Aug-2020

###########################################################################

##

# Output Files

##
export cpuCSV=cpu.csv
export memCSV=mem.csv
export diskCSV=disk.csv
export networkCSV=network.csv
export connectionsCSV=connections.csv

##

# Application Information

##
export theregion=EU
export theapporg=demoorg
export theappname=healthcheck
export theappvers=2.0

##

# Put Headers into the CSV

##
echo "time, app, ver, cluster, clusterorg, cloudlet, cloudletorg, apporg, pod, cpu" &gt; $cpuCSV
echo "time, app, ver, cluster, clusterorg, cloudlet, cloudletorg, apporg, pod, sendBytes, recvBytes" &gt; $network.csv
echo "time, app, ver, cluster, clusterorg, cloudlet, cloudletorg, apporg, pod, mem"  &gt; $memCSV
echo "time, app, ver, cluster, clusterorg, cloudlet, cloudletorg, apporg, pod, disk"  &gt; $diskCSV
echo "time, app, ver, cluster, clusterorg, cloudlet, cloudletorg, apporg, pod, port, active, handled, accepts, bytesSent, bytesRecvd, P0, P0, P25, P50, P75, P90, P95, P99, P99.5, P99.9, P100" &gt; $connectionsCSV

###

# Loop 80 Times; at 30 second loops this is roughly 40 minutes.

# Note that this will run longer than 40 minutes, since the time

# spent in the API calls.

###
for KOUNT in {1..80} ; do
echo Stats Being pulled at $(date)

# CPU

mcctl --addr https://console.mobiledgex.net  --output-format json metrics app  region=$theregion app-org=$theapporg  appname=$theappname appvers=$theappvers last=1 selector=cpu| jq -r  '.data[0].Series[0] | (.columns | map(.)) as $headers| .values | map(. as $row | $headers | with_entries({"key": .value, "value": $row[.key]})) | {"time": .[].time | tostring, "app": .[].app | tostring, "ver": .[].ver | tostring, "cluster": .[].cluster | tostring, "clusterorg": .[].clusterorg | tostring, "cloudlet": .[].cloudlet | tostring, "cloudletorg": .[].cloudletorg | tostring, "apporg": .[].apporg | tostring, "pod": .[].pod | tostring, "cpu": .[].cpu | tostring} | to_entries|map(.value)|@csv' &gt;&gt; $cpuCSV

# MEM

mcctl --addr https://console.mobiledgex.net  --output-format json metrics app  region=$theregion app-org=$theapporg  appname=$theappname appvers=$theappvers last=1 selector=mem | jq -r  '.data[0].Series[0] | (.columns | map(.)) as $headers| .values | map(. as $row | $headers | with_entries({"key": .value, "value": $row[.key]})) | {"time": .[].time | tostring, "app": .[].app | tostring, "ver": .[].ver | tostring, "cluster": .[].cluster | tostring, "clusterorg": .[].clusterorg | tostring, "cloudlet": .[].cloudlet | tostring, "cloudletorg": .[].cloudletorg | tostring, "apporg": .[].apporg | tostring, "pod": .[].pod | tostring, "mem": .[].mem | tostring} | to_entries|map(.value)|@csv' &gt;&gt; $memCSV

# Disk

mcctl --addr https://console.mobiledgex.net  --output-format json metrics app  region=$theregion app-org=$theapporg  appname=$theappname appvers=$theappvers last=1 selector=disk| jq -r  '.data[0].Series[0] | (.columns | map(.)) as $headers| .values | map(. as $row | $headers | with_entries({"key": .value, "value": $row[.key]})) | {"time": .[].time | tostring, "app": .[].app | tostring, "ver": .[].ver | tostring, "cluster": .[].cluster | tostring, "clusterorg": .[].clusterorg | tostring, "cloudlet": .[].cloudlet | tostring, "cloudletorg": .[].cloudletorg | tostring, "apporg": .[].apporg | tostring, "pod": .[].pod | tostring, "disk": .[].disk | tostring} | to_entries|map(.value)|@csv' &gt;&gt; $diskCSV

# Network

mcctl --addr https://console.mobiledgex.net  --output-format json metrics app  region=$theregion app-org=$theapporg  appname=$theappname appvers=$theappvers last=1 selector=network | jq -r  '.data[0].Series[0] | (.columns | map(.)) as $headers| .values | map(. as $row | $headers | with_entries({"key": .value, "value": $row[.key]})) | {"time": .[].time | tostring, "app": .[].app | tostring, "ver": .[].ver | tostring, "cluster": .[].cluster | tostring, "clusterorg": .[].clusterorg | tostring, "cloudlet": .[].cloudlet | tostring, "cloudletorg": .[].cloudletorg | tostring, "apporg": .[].apporg | tostring, "pod": .[].pod  | tostring, "sendBytes": .[].sendBytes | tostring, "recvBytes": .[].recvBytes | tostring} | to_entries|map(.value)|@csv' &gt;&gt; $networkCSV

# Connections

mcctl --addr https://console.mobiledgex.net  --output-format json metrics app  region=$theregion app-org=$theapporg  appname=$theappname appvers=$theappvers last=1 selector=connections | jq -r  '.data[0].Series[0] | (.columns | map(.)) as $headers| .values | map(. as $row | $headers | with_entries({"key": .value, "value": $row[.key]})) | {"time": .[].time | tostring, "app": .[].app | tostring, "ver": .[].ver | tostring, "cluster": .[].cluster | tostring, "clusterorg": .[].clusterorg | tostring, "cloudlet": .[].cloudlet | tostring, "cloudletorg": .[].cloudletorg | tostring, "apporg": .[].apporg | tostring, "pod": .[].pod  | tostring, "port": .[].port | tostring, "active": .[].active | tostring, "handled": .[].handled | tostring, "accepts": .[].accepts | tostring, "bytesSent": .[].bytesSent | tostring, "bytesRecvd": .[].bytesRecvd | tostring, "P0": .[].PO | tostring | tostring, "P0": .[].P0 | tostring, "P25": .[].P25 | tostring, "P50": .[].P50 | tostring, "P75": .[].P75 | tostring, "P90": .[].P90 | tostring, "P95": .[].P95 | tostring, "P99": .[].P99 | tostring, "P99.5": .[]."P99.5" | tostring, "P99.9": .[]."P99.9" | tostring, "P100": .[].P100 | tostring} | to_entries|map(.value)|@csv' &gt;&gt; $connectionsCSV
echo "Sleeping for 15 seconds"
sleep 15
echo "Finished Loop $KOUNT"
done

```

## Contact support

If you have reviewed our [documentation set](/developer) and [FAQ](https://developers.mobiledgex.com/support/index.md) page, and unable to find an answer to your question, you can contact our [Support Team](mailto:support@mobiledgex.com).

You can also email the [Support Team](mailto:support@mobiledgex.com) to assist you in resolving product issues. To help expedite your request, make sure you copy and paste the tracid, which can be found on the audit logs page, into your email with a brief description of your issue.

