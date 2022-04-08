---
title: Reports and Monitoring Commands
long_title:
overview_description:
description: Monitor application, app instance, and Cloudletpool usage with mcctl
---

## Event and Audit Events Commands

The same events and audits that are presented in the MobiledgeX Web GUI can be viewed from the CLI by using the `events` command to the `mcctl` utility. The examples below request the output in JSON format, but it is possible to retrieve the data in YAML or condensed JSON (JSON without extra whitespace formatting).

**Note:** The `mcctl` utility provides a stable interface to the MobiledgeX APIs. The API can be accessed directly, but the API interface is subject to change.

```
$ mcctl events -h
Search events and audit events

Usage: mcctl events [flags] [command]

Available Commands:
  show       Show events and audit events
  showold    Show events and audit events (for old events format)
  find       Find events and audit events, results sorted by relevance
  terms      Show aggregated events terms

Flags:
  -h, --help   help for events

mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) events show -h
Show events and audit events

Usage: mcctl events show [flags] [args]

Optional Args:
  name       name of the event, may be specified multiple times
  org        organization associated with the event, may be specified multiple times
  type       type of event, either "event" or "audit", may be specified multiple times
  region     Region name
  error      any words in an error message
  tags       key=value tag, may be specified multiple times, key may include app, apporg, appver, cloudlet, cloudletorg, cloudletpool, cloudletpoolorg, cluster, clusterorg, clusterreforg, controlleraddr, deviceid, deviceidtype, flavor, gpudriver, gpudriverorg, node, noderegion, nodetype, policy, policyorg, restagtable, restagtableorg, uniqueid, uniqueidtype, vmpool, vmpoolorg
  starttime  absolute time of search range start (RFC3339)
  endtime    absolute time of search range end (RFC3339)
  startage   relative age from now of search range start (default 48h)
  endage     relative age from now of search range end (default 0)
  failed     specify true to find events with an error
  from       start offset if paging through results
  limit      number of results to return, either to limit or for paging results

Flags:
  -h, --help   help for show

```

All events commands can be qualified with a time or duration parameter.

- `last N` Shows the last N series of data.
- `starttime datetime` Start time of displayed data.
- `endtime datetime` End time of displayed data.

### Event terms

```
mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) events terms
argsmap: map[]
jsonmap: map[]
curl -X POST "[https://console.mobiledgex.net/api/v1/auth/events/terms](https://console.mobiledgex.net/api/v1/auth/events/terms)" -H "Content-Type: application/json" -H "Authorization: Bearer ${TOKEN}" -k --data-raw ’{}’
names:from
mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) events terms --help
Show aggregated events termsUsage: mcctl events terms [flags] [args]Optional Args:
  name       name of the event, may be specified multiple times
  org        organization associated with the event, may be specified multiple times
  type       type of event, either "event" or "audit", may be specified multiple times
  region     Region name
  error      any words in an error message
  tags       key=value tag, may be specified multiple times, key may include app, apporg, appver, cloudlet, cloudletorg, cloudletpool, cloudletpoolorg, cluster, clusterorg, clusterreforg, controlleraddr, deviceid, deviceidtype, flavor, gpudriver, gpudriverorg, node, noderegion, nodetype, policy, policyorg, restagtable, restagtableorg, uniqueid, uniqueidtype, vmpool, vmpoolorg
  starttime  absolute time of search range start (RFC3339)
  endtime    absolute time of search range end (RFC3339)
  startage   relative age from now of search range start (default 48h)
  endage     relative age from now of search range end (default 0)
  failed     specify true to find events with an error
  from       start offset if paging through results
  limit      number of results to return, either to limit or for paging resultsFlags:
  -h, --help   help for terms

```

## Application Instance Usage

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

### Example

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

### API example

#### API call

```
POST /auth/usage/app
```

#### Payload

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

### Example

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

## Cloudletpool Usage

