---
title: Metric Commands
long_title:
overview_description:
description: Learn how to use application and cluster level commands using mcctl utility
---

## Metric Commands

The same metrics that are presented in the MobiledgeX Web GUI can be viewed from the CLI by using the metrics command to the `mcctl` utility.

The examples below request the output in JSON format, but it is possible to retrieve the data in YAML or condensed JSON (JSON without extra whitespace formatting).

**Note:** The `mcctl` utility provides a stable interface to the MobiledgeX APIs. The API can be accessed directly, but the API interface is subject to change.

```
$ mcctl metrics
Usage: mcctl metrics [flags] [command]

Available Commands:
  app                  View App metrics
  cluster              View ClusterInst metrics
  cloudlet             View Cloudlet metrics
  cloudletusage        View Cloudlet usage
  clientapiusage       View client API usage
  clientappusage       View client App usage
  clientcloudletusage  View client Cloudlet usage
  appv2                View App metrics(v2 format)

```

All metrics commands can be qualified with a time or duration parameter.

- `last N` Shows the last N series of data.
- `starttime datetime` Start time of displayed data.
- `endtime datetime` End time of displayed data.

### Using start/end times

Several of the `mcctl` subcommands accept a start/end time to filter output. Time should be passed through in the format as outlined in [RFC 3339](https://tools.ietf.org/html/rfc3339). For example, to specify *10:35 PM UTC on August 7, 2019*, you would code the time as `2019-08-07T20:35Z`. Please note that the entire date/time string, including the time zone indicator, must be passed to the command.

## Application Level Metrics

```
$ mcctl metrics app
Usage: mcctl metrics app [flags] [args]

Required Args:
  region                  Region name
  selector                Comma separated list of metrics to view. Available metrics: "cpu", "mem", "disk", "network", "connections", "udp"

Optional Args:
  limit                   Display the last X metrics
  numsamples              Display X samples spaced out evenly over start and end times
  starttime               Time to start displaying stats from in RFC3339 format (ex. 2002-12-31T15:00:00Z)
  endtime                 Time up to which to display stats in RFC3339 format (ex. 2002-12-31T10:00:00-05:00)
  startage                Relative age from now of search range start (default 48h)
  endage                  Relative age from now of search range end (default 0)
  appinsts:#.apporg       Organization or Company name of the App
  appinsts:#.appname      App name
  appinsts:#.appvers      App version
  appinsts:#.cluster      Cluster name
  appinsts:#.clusterorg   Organization or Company Name that a Cluster is used by
  appinsts:#.cloudletorg  Company or Organization name of the cloudlet
  appinsts:#.cloudlet     Name of the cloudlet

```

### Data keys

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

### Example

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

### CPU example

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

### Memory example

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

### Disk example

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

### Network example

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

### Active connections example

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

### API example

- Valid selector: `api`
- Valid method names: `RegisterClient`, `VerifyLocation`, `FindCloudlet`, `GetLocation`, `AppinstList`, `FqdnList`, `DynamicLocGroup`, `QosPosition`.
- `Cellid` 0 is invalid.

### FindCloudet example

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

### RegisterClient example

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

## Cluster Level Metrics

```
$ mcctl metrics cluster
Usage: mcctl metrics cluster [flags] [args]

Required Args:
  region                      Region name
  selector                    Comma separated list of metrics to view. Available metrics: "cpu", "mem", "disk", "network", "tcp", "udp"

Optional Args:
  limit                       Display the last X metrics
  numsamples                  Display X samples spaced out evenly over start and end times
  starttime                   Time to start displaying stats from in RFC3339 format (ex. 2002-12-31T15:00:00Z)
  endtime                     Time up to which to display stats in RFC3339 format (ex. 2002-12-31T10:00:00-05:00)
  startage                    Relative age from now of search range start (default 48h)
  endage                      Relative age from now of search range end (default 0)
  clusterinsts:#.cluster      Cluster name
  clusterinsts:#.clusterorg   Organization or Company Name that a Cluster is used by
  clusterinsts:#.cloudletorg  Company or Organization name of the cloudlet
  clusterinsts:#.cloudlet     Name of the cloudlet

```

### Data keys

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

### Example

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

### CPU example

The CPU value format is in percentages.

```
$ http --verify=false --auth-type=jwt --auth=$SUPERPASS POST [https://console.mobiledgex.net/api/v1/auth/metrics/cluster](https://console.mobiledgex.net/api/v1/auth/metrics/cluster) &lt;&lt;&lt;\
’{"region":"local","clusterinst":{"cluster_key":{"name":"AppCluster"},"cloudlet_key":\
{"organization":"mexdev","name":"localtest"},"organization":"DevOrg"},"selector":\
"cpu","last":1}’
HTTP/1.1 200 OK
Content-Type: application/json
Date: Sun, 19 Apr 2020 00:28:05 GMT
Transfer-Encoding: chunked

{
    "data": [
        {
            "Messages": null,
            "Series": [
                {
                    "columns": [
                        "time",
                        "cluster",
                        "clusterorg",
                        "cloudlet",
                        "cloudletorg",
                        "cpu"
                    ],
                    "name": "cluster-cpu",
                    "values": [
                        [
                            "2020-04-19T00:27:59.930999994Z",
                            "AppCluster",
                            "DevOrg",
                            "localtest",
                            "mexdev",
                            3.368800199773451
                        ]
                    ]
                }
            ]
        }
    ]

}

```

### Network example

Cluster Tx/Rx traffic rate in bytes/sec averaged over 1 minute.

```
$ http --verify=false --auth-type=jwt --auth=$SUPERPASS POST [https://console.mobiledgex.net/api/v1/auth/metrics/cluster](https://console.mobiledgex.net/api/v1/auth/metrics/cluster) &lt;&lt;&lt;\
’{"region":"local","clusterinst":{"cluster_key":{"name":"AppCluster"},"cloudlet_key":\
{"organization":"mexdev","name":"localtest"},"organization":"DevOrg"},"selector":\
"network","last":1}’\
HTTP/1.1 200 OK
Content-Type: application/json
Date: Sun, 19 Apr 2020 00:29:24 GMT
Transfer-Encoding: chunked

{
    "data": [
        {
            "Messages": null,
            "Series": [
                {
                    "columns": [
                        "time",
                        "cluster",
                        "clusterorg",
                        "cloudlet",
                        "cloudletorg",
                        "sendBytes",
                        "recvBytes"
                    ],
                    "name": "cluster-network",
                    "values": [
                        [
                            "2020-04-19T00:29:21.539000034Z",
                            "AppCluster",
                            "DevOrg",
                            "localtest",
                            "mexdev",
                            1002472,
                            728685
                        ]
                    ]
                }
            ]
        }
    ]

}

```

### TCP example

The total number of established TCP connections.

```
$ http --verify=false --auth-type=jwt --auth=$SUPERPASS POST [https://console.mobiledgex.net/api/v1/auth/metrics/cluster](https://console.mobiledgex.net/api/v1/auth/metrics/cluster) &lt;&lt;&lt;\
’{"region":"local","clusterinst":{"cluster_key":{"name":"AppCluster"},"cloudlet_key":\
{"organization":"mexdev","name":"localtest"},"organization":"DevOrg"},"selector":"tcp",\
"last":1}’
HTTP/1.1 200 OK
Content-Type: application/json
Date: Sun, 19 Apr 2020 00:30:00 GMT
Transfer-Encoding: chunked

{
    "data": [
        {
            "Messages": null,
            "Series": [
                {
                    "columns": [
                        "time",
                        "cluster",
                        "clusterorg",
                        "cloudlet",
                        "cloudletorg",
                        "tcpConns",
                        "tcpRetrans"
                    ],
                    "name": "cluster-tcp",
                    "values": [
                        [
                            "2020-04-19T00:29:54.068000078Z",
                            "AppCluster",
                            "DevOrg",
                            "localtest",
                            "mexdev",
                            192,
                            99
                        ]
                    ]
                }
            ]
        }
    ]

}
```

### UDP example

The total number of Tx/Rx UDP datagrams in this cluster and the total number of UDP errors.

```
$ http --verify=false --auth-type=jwt --auth=$SUPERPASS POST https://console.mobiledgex.net/api/v1/auth/metrics/cluster &lt;&lt;&lt;\
’{"region":"local","clusterinst":{"cluster_key":{"name":"AppCluster"},"cloudlet_key":\
{"organization":"mexdev","name":"localtest"},"organization":"DevOrg"},"selector":"udp",\
"last":1}’\
HTTP/1.1 200 OK
Content-Type: application/json
Date: Sun, 19 Apr 2020 00:30:26 GMT
Transfer-Encoding: chunked

{
    "data": [
        {
            "Messages": null,
            "Series": [
                {
                    "columns": [
                        "time",
                        "cluster",
                        "clusterorg",
                        "cloudlet",
                        "cloudletorg",
                        "udpSent",
                        "udpRecv",
                        "udpRecvErr"
                    ],
                    "name": "cluster-udp",
                    "values": [
                        [
                            "2020-04-19T00:30:21.153000116Z",
                            "AppCluster",
                            "DevOrg",
                            "localtest",
                            "mexdev",
                            418,
                            418,
                            0
                        ]
                    ]
                }
            ]
        }
    ]

}
```

