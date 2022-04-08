---
title: Resource Management and Reporting
long_title:
overview_description:
description: Describes the report scheduler feature
---

**Note:** This feature is currently supported for OpenStack and VCD platforms.

MobiledgeX makes it easy to manage, plan, and address resource capacity for cloudlets through our Controller. While your IaaS platform can monitor resources, you won’t benefit from getting notified through our alerting system when resources are impacted or exceed defined thresholds. With our MobiledgeX Controller, you can be alerted once the Controller detects an issue, allowing you to respond quickly by modifying or increasing the resource limits and capacity. This decreases the chances that developers will experience a delay in deploying their clusters or app instances due to things such as resource limits.

There are several `mcctl` commands you can use to leverage this feature. Some of these commands include `resourcequotaprops`, `getresourceusage`, and `cloudletinfo show`. All these commands provide a detailed view into resource capacities, where you can modify as needed and then set up your alerts based on the given values.

**Example of usage**

As an operator, you are using OpenStack and want to view the current resource quotas to manage. You run the command:

```
cloudlet getresourcequotaprops region=EU platformtype=PlatformTypeOpenstack  organization= testorg1
```

You will see several properties that you can manage:

- RAM
- vCPU
- GPUs
- Instances
- Floating IPs
- External IPs

**Note:** RAM, vCPU, External IPs and GPUs properties shown are independent of the IaaS platform used. Other properties displayed are specific to your IaaS platform.

**Input example:**

```
cloudlet getresourcequotaprops region=EU platformtype=PlatformTypeOpenstack organization=testorg1

properties:

-name: RAM
description: Limit on RAM available (MB)
-name: vCPUs description: Limit on vCPUs available
-name: GPUs
description: Limit on GPUs available
-name: External IPs
description: Limit on external IPs available
-name: Instances
description: Limit on number of instances that can be provisioned
-name: Floating IPs
description: Limit on number of floating IPs that can be created
```

To view your cloudlet’s resource limits, enter this command: `cloudlet show region=EU cloudlet=cloudlet1`

**Input example:**

```
cloudlet show region-EU cloudlet=testcloudlet1
-key;
organization: testorg1
name: cloudlet1
location:
latititude: 54.44345
 longitude: 9.94854

ipsupport: IpSupportDynamic
numdynamicips: 250
state: Ready
platformtype: PlatformTypeOpenstack
notifysrvaddr: 127.0.0.1:0
flavor:
  name: DefaultPlatformFlavor

physicalname: munich
containerversion: "2021-07-15"
restagmap:
  gpu:
   name: mygpuresource
   organization: testorg1

deployemt: docker
crmaccesspublickey: |
-----BEGIN PUBLIC KEY-----

MCgjgiorjro45040grtk4pt4t04tk4t4tk-gkg4k-tgjriogj=
-----END PUBLIC KEY-----
createdat:
 seconds: 1345456

nanos: 56567656
trustpolicystate: NotPresent
resourcequotas:
-name: vCPUs
value: 20
alerthreshold: 80
defaultresourcealertthreshold: 80
```

In the above example, you can either increase or decrease your `alerthreshold.` The resource limit set for vCPUs is `20` and based on the `alertthreshold` of `80`, an alert will be triggered when the cloudlet vCPU usage exceeds `16`. An email is sent to you warning you that you have exceeded more than 80 percent of the vCPUs. Armed with this information, you can increase your resource for your cloudlets based on the alert. To find out the current resource usage of your cloudlet:

```
cloudlet getresourceusage region=EU cloudlet=automationMunichCloudlet cloudlet-org=TDGkey:organization: TDGname: automationMunichCloudletinfo:

-name: External IPs
value: 5in
framaxvalue: 1004
alertthreshold: 80
-name: Floating IPsi
nframaxvalue: 10
alertthreshold: 80
-name: GPUs
value: 1
alertthreshold: 80
-name: Instances
value: 13
inframaxvalue: 100
alertthreshold: 80
-name: RAM
value: 49152
inframaxvalue: 512000
units: MB
alertthreshold: 80
-name: vCPUs
value: 30
inframaxvalue: 200
quotamaxvalue: 40
alertthreshold: 80
```

Now, to view more information about your cloudlet, you can use the command `cloudletinfo show`.

The following example shows a snippet of the code which contains a section called `resourcesnapshot` when you run the `cloudletinfo show` command. You can view details about your platform VM, shared rootLB, cluster instances deployed on the cloudlet, and more.

```
resourcessnapshot:
platformvms:
-name: testorg1-reportorg1-pf
  type: platform
  status: ACTIVE

infraflavor: m4.medium
ipaddresses:
-externalip: 80:192:344:212
-name: testorg1.reportorg1.mobiledge.net
type:rootlb
status: ACTIVE
infraflavor: m4.medium
...
```

More details about these commands can be found in the [mcctl Utility Reference](/operator/operator-specific-mcctl-and-rest-apis/mcctl-reference) guide.

### Report Scheduler

