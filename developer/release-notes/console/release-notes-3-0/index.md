---
title: 3.0
long_title: MobiledgeX Edge-Cloud Release Notes for 3.0
overview_description:
Edge-Cloud Console Release Notes 3.0

description:
MobiledgeX Edge-Cloud Console Release Notes 3.0

---

The **MobiledgeX** **Edge-Cloud 3.0** release offers many new features and enhancements. The following release notes cover details about these features and improvements and provide a list of known issues.

Documentation and resources can be found on our [Developer Portal](https://developers.mobiledgex.com/) where we continuously publish new content and resources to help you realize the potential of our solutions and offers.

### New Features on Edge-Cloud

<table>
<tbody>
<tr>
<th>

<strong>Title</th>
<th colspan="1" rowspan="1">

<strong>Description</th>
</tr>
<tr>
<td>

Developers to join Cloudlet Pool</td>
<td colspan="1" rowspan="1">

Developers can now become a member of a cloudlet pool based on Operator’s invitation.

Learn more about Cloudlet Pools [here](/deployments/deployment-workflow/cloudlet-pools). </td>
</tr>
<tr>
<td>

Alert Policy</td>
<td colspan="1" rowspan="1">

You can now set up alert policies to further monitor your applications and be alerted when applications violate those policies. Alert policies include things like CPU usage, Memory usage, Disk usage, and the number of active connections.

This feature is currently supported for Kubernetes apps only.

Learn more about Alert Policies [here](/design/testing-and-debugging/alarms#alert-policy). </td>
</tr>
<tr>
<td>

App Instance alerts</td>
<td colspan="1" rowspan="1">

We now generate app instance alerts when the CPU exceeds the defined levels, when the memory exceeds the defined levels, or when the app instance restarts.

Learn more about App Instance Alerts [here](/design/testing-and-debugging/alarms). </td>
</tr>
<tr>
<td>

Alert Severity</td>
<td colspan="1" rowspan="1">

You can now classify alerts based on severity levels.  The severity levels include info, warning, and error.

Learn more about Alert Severity [here](/design/testing-and-debugging/alarms). </td>
</tr>
<tr>
<td>

Monitoring Events and Usage</td>
<td colspan="1" rowspan="1">

We have made significant enhancements to the monitoring components. In addition to collecting events and audit events for applications, clusters, and cloudlets, retrieving this data is now performed using the combined events and audits commands. Our search capabilities have been expanded with additional filter and tag options to further refine your search, and you can go from a Live view and switch view to perform a more specific search. Usage logs, which let you view application instances, across client devices, locations, etc., help you understand the application activity occurring within your cloudlets. You can also view usage logs for cluster instances and cloudlet pools.

Learn more about events and usage logs [here](/deployments/monitoring-and-metrics/logs). </td>
</tr>
<tr>
<td>

Monitor Client Edge Events </td>
<td colspan="1" rowspan="1">

You can now view client application data and usage through the Monitoring console. The data can be filtered based on application instance, location, and the type of network used.  However, no location data, user information, and devices are accessible since MobiledgeX does not store that information. Only statistical aggregated data can be viewed.

Learn more about how to use and view edge events [here](/deployments/monitoring-and-metrics/monitoring-edge-events). </td>
</tr>
<tr>
<td>

Health Checks on VM</td>
<td colspan="1" rowspan="1">

We now support application-level health checks on VMs so that when a VM is stopped, a **Healthcheck Fail Server** alert is sent.

Learn more about health checks [here](/design/testing-and-debugging/health-check). </td>
</tr>
<tr>
<td>

Helm Chart support</td>
<td colspan="1" rowspan="1">

We now support Helm Chart v3.

See supported application types [here](/deployments/supported-apps-types). </td>
</tr>
<tr>
<td>

Accessing GPU drivers</td>
<td colspan="1" rowspan="1">

You can now access public GPU drivers owned by the Operator that is associated with your GPU cloudlets.</td>
</tr>
<tr>
<td>

Support for vGPU

###


<br>
</td>
<td colspan="1" rowspan="1">

We now support GPU access.</td>
</tr>
<tr>
<td>

Kubernetes clusters and GPU resource</td>
<td colspan="1" rowspan="1">

We now support Kubernetes clusters with GPU.

Learn how to use GPUs on MobiledgeX [here](/deployments/application-deployment-guides/gpu). </td>
</tr>
<tr>
<td>

Windows 10 VM image on MobiledgeX Platform</td>
<td colspan="1" rowspan="1">

Developers can deploy Windows VM on MobiledgeX Platform using QCOW 2.

Learn how to do deploy Windows VMs [here](/deployments/application-deployment-guides/virtual-machine/windows). </td>
</tr>
<tr>
<td>

Active connections with AutoScale policy</td>
<td colspan="1" rowspan="1">

In addition to CPU, the auto-scale policy can also be based on the number of active connections, memory, and CPU utilization to allow for scaling based on these multiple metrics.

Learn more about Auto Scale [here](https://dev-stage.mobiledgex.com/deployments/application-runtime/autoscale#auto-scale-policy--).</td>
</tr>
<tr>
<td>

Health Check and IAAS Cloudlets</td>
<td colspan="1" rowspan="1">

Health Check will now fail if the IAAS cloudlets go down.</td>
</tr>
<tr>
<td>

K8 deployment with custom namespaces</td>
<td colspan="1" rowspan="1">

You can now provide custom namespaces for K8s deployments.</td>
</tr>
</tbody>
</table>

### Behavior changes and enhancements

<table>
<tbody>
<tr>
<td>

**Title**
</td>
<td colspan="1" rowspan="1">

**Description**
</td>
</tr>
<tr>
<td>

Flavor selection for cluster and app instances</td>
<td colspan="1" rowspan="1">

Previously, you can select a cloudlet and flavor based on regions when you create a cluster or application instance. In this release, we have made changes so that only the flavors that support those cloudlets appear as options when a cloudlet or a list of cloudlets are selected. Further, only cloudlets that support the flavor are available in the selection list when a flavor is selected.</td>
</tr>
<tr>
<td>

Two-Factor authentication</td>
<td colspan="1" rowspan="1">

You can now turn on/off two-factor authentication.</td>
</tr>
<tr>
<td>

Autoscale policy changes</td>
<td colspan="1" rowspan="1">

We have now added UI support to configure the active connections in the autoscale policy based on the number of connections. Additionally, you can now scale by memory and CPU usage.

Learn more about Autoscale policies [here](/deployments/application-runtime/autoscale).</td>
</tr>
<tr>
<td>

Delete Alert Receivers</td>
<td colspan="1" rowspan="1">

Previously when a user was deleted, the alert receiver associated with the user’s name could not be deleted. Now, as an OrgAdmin, you can now delete alert receivers after the user has been deleted.</td>
</tr>
<tr>
<td>

K8s pods with multiple containers</td>
<td colspan="1" rowspan="1">

Developers can now select multiple containers using the **runcommand** and **showlogs** for application instances that have multiple containers within the pods.</td>
</tr>
<tr>
<td>

Configurable support for upper limits of UDP packet sizes</td>
<td colspan="1" rowspan="1">

You can now deploy upper limit UDP packet sizes by configuring specific UDP ports. Previously, the default UDP packet size limit was 1500, and UDP packets larger than the limit were being dropped. You can now configure specific individual UPD ports for the application to increase support for upper limit size UDP packets. </td>
</tr>
<tr>
<td>

Rate Limiting</td>
<td colspan="1" rowspan="1">

MobiledgeX has enforced limitations to the number of requests you can make for API calls within a time window. Once you have reached the rate limiter cap, additional requests sent to the API are blocked. Rate limiting applies to the Master Controller and DME APIs. <br>
<br>The rate limit defaults for DME are as follow:

** **

<table>
<tbody>
<tr>
<td colspan="1" rowspan="1">

**Per IP**
</td>
<td colspan="1" rowspan="1">

Requests per second 10000   / burst size 100</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

**All Requests**
</td>
<td colspan="1" rowspan="1">

Requests per second 25000 /burst size 500</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

**VerifyLocation All Requests**
</td>
<td colspan="1" rowspan="1">

Requests per second 5000 /burst size 50</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

**VerifyLocation Per IP**
</td>
<td colspan="1" rowspan="1">

Requests per second 1000 /burst size 25</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

**Persistent Connection**
</td>
<td colspan="1" rowspan="1">

Request per second 100 /burst size 100</td>
</tr>
</tbody>
</table>



The rate limit defaults the Master Controller are as follow:

** **

<table>
<tbody>
<tr>
<td colspan="1" rowspan="1">

**Per IP**
</td>
<td colspan="1" rowspan="1">

Requests per second 1000.    / burst size 100</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

**Per User**
</td>
<td colspan="1" rowspan="1">

Request per second 1000 /burst size 100</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

**All Requests**
</td>
<td colspan="1" rowspan="1">

Requests per second 10000 /burst size 500</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

**User Create All Requests**
</td>
<td colspan="1" rowspan="1">

Requests per second 100 /burst size 5</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

**User Create Per IP**
</td>
<td colspan="1" rowspan="1">

Request per second 2    /burst size 2</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>

### Known Issues

<table>
<tbody>
<tr>
<td colspan="1" rowspan="1">

**Title**
</td>
<td colspan="1" rowspan="1">

**Description**
</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

App name is not displayed when deleting failed apps</td>
<td colspan="1" rowspan="1">

Currently, when deleting a failed application, the name of the failed application does not appear, making it difficult to know which ones failed when performing a bulk deletion. This also applies to deleting failed clusters where the name of the failed cluster is not displayed.

This is currently no Workaround.</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

Using images from unauthorized repositories</td>
<td colspan="1" rowspan="1">

While you can use images from unauthorized repositories to create app instances, MobiledgeX will not scan image security.</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

Kubernetes manifest and image path</td>
<td colspan="1" rowspan="1">

Currently, even though you have referenced an image path in the Kubernetes manifest, you are still required to specify the image path again in the Image Path field on the UI.</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

Incorrect login attempts</td>
<td colspan="1" rowspan="1">

Currently, we do not lock out users if multiple login attempts fail. However, there is a one-second penalty delay when users input an invalid username or password, making it difficult for Bots to compromise user credentials.</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

VM image size limitation</td>
<td colspan="1" rowspan="1">

Depending on the underlying infrastructure, there may be size limitations to the supported image size for VMs.</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

Edge Events: FindCloudlet Event</td>
<td colspan="1" rowspan="1">

If a cloudlet with your Application Instance goes into maintenance or offline and then returns to NormalOperation, an Edge Event will not be fired even if that cloudlet has lower latency to the end device.

If an Application Instance fails a health check and then starts passing the Health check, an Edge Event will not be fired even if that cloudlet has a lower latency to the end device. </td>
</tr>
<tr>
<td colspan="1" rowspan="1">

Health checks may not work with some applications</td>
<td colspan="1" rowspan="1">

Our health check makes TCP connections to exposed ports and closes them right away. If this is unexpected from the application side, health-check should be turned off for those application ports.</td>
</tr>
</tbody>
</table>