```
mcctl usage cloudletpool

Required Args:
  region           Region name
  cloudletpool     Name of the CloudletPool to pull usage from
  cloudletpoolorg  Organization or Company Name that a Operator is part of
  starttime        Time to start displaying usage from
  endtime          Time up to which to display usage

Optional Args:

Flags:
  -h, --help   help for cloudletpool

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

### Example

```
$ mcctl --output-format json --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) usage \
 cloudletpool region=EU starttime="2021-01-28T20:35:00Z" \
 endtime="2021-01-28T23:35:00Z" cloudletpoolorg=BT cloudletpool=BT-Pool

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
                            "frankClust",
                            "mattDev",
                            "frankPool",
                            "TDG",
                            "x1.medium",
                            1,
                            "IP_ACCESS_DEDICATED",
                            "2020-09-23T18:17:03.623153723Z",
                            "2020-09-23T19:00:00Z",
                            2576376846277,
                            "Running"
                        ],
                        [
                            "EU",
                            "berlinClust",
                            "mattDev",
                            "berlinPool",
                            "TDG",
                            "x1.medium",
                            1,
                            "IP_ACCESS_SHARED",
                            "2020-09-23T17:59:19.527074075Z",
                            "2020-09-23T19:00:00Z",
                            3640472925925,
                            "Running"
                        ],
                        [
                            "EU",
                            "berlinClust1",
                            "jimsorg",
                            "berlinPool",
                            "TDG",
                            "x1.medium",
                            1,
                            "IP_ACCESS_DEDICATED",
                            "2020-09-23T18:04:30.378215342Z",
                            "2020-09-23T19:00:00Z",
                            3329621784658,
                            "Running"
                        ]
                    ]
                }
            ]
        },
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
                            "testVmlb",
                            "mattDev",
                            "1.0",
                            "DefaultVMCluster",
                            "mattDev",
                            "berlinPool",
                            "TDG",
                            "m4.medium",
                            "vm",
                            "2020-09-23T18:25:56.807935662Z",
                            "2020-09-23T18:26:24.635684839Z",
                            27827749177,
                            "HEALTH_CHECK_FAIL"
                        ]
                    ]
                }
            ]
        }
    ]

}
```

### API example

#### API call

```
POST /auth/usage/cloudletpool
```

### Payload

```
{
  "Region": "EU",
  "StartTime": "2021-01-28T20:35:00Z",
  "EndTime": "2021-01-28T23:35:00Z",
  "CloudletPool": {
      "name": "BT-Pool",
      "organization": "BT"
    }

}
```

### Example

```
$ POST /auth/usage/cloudletpool
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
              "umsclusterbt",
              "UMS",
              "Ipswich2",
              "BT",
              "m4.large",
              0,
              "IP_ACCESS_DEDICATED",
              "2021-01-28T20:35:00Z",
              "2021-01-28T23:35:00Z",
              10800000000000,
              "Running"
            ],
            [
              "EU",
              "fdcluster",
              "BT_dev",
              "Ipswich",
              "BT",
              "m4.medium",
              1,
              "IP_ACCESS_DEDICATED",
              "2021-01-28T20:35:00Z",
              "2021-01-28T23:35:00Z",
              10800000000000,
              "Running"
            ],
            [
              "EU",
              "umsclusterbtgpu",
              "UMS",
              "Ipswich2",
              "BT",
              "mex.small-gpu",
              0,
              "IP_ACCESS_DEDICATED",
              "2021-01-28T20:35:00Z",
              "2021-01-28T23:35:00Z",
              10800000000000,
              "Running"
            ]
          ]
        }
      ]
    },
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
          "values": []
        }
      ]
    }
  ]

}
```

## Cluster Usage

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

### Example

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

### API example

```
POST /auth/usage/cluster
```

### Payload

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

### Example

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

## Client App Usage Metrics

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

## Report Scheduler

The following `mcctl` command is used to generate a summarized report of all cloudlets and their usages.

```
mcctl reporter -h
Manage report schedule

