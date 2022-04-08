---
title: Application and Monitoring Commands
long_title: 
overview_description: 
description: 
Learn about audit and event commands, and monitoring your applications with mcctl

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

mcctl --addr[https://console.mobiledgex.net](https://console.mobiledgex.net) events show -h
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

- **last N** Shows the last N series of data.
- **starttime datetime** Start time of displayed data.
- **endtime datetime** End time of displayed data.

### Event Terms

```
mcctl --addr https://console.mobiledgex.net events terms --help
Show aggregated events terms

Usage: mcctl events terms [flags] [args]

Optional Args:
 name    Name of the event, may be specified multiple times
 org    Organization associated with the event, may be specified multiple times
 type    Type of event, either "event" or "audit", may be specified multiple times
 region   Region name
 error   Any words in an error message
 tags    Key=value tag, may be specified multiple times, key may include alert, alertorg, apiendpointtype, apiname, app, apporg, appver, cloudlet, cloudletorg, cloudletpool, cloudletpoolorg, cluster, clusterorg, clusterreforg, controlleraddr, deviceid, deviceidtype, federatedorg, flavor, flowsettingsname, gpudriver, gpudriverorg, maxreqssettingsname, name, network, node, noderegion, nodetype, policy, policyorg, ratelimittarget, restagtable, restagtableorg, uniqueid, uniqueidtype, vcluster, vmpool, vmpoolorg
 failed   Specify true to find events with an error
 notname  Name of the event to exclude, may be specified multiple times
 notorg   Organization associated with the event to exclude, may be specified multiple times
 nottype  Type of event, either "event" or "audit" to exclude, may be specified multiple times
 notregion Region for the event to exclude, may be specified multiple times
 noterror  Any words in an error message to exclude
 nottags  Any tags to exclude, see tags option
 notfailed Specify true to find events without any error
 starttime Absolute time of search range start (RFC3339)
 endtime  Absolute time of search range end (RFC3339)
 startage  Relative age from now of search range start (default 48h)
 endage   Relative age from now of search range end (default 0)
 from    Start offset if paging through results
 limit   Number of results to return, either to limit or for paging results

Flags:
 -h, --help  help for terms

```

### Application Events

```
mcctl events show app  -h
Show events and audit events

Usage: mcctl events show [flags] [args]

Optional Args:
  name       name of the event, may be specified multiple times
  org        organization associated with the event, may be specified multiple times
  type       type of event, either "event" or "audit", may be specified multiple times
  region     Region name
  error      any words in an error message
  tags       key=value tag, may be specified multiple times, key may include alert, alertorg, apiendpointtype, apiname, app, apporg, appver, cloudlet, cloudletorg, cloudletpool, cloudletpoolorg, cluster, clusterorg, clusterreforg, controlleraddr, deviceid, deviceidtype, flavor, flowsettingsname, gpudriver, gpudriverorg, maxreqssettingsname, node, noderegion, nodetype, policy, policyorg, ratelimittarget, restagtable, restagtableorg, uniqueid, uniqueidtype, vmpool, vmpoolorg
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

#### Data Keys

- `time`
- `app`
- `ver`
- `cluster`
- `clusterorg`
- `cloudlet`
- `cloudletorg`
- `apporg`
- `event`
- `status`

#### Example

```
$ mcctl  --addr [https://console.mobiledgex.net](https://console.mobiledgex.net)  --output-format json events app region=EU\
apporg=demoorg
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
            "event",
            "status"
          ],
          "name": "appinst",
          "values": [
            [
              "2020-06-11T21:45:37.030622125Z",
              "leotest",
              "1.1",
              "autoclusterleotest",
              "demoorg",
              "dusseldorf-main",
              "TDG",
              "demoorg",
              "DELETED",
              "DOWN"
            ],
            [
              "2020-06-11T16:17:18.954135649Z",
              "leotest",
              "1.1",
              "autoclusterleotest",
              "demoorg",
              "dusseldorf-main",
              "TDG",
              "demoorg",
              "CREATED",
              "UP"
            ],
            [
              "2020-06-11T16:09:28.014006366Z",
              "leotest",
              "1.0",
              "autoclusterleotest",
              "demoorg",
              "hamburg-main",
              "TDG",
              "demoorg",
              "DELETED",
              "DOWN"
            ],
            [
              "2020-05-22T16:50:59.47204115Z",
              "helm3-test",
              "1.0",
              "autoclusterhelm3-test",
              "demoorg",
              "dusseldorf-main",
              "TDG",
              "demoorg",
              "DELETED",
              "DOWN"
            ]
          ]
        }
      ]
    }
  ]

}

```

### Cluster Events

```
mcctl events show cluster  -h
Show events and audit events

Usage: mcctl events show [flags] [args]

Optional Args:
  name       name of the event, may be specified multiple times
  org        organization associated with the event, may be specified multiple times
  type       type of event, either "event" or "audit", may be specified multiple times
  region     Region name
  error      any words in an error message
  tags       key=value tag, may be specified multiple times, key may include alert, alertorg, apiendpointtype, apiname, app, apporg, appver, cloudlet, cloudletorg, cloudletpool, cloudletpoolorg, cluster, clusterorg, clusterreforg, controlleraddr, deviceid, deviceidtype, flavor, flowsettingsname, gpudriver, gpudriverorg, maxreqssettingsname, node, noderegion, nodetype, policy, policyorg, ratelimittarget, restagtable, restagtableorg, uniqueid, uniqueidtype, vmpool, vmpoolorg
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

