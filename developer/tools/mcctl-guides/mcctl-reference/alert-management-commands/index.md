---
title: Alert Management Commands
long_title:
overview_description:
description:
Manage AlertReceiver and create alerts using mcctl

---

## AlertReceiver Example

Alert notification will only be sent for `AppInstDown`.

Note that `alertreceiver create` command utilizes the same arguments.

```
$ mcctl  alertreceiver create
Error: missing required args: type severity name
Usage: mcctl alertreceiver create [flags] [args]
Required Args:
  name                       Unique name of this receiver
  type                       Receiver type - email, slack or pagerduty
  severity                   Alert severity level - one of "info", "warning", "error"

Optional Args:
  region                     Region where alert originated
  user                       User name, if not the same as the logged in user
  email                      Email address receiving the alert (by default email associated with the account)
  slack-channel              Slack channel to be receiving the alert
  slack-api-url              Slack webhook url
  pagerduty-integration-key  PagerDuty Integration key
  pagerduty-api-version      PagerDuty API version("v1" or "v2"). By default "v2" is used
  appname                    App Instance name
  appvers                    App Instance version
  app-org                    Organization or Company name of the App Instance
  app-cloudlet               Cloudlet name where app instance is deployed
  app-cloudlet-org           Company or Organization that owns the cloudlet
  cluster                    App Instance Cluster name
  cluster-org                Company or Organization Name that a Cluster is owned by
  cloudlet                   Name of the cloudlet
  cloudlet-org               Company or Organization name of the cloudlet

Flags:
  -h, --help   help for create

```

Below is an example for a `create/delete/show` for the master controller alert receiver APIs.

The following creates a receiver that will process email notifications about app instance-specific alerts.

**HTTP REST:**

```
$ http --verify=false --auth-type=jwt --auth=$TOKEN POST https://127.0.0.1:9900/api/v1/auth/alertreceiver/create &lt;&lt;&lt; ’{"name":"DevOrgReceiver1","type":"email","severity":"error","appinst":{"app_key":{"organization":"DevOrg","name":"Face DetectionDemo","version":"1.0"},"clusterinstkey":{"clusterkey":{"name":"AppCluster"},"cloudlet_key":
{"organization":"mexdev","name":"localtest"},"organization":"DevOrg"}}}’
HTTP/1.1 200 OK
Content-Length: 0
Date: Thu, 10 Sep 2020 01:53:00 GMT
$

```

**mcctl:**

```
$ mcctl --addr https://0.0.0.0 alertreceiver create name=DevOrgReceiver1 type=email severity=error appname="Face Detection Demo" app-org="DevOrg" appvers="1.0" cluster=AppCluster cluster-org=DevOrg app-cloudlet=localtest app-cloudlet-org=mexdev
$

```

The above command will send all the alerts for this AppInstance to the email address associated with the user making this request (as specified in the $TOKEN env var in HTTP rest call).

Here is an example of a Slack receiver:

**HTTP REST:**

```
$ http --verify=false --auth-type=jwt --auth=$TOKEN POST https://127.0.0.1:9900/api/v1/auth/alertreceiver/create &lt;&lt;&lt; ’{"name":"DevOrgReceiver1Slack","type":"slack","slackchannel":"#alerts","slackwebhook":"[https://hooks.slack.com/services/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](https://hooks.slack.com/services/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)","severity":"error","appinst":{"app_key":{"organization":"DevOrg","name":"Face Detection Demo","version":"1.0"},"clusterinstkey":{"clusterkey":{"name":"AppCluster"},"cloudlet_key":{"organization":"mexdev","name":"localtest"},"organization":"DevOrg"}}}’
HTTP/1.1 200 OK
Content-Length: 0
Date: Thu, 10 Sep 2020 01:53:00 GMT
$

```

**mcctl:**

```
$ mcctl --addr https://0.0.0.0:9900 --skipverify alertreceiver create name=DevOrgReceiver1Slack type=slack slack-channel="#alerts" slack-api-url="[https://hooks.slack.com/services/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](https://hooks.slack.com/services/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)" severity=error appname="Face Detection Demo" app-org="DevOrg" appvers="1.0" cluster=AppCluster cluster-org=DevOrg app-cloudlet=localtest app-cloudlet-org=mexdev
$

```

The command options include the following:

- `region` - If specified, only alerts from this region will be sent to the receiver
- `name` - Name of the alert receiver. name+type+severify+user has to be unique together
- `type` - Type of the receiver. Currently “email“, “slack“, and "pagerduty" are valid strings.
- `severity` - Valid severities are “error“, “warn“, and “info“
- `email` - If specified, this email will be used to receive the notifications, by default it’s the email associated with the user configuring the alert receiver.

