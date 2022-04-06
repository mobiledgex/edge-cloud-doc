---
title: Metric and Usage Commands
long_title:
overview_description:
description:
Learn about metric and usage commands with mcctl utility

---

## Metric Commands

The same metrics that are presented in the MobiledgeX Web GUI can be viewed from the CLI by using the metrics command to the `mcctl` utility.

The examples below request the output in JSON format, but it is possible to retrieve the data in YAML or condensed JSON (JSON without extra whitespace formatting).

**Note:** The `mcctl` utility provides a stable interface to the MobiledgeX APIs. The API can be accessed directly, but the API interface is subject to change.

`$ mcctl --addr https://console.mobiledgex.net metrics`

The metrics command will show metrics for:

- `clients`
- `applications`
- `clusters`
- `cloudlets`

All metrics commands can be qualified with a time or duration parameter.

- *last N* Shows the last N series of data.
- *starttime datetime* Start time of displayed data.
- *endtime datetime* End time of displayed data.

### Using Start/End Times

Several of the `mcctl` subcommands accept a start/end time to filter output. Time should be passed through in the format as outlined in [RFC 3339](https://tools.ietf.org/html/rfc3339). For example, to specify *10:35 PM UTC on August 7, 2019*, you would code the time as `2019-08-07T20:35:00Z`. Please note that the entire date/time string, including the time zone indicator, must be passed to the command.

### Application Level Metrics

```
Required Args:
  region        Region name
  app-org       Organization or Company name of the App
  selector      Comma separated list of metrics to view

Optional Args:
  appname       App name
  appvers       App version
  cluster       Cluster name
  cluster-org   Organization or Company Name that a Cluster is used by
  cloudlet      Name of the cloudlet
  cloudlet-org  Company or Organization name of the cloudlet
  last          Display the last X metrics
  starttime     Time to start displaying stats from
  endtime       Time up to which to display stats

```

#### Data Keys

- `time`
- `app`
- `ver`
- `cluster`
- `clusterorg`
- `cloudlet`
- `cloudletorg`
- `apporg`
- `pod`
- `cpu`
- `mem`
- `disk`
- `sendBytes`
- `recvBytes`

#### Example

```
$ mcctl  --addr [https://console.mobiledgex.net](https://console.mobiledgex.net)  --output-format json metrics app region=EU app/
org=demoorg selector=cpu,mem,disk,network last=1 appname=mexfastapi10

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
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "appinst-network",
          "values": [
            [
              "2020-06-08T22:16:46.88950592Z",
              "mexfastapi10",
              null,
              "fastapiCluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              "demoorg",
              "mexfastapi10",
              null,
              null,
              null,
              603979776,
              138412032
            ]
          ]
        },
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
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "appinst-mem",
          "values": [
            [
              "2020-06-08T22:16:46.88950592Z",
              "mexfastapi10",
              null,
              "fastapiCluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              "demoorg",
              "mexfastapi10",
              null,
              269588889,
              null,
              null,
              null
            ]
          ]
        },
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
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "appinst-disk",
          "values": [
            [
              "2020-06-08T22:16:46.88950592Z",
              "mexfastapi10",
              null,
              "fastapiCluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              "demoorg",
              "mexfastapi10",
              null,
              null,
              0,
              null,
              null
            ]
          ]
        },
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
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "appinst-cpu",
          "values": [
            [
              "2020-06-08T22:16:46.88950592Z",
              "mexfastapi10",
              null,
              "fastapiCluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              "demoorg",
              "mexfastapi10",
              0.24,
              null,
              null,
              null,
              null
            ]
          ]
        }
      ]
    }
  ]

}

```

#### CPU Example

AppInst CPU usage for an app with 2 containers. CPU value format is in percentages.

```
$ mcctl metrics app region=US appname=app-us-k8s  selector=cpu last=1 cluster=k8smonitoring cluster-org=testmonitor cloudlet-org=packet app-org=testmonitor
data:
- series:
  - columns:
    - time
    - app
    - ver
    - cluster
    - clusterorg
    - cloudlet
    - cloudletorg
    - apporg
    - pod
    - cpu
    name: appinst-cpu
    values:
    - - "2021-07-10T06:22:54.944999933Z"
      - app-us-k8s
      - v1
      - k8smonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - testmonitor
      - app-us-k8s-deployment-dvpdb
      - 9.169075980500652e-06

```

#### Memory Example

The current memory footprint of a given app instance in bytes.

```
$ mcctl metrics app region=US appname=app-us-k8s  selector=mem last=1 cluster=k8smonitoring cluster-org=testmonitor cloudlet-org=packet app-org=testmonitor
data:
- series:
  - columns:
    - time
    - app
    - ver
    - cluster
    - clusterorg
    - cloudlet
    - cloudletorg
    - apporg
    - pod
    - mem
    name: appinst-mem
    values:
    - - "2021-07-10T06:22:54.960000038Z"
      - app-us-k8s
      - v1
      - k8smonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - testmonitor
      - app-us-k8s-deployment-dvpdb
      - 3.014656e+06

```

#### Disk Example

The filesystem usage for an app instance in bytes.

```
$ mcctl metrics app region=US appname=app-us-k8s  selector=disk last=1 cluster=k8smonitoring cluster-org=testmonitor cloudlet-org=packet app-org=testmonitor
data:
- series:
  - columns:
    - time
    - app
    - ver
    - cluster
    - clusterorg
    - cloudlet
    - cloudletorg
    - apporg
    - pod
    - disk
    name: appinst-disk
    values:
    - - "2021-07-10T06:22:54.97600007Z"
      - app-us-k8s
      - v1
      - k8smonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - testmonitor
      - app-us-k8s-deployment-dvpdb
      - 1.35168e+06

```

#### Network example

Application instance Tx/Rx traffic rate in bytes/seconds averaged over 1 minute.

```
$ mcctl metrics app region=US appname=app-us-k8s  selector=network last=1 cluster=k8smonitoring cluster-org=testmonitor cloudlet-org=packet app-org=testmonitor
data:
- series:
  - columns:
    - time
    - app
    - ver
    - cluster
    - clusterorg
    - cloudlet
    - cloudletorg
    - apporg
    - pod
    - sendBytes
    - recvBytes
    name: appinst-network
    values:
    - - "2021-07-10T06:22:55.007999897Z"
      - app-us-k8s
      - v1
      - k8smonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - testmonitor
      - app-us-k8s-deployment-dvpdb
      - 22
      - 36

```

#### Active Connections Example

App instance connection information by port; number of accepted, active, and handled connections, as well as the total number of bytes that are sent/received, and a histogram of session times in milliseconds. For example, P50 is the 50th percentile in session time. In the example below, 50% of all sessions lasted 6ms or less.

```
$ mcctl metrics app region=US appname=app-us-k8s  selector=connections last=1 cluster=k8smonitoring cluster-org=testmonitor cloudlet-org=packet app-org=testmonitor
data:
- series:
  - columns:
    - time
    - app
    - ver
    - cluster
    - clusterorg
    - cloudlet
    - cloudletorg
    - apporg
    - port
    - active
    - handled
    - accepts
    - bytesSent
    - bytesRecvd
    - P0
    - P25
    - P50
    - P75
    - P90
    - P95
    - P99
    - P99.5
    - P99.9
    - P100
    name: appinst-connections
    values:
    - - "2021-07-10T06:22:54.96920476Z"
      - app-us-k8s
      - v1
      - k8smonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - testmonitor
      - 8080
      - 0
      - 22971
      - 22971
      - 4.386043e+06
      - 4.223098e+06
      - 2
      - 28.37329784151818
      - 28.789258293495582
      - 29.412349003056324
      - 29.913826226167952
      - 31.095333333333336
      - 85.29000000000087
      - 217.76320754716988
      - 1902.8999999998632
      - 1.7e+06

```

#### API Example

- Valid selector: `api`
- Valid method names: `RegisterClient`, `VerifyLocation`, `FindCloudlet`, `GetLocation`, `AppinstList`, `FqdnList`, `DynamicLocGroup`, `QosPosition`.
- `Cellid` 0 is invalid.

#### FindCloudlet Example

```
$ mcctl --addr https://console.mobiledgex.net  --output-format json metrics clientapiusage region=EU appname=healthcheck appvers=3.1 app-org=demoorg method=FindCloudlet selector=api
{
  "data": [
    {
      "Series": [
        {
          "columns": [
            "time",
            "reqs",
            "errs"
          ],
          "name": "dme-api",
          "tags": {
            "app": "healthcheck",
            "apporg": "demoorg",
            "cellID": "",
            "cloudlet": "mexplat-mexdemo-cloudlet",
            "cloudletorg": "TDG",
            "dmeId": "dme-68c4585d98-48r9c",
            "foundCloudlet": "",
            "foundOperator": "",
            "method": "FindCloudlet",
            "ver": "3.1"
          },
          "values": [
            [
              "2022-03-22T09:36:29.67647683Z",
              2,
              0
            ],
            [
              "2022-03-22T09:35:59.676135779Z",
              1,
              0
            ]
          ]
        }
      ]
    }
  ]

}
```

- `100ms, 10ms, 25ms, 50ms, 5ms`: Latency buckets for the API call RTT
- `cellID`: Cell Id of the tower where the API request came from. This can be used in geolocation grouping.
- `errs`: Number of errors returned for this AppInst, method, and cellID for this timestamp
- `foundCloudlet`: Cloudlet name that was returned as a result of this FindCloudlet api call
- `foundOperator`: Operator name that was returned as a result of this FindCloudlet api call
- `id`: Hostname where DME is(Unused)
- `inf`: UNUSED
- `method`: One of `RegisterClient`, `VerifyLocation`, `FindCloudlet`, `GetLocation`, `AppInstList`, `FqdnList`, `DynamicLocGroup`, `QosPosition`
- `oper`: Operator name where the DME is
- `reqs`: Number of requests sent since last collection

#### RegisterClient Example

```
$ mcctl --addr https://console.mobiledgex.net  --output-format json metrics clientapiusage region=EU appname=healthcheck appvers=3.1 app-org=demoorg method=RegisterClient selector=api
{
  "data": [
    {
      "Series": [
        {
          "columns": [
            "time",
            "reqs",
            "errs"
          ],
          "name": "dme-api",
          "tags": {
            "app": "healthcheck",
            "apporg": "demoorg",
            "cellID": "",
            "cloudlet": "mexplat-mexdemo-cloudlet",
            "cloudletorg": "TDG",
            "dmeId": "dme-68c4585d98-48r9c",
            "foundCloudlet": "",
            "foundOperator": "",
            "method": "RegisterClient",
            "ver": "3.1"
          },
          "values": [
            [
              "2022-03-22T09:36:29.67647683Z",
              2,
              0
            ],
            [
              "2022-03-22T09:35:59.676135779Z",
              1,
              0
            ]
          ]
        }
      ]
    }
  ]

}
```

**Note:** `foundCloudlet` and `foundOperator` fields are “null“, these are only available for FindCloudlet method.

**All methods example with start and end time, rather than last N elements**

```

# mcctl --addr https://console.mobiledgex.net  --output-format json metrics clientapiusage region=EU appname=healthcheck appvers=3.1 app-org=demoorg selector=api

{
  "data": [
    {
      "Series": [
        {
          "columns": [
            "time",
            "reqs",
            "errs"
          ],
          "name": "dme-api",
          "tags": {
            "app": "healthcheck",
            "apporg": "demoorg",
            "cellID": "",
            "cloudlet": "mexplat-mexdemo-cloudlet",
            "cloudletorg": "TDG",
            "dmeId": "dme-68c4585d98-48r9c",
            "foundCloudlet": "",
            "foundOperator": "",
            "method": "RegisterClient",
            "ver": "3.1"
          },
          "values": [
            [
              "2022-03-22T09:36:29.67647683Z",
              2,
              0
            ],
            [
              "2022-03-22T09:35:59.676135779Z",
              1,
              0
            ]
          ]
        },
        {
          "columns": [
            "time",
            "reqs",
            "errs"
          ],
          "name": "dme-api",
          "tags": {
            "app": "healthcheck",
            "apporg": "demoorg",
            "cellID": "",
            "cloudlet": "mexplat-mexdemo-cloudlet",
            "cloudletorg": "TDG",
            "dmeId": "dme-68c4585d98-48r9c",
            "foundCloudlet": "",
            "foundOperator": "",
            "method": "FindCloudlet",
            "ver": "3.1"
          },
          "values": [
            [
              "2022-03-22T09:36:29.67647683Z",
              2,
              0
            ],
            [
              "2022-03-22T09:35:59.676135779Z",
              1,
              0
            ]
          ]
        }
      ]
    }
  ]

}
```

**Note:** This allows for a single call with all the results.

### Client App Usage Metrics

This command is used to collect aggregated latency and device metrics about clients connected to application instances.

```
mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) metrics clientappusage -h
View client App usage

Usage: mcctl metrics clientappusage [flags] [args]

Required Args:
  region           Region name
  selector         Comma separated list of metrics to view. Available metrics: "latency", "deviceinfo", "custom"

Optional Args:
  appname          App name
  appvers          App version
  app-org          Organization or Company name of the App
  cluster          Cluster name
  cluster-org      Organization or Company Name that a Cluster is used by
  cloudlet         Name of the cloudlet
  cloudlet-org     Company or Organization name of the cloudlet
  locationtile     Location tile. Provides the range of GPS coordinates for the location tile/square. Format is:
                   "LocationUnderLongitude,LocationUnderLatitude_LocationOverLongitude,LocationOverLatitude_LocationTileLength".
                   LocationUnder are the GPS coordinates of the corner closest to (0,0) of the location tile. LocationOver are the GPS
                   coordinates of the corner farthest from (0,0) of the location tile. LocationTileLength is the length (in kilometers) of
                   one side of the location tile square. Can be used for selectors: latency.
  deviceos         Device operating system. Can be used for selectors: deviceinfo.
  devicemodel      Device model. Can be used for selectors: deviceinfo.
  devicecarrier    Device carrier. Can be used for selectors: deviceinfo.
  datanetworktype  Data network type used by client device. Can be used for selectors: latency, deviceinfo.
  limit            Display the last X metrics
  numsamples       Display X samples spaced out evenly over start and end times
  starttime        Time to start displaying stats from in RFC3339 format (ex. 2002-12-31T15:00:00Z)
  endtime          Time up to which to display stats in RFC3339 format (ex. 2002-12-31T10:00:00-05:00)
  startage         Relative age from now of search range start (default 48h)
  endage           Relative age from now of search range end (default 0)

Flags:
  -h, --help   help for clientappusage

```

```
mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) metrics clientappusage region=US selector=latency app-org=automation_dev_org limit=1
data:
- series:
  - columns:
    - time
    - 0s
    - 5ms
    - 10ms
    - 25ms
    - 50ms
    - 100ms
    - max
    - min
    - avg
    - variance
    - stddev
    - numsamples
    name: latency-metric
    tags:
      app: app1626203266-6561713
      apporg: automation_dev_org
      cloudlet: tmocloud-2
      cloudletorg: tmus
      cluster: autocluster
      clusterorg: MobiledgeX
      datanetworktype: 5G
      locationtile: -90.998922,30.993940_-91.007905,31.002985_1
      ver: "1.0"
    values:
    - - "2021-07-13T19:08:10.100185182Z"
      - 4
      - 2
      - 2
      - 2
      - 0
      - 4
      - 440
      - 0.5
      - 94.50714285714287
      - 24799.08494505494
      - 157.47725215108034
      - 14

```

### Client API Usage Metrics

```
$ mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) metrics clientapiusage
Error: missing required args: region selector
Usage: mcctl metrics clientapiusage [flags] [args]

Required Args:
  region        Region name
  selector      Comma separated list of metrics to view. Currently only "api" is supported.

Optional Args:
  appname       App name
  appvers       App version
  app-org       Organization or Company name of the App
  cluster       Cluster name
  cluster-org   Organization or Company Name that a Cluster is used by
  cloudlet      Name of the cloudlet
  cloudlet-org  Company or Organization name of the cloudlet
  method        Api call method, one of: FindCloudlet, PlatformFindCloudlet, RegisterClient, VerifyLocation
  cellid        Cell tower Id(experimental)
  limit         Display the last X metrics
  numsamples    Display X samples spaced out evenly over start and end times
  starttime     Time to start displaying stats from in RFC3339 format (ex. 2002-12-31T15:00:00Z)
  endtime       Time up to which to display stats in RFC3339 format (ex. 2002-12-31T10:00:00-05:00)
  startage      Relative age from now of search range start (default 48h)
  endage        Relative age from now of search range end (default 0)

Flags:
  -h, --help   help for clientapiusage

```

### Client Cloudlet API Usage

```
$ mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) metrics clientcloudletusage
Error: missing required args: selector region cloudlet-org
Usage: mcctl metrics clientcloudletusage [flags] [args]

Required Args:
  region           Region name
  cloudlet-org     Company or Organization name of the cloudlet
  selector         Comma separated list of metrics to view. Available metrics: "latency", "deviceinfo"

Optional Args:
  cloudlet         Name of the cloudlet
  locationtile     Location tile. Provides the range of GPS coordinates for the location tile/square. Format is: "LocationUnderLongitude,LocationUnderLatitude_LocationOverLongitude,LocationOverLatitude_LocationTileLength". LocationUnder are the GPS coordinates of the corner closest to (0,0) of the location tile. LocationOver are the GPS coordinates of the corner farthest from (0,0) of the location tile. LocationTileLength is the length (in kilometers) of one side of the location tile square. Can be used for selectors: latency, deviceinfo.
  deviceos         Device operating system. Can be used for selectors: deviceinfo.
  devicemodel      Device model. Can be used for selectors: deviceinfo.
  devicecarrier    Device carrier. Can be used for selectors: latency, deviceinfo.
  datanetworktype  Data network type used by client device. Can be used for selectors: latency.
  limit            Display the last X metrics
  numsamples       Display X samples spaced out evenly over start and end times
  starttime        Time to start displaying stats from in RFC3339 format (ex. 2002-12-31T15:00:00Z)
  endtime          Time up to which to display stats in RFC3339 format (ex. 2002-12-31T10:00:00-05:00)
  startage         Relative age from now of search range start (default 48h)
  endage           Relative age from now of search range end (default 0)

Flags:
  -h, --help   help for clientcloudletusage

```

### Cluster Level Metrics

```
Required Args:
  region        Region name
  cluster-org   Organization or Company Name that a Cluster is used by
  selector      Comma separated list of metrics to view

Optional Args:
  cluster       Cluster name
  cloudlet-org  Company or Organization name of the cloudlet
  cloudlet      Name of the cloudlet
  last          Display the last X metrics
  starttime     Time to start displaying stats from
  endtime       Time up to which to display stats

```

#### Data Keys

- `time`
- `cluster`
- `clusterorg`
- `cloudlet`
- `cloudletorg`
- `cpu`
- `mem`
- `disk`
- `sendBytes`
- `recvBytes`

#### Example

```
$ mcctl  --addr [https://console.mobiledgex.net](https://console.mobiledgex.net)  --output-format json metrics cluster \
region=EU cluster-org=demoorg selector=cpu,mem,disk,network, tcp, udp last=1
{
  "data": [
    {
      "Series": [
        {
          "columns": [
            "time",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "cluster-network",
          "values": [
            [
              "2020-06-08T22:22:38.972597948Z",
              "action-test-cluster",
              "demoorg",
              "munich-main",
              "TDG",
              null,
              null,
              null,
              675353748,
              30297980534
            ]
          ]
        },
        {
          "columns": [
            "time",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "cluster-mem",
          "values": [
            [
              "2020-06-08T22:22:38.972597948Z",
              "action-test-cluster",
              "demoorg",
              "munich-main",
              "TDG",
              null,
              6.191279821549256,
              null,
              null,
              null
            ]
          ]
        },
        {
          "columns": [
            "time",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "cluster-disk",
          "values": [
            [
              "2020-06-08T22:22:38.972597948Z",
              "action-test-cluster",
              "demoorg",
              "munich-main",
              "TDG",
              null,
              null,
              15.501801142916749,
              null,
              null
            ]
          ]
        },
        {
          "columns": [
            "time",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "cluster-cpu",
          "values": [
            [
              "2020-06-08T22:22:38.972597948Z",
              "action-test-cluster",
              "demoorg",
              "munich-main",
              "TDG",
              0,
              null,
              null,
              null,
              null
            ]
          ]
        }
      ]
    }
  ]

}
```

#### API Example

- Valid selector: `api`
- Valid method names: `RegisterClient`, `VerifyLocation`, `FindCloudlet`, `GetLocation`, `AppinstList`, `FqdnList`, `DynamicLocGroup`, `QosPosition`.
- `Cellid` 0 is invalid.

**FindCloudlet Example**

```
$ http --verify=false --auth-type=jwt --auth=$SUPERPASS POST [https://console.mobiledgex.net/api/v1/auth/metrics/client](https://console.mobiledgex.net/api/v1/auth/metrics/client) &lt;&lt;&lt;\
 {"region":"local","appinst":{"app_key":{"organization":"AcmeAppCo","name":\
 "someapplication1","version":"1.0"}},"method":"FindCloudlet","selector":"api","last":1}’\
 HTTP/1.1 200 OK

Content-Type: application/json
Date: Sun, 19 Apr 2020 01:45:04 GMT
Transfer-Encoding: chunked
{
    "data": [
        {
            "Messages": null,
            "Series": [
                {
                    "columns": [
                        "time",
                        "100ms",
                        "10ms",
                        "25ms",
                        "50ms",
                        "5ms",
                        "app",
                        "apporg",
                        "cellID",
                        "cloudlet",
                        "cloudletorg",
                        "errs",
                        "foundCloudlet",
                        "foundOperator",
                        "inf",
                        "method",
                        "reqs",
                        "ver"
                    ],
                    "name": "dme-api",
                    "values": [
                        [
                            "2020-04-19T01:42:21.588926Z",
                            0,
                            0,
                            0,
                            0,
                            2,
                            "someapplication1",
                            "AcmeAppCo",
                            "1234",
                            "tmus-cloud-1",
                            "tmus",
                            0,
                            "tmus-cloud-2",
                            "tmus",
                            0,
                            "FindCloudlet",
                            2,
                            "1.0"
                        ]
                    ]
                }
            ]
        }
    ]

}

```

- `100ms, 10ms, 25ms, 50ms, 5ms`: Latency buckets for the API call RTT
- `cellID`: Cell Id of the tower where the API request came from. This can be used in geolocation grouping.
- `err`: Number of errors returned for this AppInst, method, and cellID for this timestamp
- `foundCloudlet`: Cloudlet name that was returned as a result of this FindCloudlet api call
- `foundOperator`: Operator name that was returned as a result of this FindCloudlet api call
- `id`: Hostname where DME is(Unused)
- `inf`: UNUSED
- `method`: One of `RegisterClient`, `VerifyLocation`, `FindCloudlet`, `GetLocation`, `AppInstList`, `FqdnList`, `DynamicLocGroup`, `QosPosition`
- `oper`: Operator name where the DME is
- `reqs`: Number of requests sent since last collection

**RegisterClient Example**

```
$ http --verify=false --auth-type=jwt --auth=$SUPERPASS POST [https://console.mobiledgex.net/api/v1/auth/metrics/client](https://console.mobiledgex.net/api/v1/auth/metrics/client) &lt;&lt;&lt;\
’{"region":"local","appinst":{"app_key":{"organization":"AcmeAppCo","name":\
"someapplication1","version":"1.0"}},"method":"RegisterClient","selector":"api","last":1}’\
HTTP/1.1 200 OK
Content-Type: application/json
Date: Sun, 19 Apr 2020 01:46:13 GMT
Transfer-Encoding: chunked
{
    "data": [
        {
            "Messages": null,
            "Series": [
                {
                    "columns": [
                        "time",
                        "100ms",
                        "10ms",
                        "25ms",
                        "50ms",
                        "5ms",
                        "app",
                        "apporg",
                        "cellID",
                        "cloudlet",
                        "cloudletorg",
                        "errs",
                        "foundCloudlet",
                        "foundOperator",
                        "inf",
                        "method",
                        "reqs",
                        "ver"
                    ],
                    "name": "dme-api",
                    "values": [
                        [
                            "2020-04-19T01:42:21.588926Z",
                            0,
                            0,
                            0,
                            0,
                            4,
                            "someapplication1",
                            "AcmeAppCo",
                            "1234",
                            "tmus-cloud-1",
                            "tmus",
                            0,
                            null,
                            null,
                            0,
                            "RegisterClient",
                            4,
                            "1.0"
                        ]
                    ]
                }
            ]
        }
    ]

}

```

**Note:** `foundCloudlet` and `foundOperator` fields are “null“, these are only available for FindCloudlet method.

**All methods example with start and end time, rather than last N elements**

```
$ http --verify=false --auth-type=jwt --auth=$SUPERPASS POST [https://console.mobiledgex.net/api/v1/auth/metrics/client](https://console.mobiledgex.net/api/v1/auth/metrics/client) &lt;&lt;&lt;\
’{"region":"local","appinst":{"app_key":{"organization":"AcmeAppCo","name":\
"someapplication1","version":"1.0"}},"selector":"api","starttime":"2020-04-\
19T01:42:21Z","endtime":"2020-04-19T01:42:22Z"}’\
HTTP/1.1 200 OK
Content-Type: application/json
Date: Sun, 19 Apr 2020 01:49:08 GMT
Transfer-Encoding: chunked
{
    "data": [
        {
            "Messages": null,
            "Series": [
                {
                    "columns": [
                        "time",
                        "100ms",
                        "10ms",
                        "25ms",
                        "50ms",
                        "5ms",
                        "app",
                        "apporg",
                        "cellID",
                        "cloudlet",
                        "cloudletorg",
                        "errs",
                        "foundCloudlet",
                        "foundOperator",
                        "inf",
                        "method",
                        "reqs",
                        "ver"
                    ],
                    "name": "dme-api",
                    "values": [
                        [
                            "2020-04-19T01:42:21.588926Z",
                            0,
                            0,
                            0,
                            0,
                            4,
                            "someapplication1",
                            "AcmeAppCo",
                            "1234",
                            "tmus-cloud-1",
                            "tmus",
                            0,
                            null,
                            null,
                            0,
                            "RegisterClient",
                            4,
                            "1.0"
                        ],
                        [
                            "2020-04-19T01:42:21.588926Z",
                            0,
                            0,
                            0,
                            0,
                            2,
                            "someapplication1",
                            "AcmeAppCo",
                            "1234",
                            "tmus-cloud-1",
                            "tmus",
                            0,
                            "tmus-cloud-2",
                            "tmus",
                            0,
                            "FindCloudlet",
                            2,
                            "1.0"
                        ]
                    ]
                }
            ]
        }
    ]

}

```

**Note:** This allows for a single call with all the results.

## Usage Commands

### Application instance usage

```
mcctl usage app

Required Args:
  region       Region name
  starttime    Time to start displaying usage from
  endtime      Time up to which to display usage

Optional Args:
  appname      App name
  apporg       Organization or Company Name that a Developer is part of
  appvers      App version
  cluster      Cluster namedf
  cloudlet     Name of the cloudlet
  cloudletorg  Organization name owning of the cloudlet
  vmonly       Only show VM based apps

Flags:
  -h, --help   help for app

Global Flags:
      --addr string            MC address (default "http://127.0.0.1:9900")
      --data string            json formatted input data, alternative to name=val args list
      --datafile string        file containing json/yaml formatted input data, alternative to name=val args list
      --debug                  debug
      --output-format string   output format: yaml, json, or json-compact (default "yaml")
      --output-stream          stream output incrementally if supported by command (default true)
      --parsable               generate parsable output
      --silence-usage          silence-usage
      --skipverify             don’t verify cert for TLS connections
      --token string           JWT token

```

**Example**

```
$ mcctl usage app --addr=[https://console.mobiledgex.net](https://console.mobiledgex.net) region=US cluster=dockermonitoring appname=app-us cloudlet-org=packet cloudlet= starttime=2020-01-11T05:00:00+00:00 endtime=2021-06-14T23:03:07+00:00 app-org=testmonitor

data:
- series:
  - columns:
    - region
    - app
    - apporg
    - version
    - cluster
    - clusterorg
    - cloudlet
    - cloudletorg
    - flavor
    - deployment
    - startime
    - endtime
    - duration
    - note
    name: appinst-usage
    values:
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-03-11T06:07:28.18109284Z"
      - "2021-03-23T15:35:24.971452827Z"
      - 1.070876790359987e+15
      - HEALTH_CHECK_FAIL
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-03-23T15:35:40.174447583Z"
      - "2021-03-24T06:14:57.19314355Z"
      - 5.2757018695967e+13
      - HEALTH_CHECK_FAIL
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-03-24T06:15:12.25505126Z"
      - "2021-04-26T16:29:58.850334201Z"
      - 2.888086595282941e+15
      - DELETED
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-04-26T17:08:43.816096459Z"
      - "2021-04-29T15:30:12.323913187Z"
      - 2.53288507816728e+14
      - DELETED
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-04-29T15:36:57.068458556Z"
      - "2021-05-04T04:58:09.22534242Z"
      - 3.93672156883864e+14
      - HEALTH_CHECK_FAIL
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-05-04T04:58:24.325805291Z"
      - "2021-05-05T06:39:38.782789994Z"
      - 9.2474456984703e+13
      - HEALTH_CHECK_FAIL
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-05-05T06:39:53.978863752Z"
      - "2021-05-10T15:56:06.553279919Z"
      - 4.65372574416167e+14
      - DELETED
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-05-10T15:59:22.509334925Z"
      - "2021-05-26T19:33:24.278133127Z"
      - 1.395241768798202e+15
      - DELETED
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-05-26T19:38:52.582966722Z"
      - "2021-05-28T05:11:08.758367596Z"
      - 1.20736175400874e+14
      - HEALTH_CHECK_FAIL
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-05-28T05:11:23.935822011Z"
      - "2021-06-08T05:54:24.508299295Z"
      - 9.52980572477284e+14
      - HEALTH_CHECK_FAIL
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-06-08T05:54:39.578361976Z"
      - "2021-06-11T04:38:53.913277031Z"
      - 2.54654334915055e+14
      - HEALTH_CHECK_FAIL
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-06-11T04:39:08.960407727Z"
      - "2021-06-12T14:55:55.729278524Z"
      - 1.23406768870797e+14
      - HEALTH_CHECK_FAIL
    - - US
      - app-us
      - testmonitor
      - v1
      - dockermonitoring
      - testmonitor
      - packetcloudlet
      - packet
      - &lt;nil&gt;
      - docker
      - "2021-06-12T14:56:10.893751774Z"
      - "2021-06-14T23:03:07Z"
      - 2.02016106248226e+14
      - Running

```

**API Example**

**API Call**

```
POST /auth/usage/app

```

**Payload**

```
{
  "StartTime": "2021-01-28T20:35:00Z",
  "EndTime": "2021-01-28T23:35:00Z",
  "AppInst": {
      "cluster_inst_key": {
            "organization": "demoorg",
            "cloudlet_key": {
                    "organization": "TDG",
                    "name": "berlin-main"
                  },
            "cluster_key": {
                    "name": "jaycluster02"
                  }
          },
      "app_key": {
            "organization": "demoorg",
            "name": "k8jaypi",
            "version": "1.0"
          }
    },
  "Region": "EU"

}
```

**Example**

```
POST /auth/usage/app &lt; payload.json

{
  "data": [
    {
      "Series": [
        {
          "columns": [
            "region",
            "app",
            "apporg",
            "version",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "flavor",
            "deployment",
            "startime",
            "endtime",
            "duration",
            "note"
          ],
          "name": "appinst-usage",
          "values": [
            [
              "EU",
              "k8jaypi",
              "demoorg",
              "1.0",
              "jaycluster02",
              "demoorg",
              "berlin-main",
              "TDG",
              "&lt;nil&gt;",
              "kubernetes",
              "2021-01-28T21:13:15.501752085Z",
              "2021-01-28T23:35:00Z",
              8504498247915,
              "Running"
            ]
          ]
        }
      ]
    }
  ]

}

```

### Cluster Usage

```
mcctl usage cluster

Required Args:
  region       Region name
  starttime    Time to start displaying usage from
  endtime      Time up to which to display usage

Optional Args:
  cluster      Cluster name
  clusterorg   Organization or Company Name that a Developer is part of
  cloudletorg  Organization name owning of the cloudlet
  cloudlet     Name of the cloudlet

Flags:
  -h, --help   help for cluster

Global Flags:
      --addr string            MC address (default "http://127.0.0.1:9900")
      --data string            json formatted input data, alternative to name=val args list
      --datafile string        file containing json/yaml formatted input data, alternative to name=val args list
      --debug                  debug
      --output-format string   output format: yaml, json, or json-compact (default "yaml")
      --output-stream          stream output incrementally if supported by command (default true)
      --parsable               generate parsable output
      --silence-usage          silence-usage
      --skipverify             don’t verify cert for TLS connections
      --token string           JWT token

```

#### Example

```
$ mcctl usage cluster --addr=[https://console.mobiledgex.net](https://console.mobiledgex.net) region=EU cluster=TDG-Docker-Cluster cluster-org=testmonitor cloudlet-org=TDG starttime=2021-06-14T05:00:00+00:00 endtime=2021-06-16T23:03:07+00:00

data:
- series:
  - columns:
    - region
    - cluster
    - clusterorg
    - cloudlet
    - cloudletorg
    - flavor
    - numnodes
    - ipaccess
    - startime
    - endtime
    - duration
    - note
    name: cluster-usage
    values:
    - - EU
      - TDG-Docker-Cluster
      - testmonitor
      - automationBerlinCloudlet
      - TDG
      - automation_api_flavor
      - 0
      - IP_ACCESS_DEDICATED
      - "2021-06-15T18:33:02.124504691Z"
      - "2021-06-15T20:15:04.280783803Z"
      - 6.122156279112e+12
      - DELETED
    - - EU
      - TDG-Docker-Cluster
      - testmonitor
      - automationBerlinCloudlet
      - TDG
      - automation_api_flavor
      - 2
      - IP_ACCESS_DEDICATED
      - "2021-06-15T20:22:36.455527265Z"
      - "2021-06-16T07:34:10.086085844Z"
      - 4.0293630558579e+13
      - DELETED
    - - EU
      - TDG-Docker-Cluster
      - testmonitor
      - automationBerlinCloudlet
      - TDG
      - automation_api_flavor
      - 0
      - IP_ACCESS_DEDICATED
      - "2021-06-16T13:07:16.564976337Z"
      - "2021-06-16T17:13:38.247399481Z"
      - 1.4781682423144e+13
      - DELETED

```

#### API Example

```
POST /auth/usage/cluster
```

#### Payload

```
{
  "ClusterInst": {
      "cluster_key": {
            "name": "jaycluster02"
          },
      "cloudlet_key": {
            "name": "berlin-main",
            "organization": "TDG"
          },
      "organization": "demoorg"
    },
  "Region": "EU",
  "StartTime": "2021-01-28T20:35:00Z",
  "EndTime": "2021-01-28T23:35:00Z"

}
```

#### Example

```
POST /auth/usage/cluster &lt; payload.json

{
  "data": [
    {
      "Series": [
        {
          "columns": [
            "region",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "flavor",
            "numnodes",
            "ipaccess",
            "startime",
            "endtime",
            "duration",
            "note"
          ],
          "name": "cluster-usage",
          "values": [
            [
              "EU",
              "jaycluster02",
              "demoorg",
              "berlin-main",
              "TDG",
              "m4.small",
              2,
              "IP_ACCESS_SHARED",
              "2021-01-28T20:35:00Z",
              "2021-01-28T23:35:00Z",
              10800000000000,
              "Running"
            ]
          ]
        }
      ]
    }
  ]

}
```

