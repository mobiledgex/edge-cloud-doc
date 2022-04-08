---
title: 2.4
long_title: Edge-Cloud Release Notes for 2.4
overview_description:
description: Edge-Cloud Release Notes for 2.4
---

With the release of Edge-Cloud 2.4, several new capabilities and enhancements are offered, including an improved monitoring tool, implementation of CAPTCHA, new events generated for cloudlets, an alarm framework, and much more. These features offer Developers and Operators a secure way of managing accounts and provide powerful tools that easily enable both communities of users to monitor and manage their applications and cloudlets usage. Our improvements simplify day-to-day operations that quickly and proactively help mitigate issues that may arise due to performance irregularities.

Documentation and resources can be found on our [Developer Portal](/developer), where we continuously publish new content and resources to help you realize the potential of our solutions and offerings.

The table below lists specific features added to our [Edge-Cloud Console](https://console.mobiledgex.net/site1?pg=0).

### New Features on Edge-Cloud Console

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
<td>Alert Framework</td>
<td>Currently a beta feature, MobiledgeX’s Platform provides an **AlertManager** that serves as the global component responsible for distributing alerts to application owners and cloudlet operators. Alarms are consolidated at the regional level, where each regional controller receives alarms. Based on the user configuration, an alert receiver can be created, and depending on user preference; an alert notification is sent via email or Slack to the user for mitigation.</td>
</tr>
<tr>
<td>Alert Receivers</td>
<td colspan="1" rowspan="1">

A new Alert Receivers sub-menu is added to simplify the creation of alert receivers. Users can set up alert receivers for application instances, clusters, and cloudlets.

Additionally, AlertReceiver APIs have been added through the mcctl utility program to provide users flexibility to integrate with their existing monitoring systems.

AlertReceiver APIs include:

- **api/v1/auth/alertreciver/create**
- **api/v1/auth/alertreceiver/delete**
- **api/v1/auth/alertreceiver/show**

</td>
</tr>
<tr>
<td>Monitoring</td>
<td colspan="1" rowspan="1">

A more simplified interface is implemented to help users continue to filter and display analytics and data for clusters, application instances, and cloudlets, where filtering can be done by *App Inst*, *Cluster Inst*, *Cloudlet, and Org.*  **Audit**, **Event**, and **Usage** detailed logs can all be viewed through the Monitoring page by selecting a drop-down icon. The details of all **Alerts** generated can also be viewed from this page.

- **Audit logs:** Logs user activities such as logging, creating applications, deleting users, creating policies, etc.
- **Event logs:** These are system-generated events and can include services such as auto-provision policy, auto-scaling, application instance, or HA, where our platform will trigger events based on these user policies.
- **Usage Log:** These logs are generated to view the status (online or offline) of clusters, application instances status, or Cloudlets, and maintenance status.

</td>
</tr>
<tr>
<td>App event log displayed for an app instance (Developer interface)</td>
<td>On the Monitoring page, we now display event logs for application instances deployed via the auto-provision policy for reservable cluster instances.</td>
</tr>
<tr>
<td>Auto-Provision Policy Undeploy (Developer interface)</td>
<td>We now provide the ability to undeploy application instances based on the threshold and value set for the **Undeploy Request Count** and **Undeploy Interval Count(s)**.</td>
</tr>
<tr>
<td>Cloudlet selection for HA ****(Operator interface)</td>
<td>Previously for HA-based cloudlets, two cloudlets in the same location would only allow one cloudlet to be utilized while the other stayed idle. Now, with the implementation of randomized cloudlet selection, both cloudlets can be utilized.</td>
</tr>
<tr>
<td>Cloudlet Events (Operator interface)</td>
<td>Alerts and events are now generated for cloudlets that are down, in the process of upgrading, or are in maintenance mode. These events can be viewed through the Monitoring page. Operators can set up alert receivers to receive an alert notification when these alarms are triggered.</td>
</tr>
<tr>
<td>Bot Protection</td>
<td>With the implementation of **CAPTCHA**, users are now presented with a **CAPTCHA** checkbox during registration. If the system detects suspicious behavior, further validation will be required through an image recognition task.</td>
</tr>
<tr>
<td>Two-Factor Authentication (2FA)</td>
<td>Users can *optionall*y set this up during account registration for an added security layer, where an additional step of verification is required during sign-in.</td>
</tr>
<tr>
<td>Strong Passwords</td>
<td>Passwords now must meet all password requirements and guidelines to help thwart possible brute force attacks. In addition to the password requirements, password **strength** must also meet all scoring requirements provided by MobiledgeX through an entropy scoring system for passwords to be considered strong.</td>
</tr>
</tbody>
</table>

### Known Issues

There are no known issues documented at this time.

