---
title: Audit and Regional Commands
long_title:
overview_description:
description: Audit and regional commands using the mcctl utility
---

## Audit Commands

The `mcctl` utility can be used to pull audit information for the current user or the current organization.

### Self audit example

```
$ mcctl  --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) --output-format json audit showself

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

### Organization audit example

```
$ mcctl  --addr [https://console.mobiledgex.net](https://console.mobiledgex.net)  --output-format json audit showorg

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

## Regional Commands

The `region` subcommand provides access to the most commonly used commands for managing a deployment.

### Flavor management

- `flavor create`
- `flavor delete`
- `flavor update`
- `flavor show`
- `flavor addres`
- `flavor removeres`
- `cloudlet findflavormatch`

### Operator codes

- `operatorcode create`
- `operatorcode delete`
- `operatorcode show`

### Cloudlet management

- `cloudlet create`
- `cloudlet delete`
- `cloudlet update`
- `cloudlet show`
- `cloudlet addresmapping`
- `cloudlet removeresmapping`

### Cloudlet pools (Private Edge)

- `cloudletpool create`
- `cloudletpool delete`
- `cloudletpool show`
- `cloudletinfo show`
- `cloudletpool addmember`
- `cloudletpool removemember`
- `cloudletpoolinvitation showgranted`

### Cluster management

- `clusterinst create`
- `clusterinst delete`
- `clusterinst update`
- `clusterinst show`

### Application management

- `app create`
- `app delete`
- `app update`
- `app show`
- `app addautoprovpolicy`
- `app removeautoprovpolicy`

### Application instance management

- `appinst create`
- `appinst delete`
- `appinst refresh`
- `appinst update`
- `appinst show`
- `node show` (Admin-Only)
- `alert show` (Admin-Only)

### Policy management

- `autoscalepolicy create`
- `autoscalepolicy update`
- `autoscalepolicy show`
- `autoprovpolicy create`
- `autoprovpolicy delete`
- `autoprovpolicy update`
- `autoprovpolicy show`
- `autoprovpolicy addcloudlet`
- `autoprovpolicy removecloudlet`
- `trustpolicy create`
- `trustpolicy delete`
- `trustpolicy update`
- `trustpolicy showself`

### Regional settings

- `settings update` (Admin-Only)
- `settings reset` (Admin-Only)
- `settings show` (Admin-Only)

### Resource tagging

- `restagtable create`
- `restagtable delete`
- `restagtable update`
- `restagtable show`
- `restagtable addrestag`
- `restagtable removerestag`
- `restagtable get`

### Debugging

- `debug enabledebuglevels` (Admin-Only)
- `debug disabledebuglevels` (Admin-Only)
- `debug showdebuglevels` (Admin-Only)
- `debug rundebug` (Admin-Only)

### Device management

- `appinstclient showappinstclient`
- `device inject` (Admin-Only)
- `device show` (Admin-Only)
- `device evict` (Admin-Only)
- `device showreport` (Admin-Only)

### Misc commands

- `RunCommand`
- `showlogs`
- `runconsole`
- `accesscloudlet` (Admin-Only)