Usage: mcctl reporter [flags] [command]

Available Commands:
  create     Create new reporter
  update     Update reporter
  delete     Delete reporter
  show       Show reporters

  Required Args:
  name          Reporter name
  org           Org name

Optional Args:
  email                 Email to send generated reports
  schedule              Report schedule, one of EveryWeek, Every15Days, Every30Days, EveryMonth
  startscheduledateutc  Date when the next report is scheduled to be generated (default: now)

```

```
mcctl reporter create -h
Create new reporter

Usage: mcctl reporter create [flags] [args]

Required Args:
name Reporter name. Can only contain letters, digits, period, hyphen. It cannot have leading or trailing spaces or period. It cannot start
     with hyphen

org  Organization name

Optional Args:
email             Email to send generated reports
schedule          Indicates how often a report should be generated, one of EveryWeek, Every15Days, EveryMonth
startscheduledate Start date (in RFC3339 format with intended timezone) when the report is scheduled to be generated (Default: today)
timezone          Timezone in which to show the reports, defaults to UTC
```

### Example

```
mcctl reporter create name=TDGReporter org=TDG schedule=EveryWeek startscheduledate=2021-04-26T00:00:00Z
```

The following example shows how the report time range is calculated.
<table>
<tbody>
<tr>
<th>Item</th>
<th>Value</th>
</tr>
<tr>
<td>Schedule date</td>
<td>2021-04-26T00:00:00.000Z</td>
</tr>
<tr>
<td>Minus 7 days</td>
<td>2021-04-19T00:00:00.000Z</td>
</tr>
<tr>
<td>Time range</td>
<td>2021-04-19T00:00:00.000Z to 2021-04-25T00:00:00.000Z</td>
</tr>
<tr>
<td>Next schedule date</td>
<td>2021-05-03T00:00:00.000Z</td>
</tr>
</tbody>
</table>

## Manage Reports

The following `mcctl` command is used to manage reports.

```
mcctl report -h
Manage reports

Usage: mcctl report [flags] [command]

Available Commands:
  generate   Generate new report for an org of all regions
  show       Show already generated reports for an org
  download   Download generated report

```

```
mcctl report generate -h
Generate new report for an org of all regions

Usage: mcctl report generate [flags] [args]

Required Args:
org Organization name
starttime Absolute time (in RFC3339 format with intended timezone) to start report capture
endtime Absolute time (in RFC3339 format with intended timezone) to end report capture

Optional Args:
timezone Timezone in which to show the reports, defaults to UTC
```

### Example

```
mcctl report generate org=TDG starttime="2021-04-19T00:00:00Z" endtime="2021-04-26T00:00:00Z
```

## Billing Events

The following `mcctl` command is helpful for Cloudlet Pool owners to check the usage information of their resources.  The information provided includes number of vCPUs, RAM, Disk, and number of nodes. This is useful for calculating the time resources were reserved.

The information is presented as an event feed for when the resources were reserved (CREATED) and released (DELETED).

This information can also be extracted from the Edge-Cloud Console, shown in the [Monitoring: Events, Usage, and Metrics](/operator/product-overview/operator-guides/debugging/operator-monitoring-and-metrics) guide.<br>

```
$ mcctl --addr https://console.mobiledgex.net billingevents
Usage: mcctl billingevents [flags] [command]

Available Commands:
app    View App billing events
cluster  View ClusterInst billing events
cloudlet  View Cloudlet billing events

Flags: -h, --help  help for billingevents
```

### Billingevents app

`app-org` is useful to see only a specific app usage events.<br>

```
$ mcctl billingevents app
Usage: mcctl billingevents app [flags] [args]

Required Args:
  region        Region name
  app-org       Organization or Company Name that a Developer is part of

Optional Args:
  appname       App name
  appvers       App version
  cluster       Cluster name
  cloudlet      Name of the cloudlet
  cloudlet-org  Organization name owning of the cloudlet
  last          Display the last X Events
  starttime     Time to start displaying stats from
  endtime       Time up to which to display stats