To check which receivers are present for the current user, the following API can be used:

**Note:** For Slack receivers, we hide API url( token is shown instead), since it’s something that can be used by a malicious user to send random messages to that Slack channel.

**HTTP REST:**

```
$ http --verify=false --auth-type=jwt --auth=$TOKEN POST https://127.0.0.1:9900/api/v1/auth/alertreceiver/show
HTTP/1.1 200 OK
Content-Length: 310
Content-Type: application/json; charset=UTF-8
Date: Fri, 25 Sep 2020 19:48:11 GMT
[
    {
        "AppInst": {
            "app_key": {
                "name": "Face Detection Demo",
                "organization": "DevOrg",
                "version": "1.0"
            },
            "cluster_inst_key": {
                "cloudlet_key": {
                    "name": "localtest",
                    "organization": "mexdev"
                },
                "cluster_key": {
                    "name": "AppCluster"
                },
                "organization": "DevOrg"
            }
        },
        "Cloudlet": {},
        "Name": "DevOrgReceiver1",
        "Severity": "error",
        "Type": "email"
    },
    {
        "AppInst": {
            "app_key": {
                "name": "Face Detection Demo",
                "organization": "DevOrg",
                "version": "1.0"
            },
            "cluster_inst_key": {
                "cloudlet_key": {
                    "name": "localtest",
                    "organization": "mexdev"
                },
                "cluster_key": {
                    "name": "AppCluster"
                },
                "organization": "DevOrg"
            }
        },
        "Cloudlet": {},
        "Name": "DevOrgReceiver1Slack",
        "Severity": "error",
        "Type": "slack",
        "SlackChannel": "#alerts",
        "SlackWebhook": "&lt;hidden&gt;"
    }

]
$
```

**mcctl:**

```
$ mcctl --addr https://0.0.0.0 alertreceiver show
- name: DevOrgReceiver1
  type: email
  severity: error
  appinst:
    appkey:
      organization: DevOrg
      name: Face Detection Demo
      version: "1.0"
    clusterinstkey:
      clusterkey:
        name: AppCluster
      cloudletkey:
        organization: mexdev
        name: localtest
      organization: DevOrg

- name: DevOrgReceiver1Slack
  type: slack
  severity: error
  slackchannel: ’#alerts’
  slackwebhook: &lt;hidden&gt;
  appinst:
    appkey:
      organization: DevOrg
      name: Face Detection Demo
      version: "1.0"
    clusterinstkey:
      clusterkey:
        name: AppCluster
      cloudletkey:
        organization: mexdev
        name: localtest
      organization: DevOrg

$
```

If a receiver is no longer needed, you can delete it.

**HTTP REST:**

```
$ http --verify=false --auth-type=jwt --auth=$TOKEN POST https://127.0.0.1:9900/api/v1/auth/alertreceiver/delete &lt;&lt;&lt; ’{"name":"DevOrgReceiver1","type":"email","severity":"error"}’
HTTP/1.1 200 OK
Content-Length: 0
Date: Thu, 10 Sep 2020 02:03:27 GMT
$

```

**mcctl:**

```
$ mcctl --addr https://127.0.0.1 alertreceiver delete name=DevOrgReceiver1 type=email severity=error
```

## Alert Policy

**Note:** This feature is currently supported for Kubernetes apps only.

You can use the command `useralert` to monitor app resource usage and be alerted if any of the application instances of the application violate the alert policy. Alert policies include measurements such as **CPU usage**, **Memory usage**, **Disk usage**, and the **number of active connections**. You can combine your rules into a single `useralert`, such as `cpu &gt; 80% and memory &gt;50%`. However, you cannot combine the number of active connections rule with any other rules; it must be a single rule.

### Alert policy usage

Below is usage help for the `alertpolicy` and `addalertpolicy` commands.

```
$ mcctl alertpolicy create -h

Create an Alert Policy

Usage: mcctl alertpolicy create [flags] [args]

Required Args:
  region              Region name
  alert-org           Name of the organization for the app that this alert can be applied to
  name                Alert Policy name
  severity            Alert severity level - one of info, warning, error

Optional Args:
  cpu-utilization     container or pod CPU utilization rate(percentage) across all nodes. Valid values 1-100
  mem-utilization     container or pod memory utilization rate(percentage) across all nodes. Valid values 1-100
  disk-utilization    container or pod disk utilization rate(percentage) across all nodes. Valid values 1-100
  active-connections  Active Connections alert threshold. Valid values 1-4294967295
  trigger-time        Duration for which alert interval is active
  labels              Additional Labels, specify labels:empty=true to clear
  annotations         Additional Annotations for extra information about the alert, specify annotations:empty=true to clear

Flags:
  -h, --help   help for create

$ mcctl app addalertpolicy -h

Add an AlertPolicy to the App

Usage: mcctl app addalertpolicy [flags] [args]

Required Args:
  region            Region name
  app-org           App developer organization
  appname           App name
  appvers           App version
  alertpolicy-name  Alert name

Flags:
  -h, --help   help for addalertpolicy

```

