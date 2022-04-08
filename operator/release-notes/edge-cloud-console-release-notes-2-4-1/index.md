---
title: 2.4.1
long_title: Edge-Cloud Release Notes for 2.4.1
overview_description:
description: Edge-Cloud Release Notes for 2.4.1
---

With the release of **Edge-Cloud 2.4.1**, several new features and enhancements are offered. The following release notes cover details about these features and enhancements as well as provide a list of known issues.

Documentation and resources can be found on our **Operator Portal**, where we continuously publish new content and resources to help you realize the potential of our solutions and offering.

The table below lists specific features and enhancements added to our **Edge-Cloud Console**.

### New Features on Edge-Cloud Console

<table>
<tbody>
<tr>
<th>Title</th>
<th>Description</th>
</tr>
<tr>
<td>Support for VCD Deployment (beta)</td>
<td>MobiledgeX now supports vCD deployment v10.0-10.2 where the Operator provides a Tenant on their existing vCD to MobiledgeX. This approach allows the Operator to remain in control of the vCD and its associated external networking and switch configurations. </td>
</tr>
<tr>
<td>PagerDuty Receiver Notifications</td>
<td>We now support PagerDuty integration for Alert Manger notifications.</td>
</tr>
<tr>
<td>Invite Developers to join Cloudlet Pool</td>
<td>Invitations can now be sent to Developers to join Cloudlet Pools. Once Developers are part of the Cloudlet Pool, Operators can be alerted when quota limits are reached, cloudlets are down, and Developer metrics and logs can be viewed and assessed.</td>
</tr>
</tbody>
</table>

### Behavioral Changes on Edge-Cloud Console

<table>
<tbody>
<tr>
<th>Title</th>
<th>Description</th>
</tr>
<tr>
<td>Disabling Edgebox</td>
<td>Members of your organization, by default, will not be able to immediately create cloudlets. The option **Edgebox** must be *disabled* by the MobiledgeX Admin to grant members the permission to create cloudlets. The goal of this feature is to ensure and preserve the integrity of the Operator’s enterprise infrastructure. Please contact your MobiledgeX Admin to disable **Edgebox**.</td>
</tr>
<tr>
<td>Direct Access</td>
<td>The ability to route traffic directly to your application instance is no longer available. </td>
</tr>
<tr>
<td>Privacy Policy has been renamed</td>
<td>We have renamed **Privacy Policy** to **Trust Policy**. Currently, this feature is enabled when you create a cluster.  However, we’ve recently made a change where the feature is now applied during the creation of a cloudlet. This allows the policies to be defined by the Operator at the cloudlet level in order to enforce privacy on apps.</td>
</tr>
</tbody>
</table>

### Known issues

<table>
<tbody>
<tr>
<th>Title</th>
<th>Description</th>
</tr>
<tr>
<td>Port restrictions for Docker and VM deployment types</td>
<td colspan="1" rowspan="1">

The current maximum allowed is as follow:

- TCP ports= 1000
- UDP ports- 10000

</td>
</tr>
<tr>
<td>Port restrictions for Kubernetes deployment type</td>
<td colspan="1" rowspan="1">

- TCP ports= 1000
- UDP ports- 1000

</td>
</tr>
<tr>
<td>MobiledgeX LB traffic packet size limitation</td>
<td>Support for MobiledgeX Load Balancer UDP packet size is currently up to 1440 bytes. Larger packets are not supported at this time. </td>
</tr>
<tr>
<td>Audit logs</td>
<td>The maximum allowed days you can search for audit logs is one day (within the last 24hrs). </td>
</tr>
<tr>
<td>Monitoring: Refresh rate is consistent</td>
<td colspan="1" rowspan="1">

You may experience a delay in refresh rate (in seconds), often times between the graph and measurement data, when you attempt to refresh.

<br>
**Workaround:** None</td>
</tr>
<tr>
<td>Trust Policy on vSphere</td>
<td colspan="1" rowspan="1">

Currently, this is not supported.

**Workaround:**  None</td>
</tr>
<tr>
<td>Trust Policy on VMPool</td>
<td colspan="1" rowspan="1">

Currently, this is not supported.

**Workaround:**  None</td>
</tr>
<tr>
<td>Restricted Cloudlets on VMPool</td>
<td colspan="1" rowspan="1">

The onboarding of restricted Cloudlets on VMPool through the Edge-Cloud Console does not work.

**Workaround:** Contact the MobiledgeX CloudOps team for assistance with this deployment.</td>
</tr>
<tr>
<td>vSphere restricted access fails to retrieve manifest</td>
<td colspan="1" rowspan="1">

Attempting to create a restricted access Cloudlet for vSphere fails when retrieving the manifest.

**Workaround:** Contact the MobiledgeX CloudOps team to deploy manually.</td>
</tr>
<tr>
<td>VCD support for Cloudlet deployment and Restricted on boarding</td>
<td colspan="1" rowspan="1">

This is currently not supported through the Edge-Cloud Console.

**Workaround:** Contact the MobiledgeX CloudOps team for assistance with this deployment.</td>
</tr>
<tr>
<td>Automatic Onboarding through the Edge-Cloud Console for VCD supported Cloudlet deployment</td>
<td colspan="1" rowspan="1">

This is currently not supported.

**Workaround:** Contact the MobiledgeX CloudOps team for assistance with deployment.</td>
</tr>
<tr>
<td>Automatic Onboarding through the Edge-Cloud Console for VMPool</td>
<td colspan="1" rowspan="1">

This is currently not supported.

**Workaround:** Contact the MobiledgeX CloudOps team for assistance with deployment.</td>
</tr>
<tr>
<td>GPU on vSphere</td>
<td colspan="1" rowspan="1">

Deploying applications using GPU as the Flavor type on vSphere Cloudlet is currently not supported.

**Workaround:** None</td>
</tr>
<tr>
<td>GPU on VCD</td>
<td colspan="1" rowspan="1">

Deploying applications using GPU as the Flavor type on VCD Cloudlet is currently not supported.

**Workaround:** None</td>
</tr>
<tr>
<td>GPU on VMPool</td>
<td colspan="1" rowspan="1">

Deploying applications using GPU as the  Flavor type on VMPool is currently not supported.

**Workaround:** None</td>
</tr>
<tr>
<td>VM deployment on VMPool</td>
<td colspan="1" rowspan="1">

Currently, VM deployment on VMPool is not supported.

**Workaround:** None</td>
</tr>
<tr>
<td>VM metrics on vCD</td>
<td colspan="1" rowspan="1">

Currently, viewing VM. metrics on vCD is not supported.

Workaround: None</td>
</tr>
</tbody>
</table>