#### Data Keys

- `time`
- `cluster`
- `clusterorg`
- `cloudlet`
- `cloudletorg`
- `flavor`
- `vcpu`
- `ram`
- `disk`
- `other`
- `event`
- `status`

#### Example

```
$ mcctl  --addr [https://console.mobiledgex.net](https://console.mobiledgex.net)  --output-format json events cluster region=EU\
clusterorg=demoorg
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
            "flavor",
            "vcpu",
            "ram",
            "disk",
            "other",
            "event",
            "status"
          ],
          "name": "clusterinst",
          "values": [
            [
              "2020-06-11T21:45:37.030373227Z",
              "autoclusterleotest",
              "demoorg",
              "dusseldorf-main",
              "TDG",
              "m4.small",
              2,
              2048,
              20,
              "map[]",
              "DELETED",
              "DOWN"
            ],
            [
              "2020-06-11T16:16:56.117330464Z",
              "autoclusterleotest",
              "demoorg",
              "dusseldorf-main",
              "TDG",
              "m4.small",
              2,
              2048,
              20,
              "map[]",
              "CREATED",
              "UP"
            ],
            [
              "2020-06-11T16:09:28.013967166Z",
              "autoclusterleotest",
              "demoorg",
              "hamburg-main",
              "TDG",
              "m4.small",
              2,
              2048,
              20,
              "map[]",
              "DELETED",
              "DOWN"
            ]
          ]
        }
      ]
    }
  ]

}

```

## Audit Commands

The `mcctl` utility can be used to pull audit information for the current user or the current organization.

### Self Audit Example

```
$ mcctl  --addr [https://console.mobiledgex.net](https://console.mobiledgex.net)  --output-format json audit showself
[
  {
    "operationname": "/api/v1/auth/metrics/app",
    "username": "jay.schmidt",
    "clientip": "172.17.0.1",
    "status": 400,
    "starttime": 1591654143039652,
    "duration": 274,
    "request": "{\"appinst\":{\"app_key\":{\"organization\":\"demoorg\"}},\"region\":\"EU\",\"selector\
    ":\"cpu,mem,disk,network,tcp,udp\"}",\
    "response": "{\"message\":\"Invalid appinst selector: tcp\"}",\
    "error": "",
    "traceid": "442ca89d3418b6af"
  },
  {
    "operationname": "/api/v1/auth/metrics/cloudlet",
    "username": "jay.schmidt",
    "clientip": "172.17.0.1",
    "status": 400,
    "starttime": 1591654011509158,
    "duration": 193,
    "request": "{\"cloudlet\":{\"organization\":\"TDG\"},\"region\":\"EU\",\"selector\":\"cpu\"}",
    "response": "{\"message\":\"Invalid cloudlet selector: cpu\"}",
    "error": "",
    "traceid": "04a229ee7dfde458"
  },
  {
    "operationname": "/api/v1/login",
    "username": "jay.schmidt",
    "clientip": "172.17.0.1",
    "status": 400,
    "starttime": 1591641868552332,
    "duration": 1082826,
    "request": "{\"username\":\"jay.schmidt\",\"password\":\"\"}",
    "response": "{\"message\":\"Invalid username or password\"}",
    "error": "",
    "traceid": "5d425c8cb9dbc53c"
  }

]

```

## Organization Audit Example

```
$ mcctl  --addr https://console.mobiledgex.net  --output-format json audit showorg
[
  {
    "operationname": "/api/v1/login",
    "username": "mcviewer",
    "clientip": "172.17.0.1",
    "status": 200,
    "starttime": 1591656362716240,
    "duration": 94992,
    "request": "",
    "response": "{\"token\":\"\"}",
    "error": "",
    "traceid": "1ab4474ed71c4a40"
  },
  {
    "operationname": "/api/v1/login",
    "username": "cloudops-monitor",
    "clientip": "172.17.0.1",
    "status": 200,
    "starttime": 1591656304644725,
    "duration": 100843,
    "request": "{\"username\":\"cloudops-monitor\",\"password\":\"\"}",
    "response": "{\"token\":\"\"}",
    "error": "",
    "traceid": "7de5361a1c17af69"
  },
  {
    "operationname": "/api/v1/login",
    "username": "mcviewer",
    "clientip": "172.17.0.1",
    "status": 200,
    "starttime": 1591656242564764,
    "duration": 87877,
    "request": "",
    "response": "{\"token\":\"\"}",
    "error": "",
    "traceid": "7b3a4699aef3dcad"
  }

]

```

## Application Management

```
$ mcctl app
Error: Please specify a command
Usage: mcctl app [flags] [command]

Available Commands:
  create                      Create Application. Creates a definition for an application instance 
                              for Cloudlet deployment.
  delete                      Delete Application. Deletes a definition of an Application instance. 
                              Make sure no other application instances exist with that definition. 
                              If they do exist, you must delete those Application instances first.
  update                      Update Application. Updates the definition of an Application instance.
  show                        Show Applications. Lists all Application definitions managed from the 
                              Edge Controller. Any fields specified will be used to filter results.
  addautoprovpolicy           Add an AutoProvPolicy to the App
  removeautoprovpolicy        Remove an AutoProvPolicy from the App
  adduserdefinedalert         Add an UserAlert to the App
  removeuserdefinedalert      Remove an UserAlert from the App
  showcloudletsfordeployment  Discover cloudlets supporting deployments of App.DefaultFlavor

```