#### Create an alert policy

```
$ mcctl alertpolicy create region=local alert-org=DevOrg name=CpuSpike severity=error cpu-utilization=80  mem-utilization=20 trigger-time=30s
```

The command options include the following:

- `severity`: Valid severities include “info“, “warning“, “error“
- `cpu-utilization`, `mem-utilization`: These values are percentages of the total cluster CPU and memory usage by all the pods of the specified k8s app
- `trigger-time`: This is how long the alert condition needs to be met before it will fire an alert

**Note:** Utilization percentage is across all the cluster nodes, so if the app only has a single container, which can utilize only a single node of the cluster, the percentages need to be updated accordingly.

#### Example: Create an alert policy with labels and annotations using show to filter the Alert Policy

```
$ mcctl alertpolicy create region=US name=CPUerrorAlertPolicy severity=error trigger-time=90s alert-org=wwtdev cpu-utilization=60 labels="CPUalert"="Error003" labels="myalertname"="AppInstanceResourceUsage" labels=wwtdev=tomd annotations=description="[CPU] somedev Error003 on alertpolicytest critical needs 1.21 gigawatts of power"

curl -X POST "https://console.mobiledgex.net:443/api/v1/auth/ctrl/CreateAlertPolicy" -H "Content-Type: application/json" -H "Authorization: Bearer ${TOKEN}" --data-raw ’{"AlertPolicy":{"annotations":{"description":"[CPU] somedev Error003 on alertpolicytest critical needs 1.21 gigawatts of power"},"cpu_utilization_limit":60,"key":{"name":"CPUerrorAlertPolicy","organization":"wwtdev"},"labels":{"CPUalert":"Error003","myalertname":"AppInstanceResourceUsage","wwtdev":"tomd"},"severity":"error","trigger_time":"1m30s"},"Region":"US"}’
{}
```

#### Show using labels

```
mcctl alertpolicy show labels="myalertname"="AppInstanceResourceUsage" region=US
2- key:
3 organization: wwtdev
4 name: CPUerrorAlertPolicy
5 cpuutilizationlimit: 60
6 severity: error
7 triggertime: 1m30s
8 labels:
9 CPUalert: Error003
10 myalertname: AppInstanceResourceUsage
11 wwtdev: tomd
12 annotations:
13 description: ’[CPU] somedev Error003 on alertpolicytest critical needs 1.21 gigawatts 14 of power’
```

#### Show using annotations

```
mcctl alertpolicy show annotations=description="[CPU] somedev Error003 on alertpolicytest critical needs 1.21 gigawatts of power" region=US
- key:
    organization: wwtdev
    name: CPUerrorAlertPolicy
  cpuutilizationlimit: 60
  severity: error
  triggertime: 1m30s
  labels:
    CPUalert: Error003
    myalertname: AppInstanceResourceUsage
    wwtdev: tomd
  annotations:
    description: ’[CPU] somedev Error003 on alertpolicytest critical needs 1.21 gigawatts
      of power’

```

### 

<br>
<strong>Add an alert policy to the app

Once an alert policy is created, add it to the app but specifying the `appname`.

```
$ mcctl app addalertpolicy region=local appname="Face Detection Demo" app-org=DevOrg appvers="1.0" alertpolicy-name=CpuSpike

```

The command options include the following:

- `alert-name`: Name of the alert policy

#### Create an alert receiver

Once the alert policy is created and added to the app, create an alert receiver so the alert can be processed and an alert notification can be sent out.

```
$ mcctl alertreceiver create name=FacedetectionReceiver type=email email="somebody@nowhere.net" severity=error appname="Face Detection Demo" app-org="DevOrg" appvers="1.0" cluster=AppCluster cluster-org=DevOrg app-cloudlet=localtest app-cloudlet-org=mexdev

```

- `severity`: Since the alert policy we created had a severity of `error` , only the receivers with the severity of `error` can receive that alert.

The example below will monitor this alert across the whole region with the following receiver. The alert receiver will receive alerts triggered for any instance of the app in the region where the alert policy was created.

```
$ mcctl alertreceiver create name=FacedetectionReceiverAll type=email email="somebody@nowhere.net" severity=error appname="Face Detection Demo" app-org="DevOrg" appvers="1.0"
```