The Report Scheduler lets you run custom reports and provides detailed information about cloudlet usages. The MobiledgeX platform can determine your timezone and provides a configurable calendar to run your reports based. The report is generated in .pdf format and can be scheduled based on intervals you define.

The report information may include, but not limited to, the following information:

- Cloudlets
- Platform type
- Cloudlet’s last known state
- Cloudlet pool with their associated cloudlets
- A list of developers who are either in the pending state or have accepted the invitation to join your cloudlet pool
- Flavor usage count
- Cloudlet Alerts
- Developer Application state
- RAM and VCPU usages
- Graphical representation of all usages

Viewing, running, and creating reports are role-based. Please refer to the table below.
<table>
<tbody>
<tr>
<td colspan="1" rowspan="1">

**Role**
</td>
<td colspan="1" rowspan="1">

**View Report**
</td>
<td colspan="1" rowspan="1">

**Generate Report**
</td>
<td colspan="1" rowspan="1">

**Create Report Scheduler**
</td>
</tr>
<tr>
<td>OperatorManager</td>
<td>x</td>
<td>x</td>
<td>x</td>
</tr>
<tr>
<td>OperatorContributer</td>
<td>x</td>
<td>x</td>
<td>x</td>
</tr>
<tr>
<td>OperatorViewer</td>
<td>x</td>
<td>x</td>
<td></td>
</tr>
</tbody>
</table>

**Creating a report scheduler:**


- On the left navigation, select **Reports**.
- On the Report Scheduler screen, click the **+** sign.
- The Create Report Scheduler screen opens.


![Create Report Scheduler screen](/operator/assets/create-report-scheduler.png "Create Report Scheduler screen")


- Populate the required fields.

a. **Name:** Type a name for the report<br>b. **Organization:** This is auto-populated based on the organization you are currently managing.<br>c. **Email:** Type in an email address to send the reports.<br>d. **Report Interval:** Select Every Week, Every 15 days, or Every Month. The default is Every Week.<br>e. **Start Schedule Date:** Click the field to display a calendar to select a start date for when to start sending the report. Historical dates, however, cannot be specified.<br>f. **Timezone:** Select your appropriate timezone.
- Select **Create**.
- The report is added to the Report Scheduler screen.


**Note:** When you create a report scheduler for a future date, the Last Report Status column may display a red X. This means that the report is in a pending state. It will turn into a green checkmark once the report is run as scheduled.

![Report Scheduler list](/operator/assets/report-scheduler-list.png "Report Scheduler list")


- Select the **Generate** button to generate a .pdf of the usage report to download locally.
- You can use the Actions menu to either **Update** or **Delete** the report(s).


You can also create and manage reports using the `mcctl` commands.

### Using Kafka to push cloudlet events

MobiledgeX supports [Kafka](https://aws.amazon.com/msk/what-is-kafka/) to help operators manage real-time data streams. By providing operators with events streaming API, events can be pushed directly to a server (Kafka cluster) that the operator provides to MobiledgeX. Currently, MobiledgeX supports pushing cloudlet-related events to the Kafka cluster.

Any cloudlet-related events will get pushed to the Kafka cluster since Kafka is set up on a per-cloudlet basis. However, operators can also view developer-related events, including app instances events, if the cloudlet is part of the cloudlet pool.

Kafka sends messages to *topics*, and each topic contains specific messages. When configuring cloudlets for the Kafka, the Kafka cluster requires two topics to be created.

```
operator-&lt;cloudlet-name&gt;
developer-&lt;cloudlet-name&gt;
```

There are two options for creating these topics:

- Cluster is configured to allow auto creation of topics, in which case the topics will be created when the first event for the topic is sent to the cluster.
- Cluster is NOT configured to allow auto creation of topics. Operator must create the topics manually in the cluster.


**Note:** Currently, we do not support developer-related audit events within the `--topic developer`; only developer-related events are supported at this time.

#### Configure Kafka server detail to receive events for cloudlets


- Follow the steps on how to set up your [Kafka server](https://kafka.apache.org/documentation/).
- When you create a new cloudlet, make sure to specify the following fields: `kafkacluster`, `kafkauser`, and `kafkapassword`.


**Note:**
`kafkacluster` is the URL of the Bootstrap endpoint. If you are using the Confluent Cloud, this is shown in the cluster settings:

![](/operator/assets/cluster.png "")

`kafkauser` and `kafkapassword` = A valid user/pass for the cluster OR an API Key / Secret if an API key has been set up for the cluster.

**Example config:**

```
-region:
localappdata:cloudlets:
-key:
   organization: operdev
   name: testcloudlet
   location:
   latitude: 32
   longitude: -90
   ipsupport: IpSupportDynamic
   numdynamicips: 255
   platform: PlatformTypeEdgebox
   kafkacluster: localhost: 9092
   kafkauser: admin
   kafkapassword: admin-secret

```


- Once you have your Kafka details, pass the information to MobiledgeX admin support.<br>


To learn more about Kafka, see the [Kafka Documentation](https://kafka.apache.org/documentation/).<br>