Flags:
  -h, --help   help for app

```

#### Example

```
$ mcctl --addr https://console-qa.mobiledgex.net:443 billingevents cloudlet cloudlet-org=TDG region=EU limit=3
data:
- series:
  - columns:
    - time
    - cloudlet
    - cloudletorg
    - event
    - status
    name: cloudlet
    values:
    - - "2021-11-23T06:53:11.177177864Z"
      - cloudlet1637649488-2080798
      - TDG
      - DELETED
      - DOWN
    - - "2021-11-23T06:51:03.480077977Z"
      - cloudlet1637649393-0275304
      - TDG
      - DELETED
      - DOWN
    - - "2021-11-23T06:47:43.882322051Z"
      - cloudlet1637649461-3983378
      - TDG
      - DELETED
      - DOWN
```

### Billingevents cluster

This subcommand allows operators to see infra resource usage for billing.

```
$ mcctl billingevents cluster
Usage: mcctl billingevents cluster [flags] [args]

Required Args:
  region        Region name
  cluster-org

Optional Args:
  cluster       Cluster name
  cloudlet-org  Organization name owning of the cloudlet
  cloudlet      Name of the cloudlet
  last          Display the last X Events
  starttime     Time to start displaying stats from
  endtime       Time up to which to display stats

Flags:
  -h, --help   help for cluster

```

#### Example

```
./mcctl --addr https://console-qa.mobiledgex.net:443 billingevents app region=EU app-org=automation_dev_org limit=3
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
    - event
    - status
    name: appinst
    values:
    - - "2021-11-24T07:30:26.406533995Z"
      - K8sapp
      - "1.0"
      - autoclusterk8sapp
      - MobiledgeX
      - automationMunichCloudlet
      - TDG
      - automation_dev_org
      - HEALTH_CHECK_OK
      - UP
    - - "2021-11-24T07:26:51.17125967Z"
      - K8sapp
      - "1.0"
      - autoclusterk8sapp
      - MobiledgeX
      - automationMunichCloudlet
      - TDG
      - automation_dev_org
      - HEALTH_CHECK_FAIL
      - DOWN
    - - "2021-11-23T06:30:18.386894375Z"
      - K8sapp
      - "1.0"
      - autoclusterk8sapp
      - MobiledgeX
      - automationMunichCloudlet
      - TDG
      - automation_dev_org
      - HEALTH_CHECK_OK
      - UP

```

### Billingevents cloudlet

This subcommand’s output includes all the details for nodes used, making it helpful for calculating usgae. `starttime` and `endtime` can limit the window of time from which information is extracted.

```
$ mcctl billingevents cloudlet
Usage: mcctl billingevents cloudlet [flags] [args]

Required Args:
  region        Region name
  cloudlet-org  Organization name owning of the cloudlet

Optional Args:
  cloudlet      Name of the cloudlet
  last          Display the last X Events
  starttime     Time to start displaying stats from
  endtime       Time up to which to display stats

Flags:
  -h, --help   help for cloudlet

```

#### Example

```
$  mcctl --addr https://console-qa.mobiledgex.net:443 billingevents cloudlet cloudlet-org=TDG region=EU limit=4
data:
- series:
  - columns:
    - time
    - cloudlet
    - cloudletorg
    - event
    - status
    name: cloudlet
    values:
    - - "2021-11-22T11:06:14.817699111Z"
      - cloudlet1637578497-3523364
      - TDG
      - CREATED
      - UP
    - - "2021-11-22T11:05:46.103009862Z"
      - cloudlet1637578518-3065944
      - TDG
      - CREATED
      - UP
    - - "2021-11-22T11:04:48.183518563Z"
      - cloudlet1637578517-3563762
      - TDG
      - CREATED
      - UP
    - - "2021-11-22T11:01:17.078654345Z"
      - automationBerlinCloudlet
      - TDG
      - CREATED
      - UP

```

