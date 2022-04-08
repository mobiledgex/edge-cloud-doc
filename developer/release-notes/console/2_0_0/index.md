---
title: 2.0
long_title: MobiledgeX Edge-Cloud Console Release Notes 2.0
overview_description: 
description: 
Lists new features and known issues for the MobiledgeX Edge-Cloud Console.

---

With the release of [Edge-Cloud R2.0](https://mobiledgex.com/product), a number of capabilities such as the management, operations and monitoring of application deployments and resources are available through an easy-to-use [Edge-Cloud Console](https://console.mobiledgex.net/site1?pg=0). As a Developer, you can use the console to manage your software deployment across all operator’s distributed edge infrastructure, further simplifying the deployment of enterprise resources and applications. Operators, on the other hand,  can use the [Edge-Cloud Console](https://console.mobiledgex.net/site1?pg=0) to monitor the usage of the Operator-owned Cloudlets. Both Developers and Operators can monitor and manage most of their operations through a single pane of glass.

For a comprehensive list of features and capabilities, refer to our recent announcement of [Edge-Cloud 2.0](https://mobiledgex.com/product). Documentation and Resources can be found on our [Developer Portal](/developer/index.md), where we continuously publish new documentation and resources to help you realize the potential of our solutions and offerings.

The table below lists specific features added to our [Edge-Cloud Console](https://console.mobiledgex.net/site1?pg=0).

## New Features on Edge-Cloud Console

<table>
<tbody>
<tr>
<th>
<b>Title</b>
</th>
<th align="center">
<b>Description</b>
</th>
</tr>
<tr>
<td>Alert Framework </td>
<td>Currently a beta feature, MobiledgeX’s Platform provides an <b>AlertManager</b> that serves as the global component responsible for distributing alerts to application owners and cloudlet operators. Alarms are consolidated at the regional level, where each regional controller receives alarms. Based on the user configuration, an alert receiver can be created, and depending on user preference; an alert notification is sent via email or Slack to the user for mitigation.</td>
</tr>
<tr>
<td>Alert Receivers</td>
<td>A new Alert Receivers sub-menu is added to simplify the creation of alert receivers. Users can set up alert receivers for application instances, clusters, and cloudlets.  

Additionally, AlertReceiver APIs have been added through the mcctl utility program to provide users flexibility to integrate with their existing monitoring systems.  

- <b>api/v1/auth/alertreceiver/create</b>
- <b>api/v1/auth/alertreceiver/delete</b>
- <b>api/v1/auth/alertreceiver/show</b>

</td>
<tr>
<td>Monitoring</td>
<td>A more simplified interface is implemented to help users continue to filter and display analytics and data for clusters, application instances, and cloudlets, where filtering can be done by <i>App Inst</i>, <i>Cluster Inst</i>, <i>Cloudlet</i>, and <i>Org</i>. <b>Audit</b>, <b>Event</b>, and <b>Usage</b> detailed logs can all be viewed through the Monitoring page by selecting a drop-down icon.

The details of all <b>Alerts</b> generated can also be viewed from this page.

- <b>Audit logs</b>: Log user activities such as logging, creating applications, deleting users, creating policies, etc.
- <b>Event logs</b>: These are system-generated events and can include services such as auto-provision policy, auto-scaling, application instance, or HA, where our platform will trigger events based on these user policies. 
- <b>Usage Logs</b>: These logs are generated to view the status (online or offline) of clusters, application instances status, or Cloudlets, and maintenance status. 

</td>
</tr>
<tr>
<td>App event log displayed for an app instance (Developer interface)</td>
<td>On the Monitoring page, we now display event logs for application instances deployed via the auto-provision policy for reservable cluster instances.</td>
</tr>
<tr>
<td>Auto-Provision Policy Undeploy (Developer interface)</td>
<td>We now provide the ability to undeploy application instances based on the threshold and value set for the <b>Undeploy Request Count</b> and <b>Undeploy Interval Count(s)</b>. </td>
</tr>
<tr>
<td>Cloudlet selection for HA (Operator interface)</td>
<td>

Previously for HA-based cloudlets, two cloudlets in the same location would only allow one cloudlet to be utilized while the other stayed idle. Now, with the implementation of randomized cloudlet selection, both cloudlets can be utilized.  
</td>
</tr>
<tr>
<td>Cloudlet Events (Operator interface)</td>
<td>Alerts and events are now generated for cloudlets that are down, in the process of upgrading, or are in maintenance mode. These events can be viewed through the Monitoring page. Operators can set up alert receivers to receive an alert notification when these alarms are triggered. </td>
</tr>
<tr>
<td>Bot Protection</td>
<td>With the implementation of <b>CAPTCHA</b>, users are now presented with a <b>CAPTCHA</b> checkbox during the registration process. If the system detects suspicious behavior, further validation will be required through an image recognition task. </td>
</tr>
<tr>
<td>Two-Factor Authentication (2FA)</td>
<td>Users can optionally set this up during account registration for an added layer of security, where an additional step of verification is required during sign-in.</td>
</tr>
<tr>
<td>Strong Passwords</td>
<td>Passwords now must meet all password requirements and guidelines to help thwart possible brute force attacks. In addition to the password requirements, password strength must also meet all scoring requirements provided by MobiledgeX through an entropy scoring system for passwords to be considered strong.</td>
</tr>
</tbody>
</table>  
## New Features on Edge-Cloud Console

<table>
<tbody>
<tr>
<th>
<b>Title</b>
</th>
<th align="center">
<b>Description</b>
</th>
</tr>
<tr>
<td>Login and registration mechanism</td>
<td>Login and Self-serve registration capabilities are provided on the [Edge-Cloud Console](https://console.mobiledgex.net/site1?pg=0) to allow appropriate resource access to all users.</td>
</tr>
<tr>
<td>RBAC support</td>
<td>Role-Based Access Control provides the ability to assign different roles to users per Organization.  

- As a Developer, your role may include Manager, Contributor, or Viewer.
- As an Operator, your role may include Manager, Contributor, or Viewer.

</td>
<tr>
<td>Developer interface</td>
<td>The [Edge-Cloud Console](https://console.mobiledgex.net/site1?pg=0) lets Developers debug issues related to their application instances in the Operator cloudlets, where they are deployed. </td>
</tr>
<tr>
<td>Operator interface</td>
<td>The [Edge-Cloud Console](https://console.mobiledgex.net/site1?pg=0) lets Operators monitor the usage of the Operator-owned Cloudlets.</td>
</tr>
<tr>
<td>Add/invite users to your Organization</td>
<td>If a Developer or Operator creates an Organization, they become the Administrator for that Organization. As an Administrator, the Developer or Operator can add other users to their Organization and assign user roles. </td>
</tr>
<tr>
<td>Auto-create VM repository for Developers during CreateDeveloper</td>
<td>

During the CreateDeveloper process, once the user’s identity is confirmed by email verification, a repository is automatically created under the MobiledgeX VM Registry.  

With SSO implemented, the same Edge-Cloud Console login credentials is used to access the VM registry.  </td>
</tr>
<tr>
<td>Auto-create Docker repository for Developers during CreateDeveloper</td>
<td>

During the CreateDeveloper process, once the user’s identify is confirmed by email verification, a repository is automatically created under the MobiledgeX Docker Registry.

With SSO implemented, the same Edge-Cloud Console login credentials is used to access the Docker registry. </td>
</tr>
<tr>
<td>Self-serviced tool tips</td>
<td>Tool tips can be found throughout the [Edge-Cloud Console](https://console.mobiledgex.net/site1?pg=0) wherever a question mark is available. Click on the question mark to access a brief helper text about an element or its function. </td>
</tr>
<tr>
<td>Regional controller</td>
<td>For scalability, privacy, and the operational ease of managing your Organization, all  cloudlets are part of a controller, and are organized by regions. As a developer, you can deploy your application instance to multiple cloudlets within the same Operator and region. As an Operator, you can deploy multiple cloudlets with the same region. Each region has its own controller along with its own database. Each database contains data, such as Cloudlets, Flavors, ClusterInstance, Apps, that exist within that region. The Master Controller directly communicates with each regional controller, and all requests made by the console passes through the Master Controller. The Master Controller will determine which regional controller to communicate with when you select an available Region from the pull-down list. </td>
</tr>
<tr>
<td>3 application deployment types supported</td>
<td>When creating Apps, you can choose to deploy your application using the 3 available deployment types:  

- <b>VM</b>: QCOW2 image
- <b>Docker</b>: docker-compose
- <b>Kubernetes</b>: k8s yaml, single helm chart
 </td>

</tr>
<tr>
<td>Ability to add security group during CreateAppInst</td>
<td>During the CreateAppInst process, Developers can configure security groups. </td>
</tr>  
<tr>
<td>Upgrade App and App Instances</td>
<td>Developers can update an application or application instance by specifying a revision field, which identifies the specific revision number. Furthermore, you can update application instances independently of the applications, maintaining a mix of current existing revisions. Simultaneously upgrading multiple instances of applications and application instances is also supported. However, developers are responsible for maintaining the history of their upgrades or revisions; MobiledgeX does not track or maintain older versions of application and application instances. </td>
</tr>
<tr>
<td>Dedicated security group per cluster</td>
<td>Dedicated clusters are assigned to each security group, and restricted traffic occurs for groups that are not part of the default group. You can also create multiple clusters at once. Furthermore, you can have a <b>dedicated</b> or <b>shared</b> Root-LB balancer. When you create a cluster, we automatically create a shared Root-LB balancer. If flagged as <b>shared</b>, Kubernetes cluster will use that shared Root-LB balancer. </td>
</tr>
<tr>
<td>Different Flavors supported</td>
<td>Multiple T-shirt size for VMs are available. </td>
</tr>
<tr>
<td>Logging actions</td>
<td>Logs are created each time you or someone within your Organization creates, deletes, or modifies settings/configurations for your Organization. </td>
</tr>
<tr>
<td>Able to deploy to multiple cloudlets</td>
<td>As a Developer, you can deploy your Cluster and Application Instances to multiple cloudlets within the same region and operator. </td>
</tr>
<tr>
<td>Metrics available for VM, Docker, and Kubernetes</td>
<td>We provide a single pane of glass to monitor all deployed applications. </td>
</tr>
<tr>
<td>Auto Provisioning Policy of Application Instance </td>
<td>Based on policy, such as user location, MobiledgeX can auto-deploy your application instance. </td>
</tr>
<tr>
<td>Auto Provision-Privacy Policy </td>
<td>Once you create a cluster, you can add a privacy policy to that cluster instance, and thus, making your cluster private. </td>
</tr>
<tr>
<td>Root-LB based Health checking for application instances</td>
<td>We’ve added a health check <b>AppInst.Health</b> that provides the current state of the AppInst., and marks it as either <b>Offline</b> or <b>Ready</b>. </td>
</tr>
<tr>
<td>Basic health monitoring scheme of developer AppInstances</td>
<td>Health Monitoring is available to monitor the health of applications through a single pane of glass.</td>
</tr>
<tr>
<td>Docker Log Exposure</td>
<td>Provides Application Developers access to docker logs. </td>
</tr>
<tr>
<td>Kubernetes Log Exposure </td>
<td>Provides Application Developers access to Kubernetes logs. </td>
</tr>
<tr>
<td>Security Policy on Outbound Connection to make deployment fully Private </td>
<td>As part of our Privacy Policy, and during the application creation process, the privacy settings are enabled. Upon deployment of the AppInstance, the security settings are auto-set such that any outbound connection is prohibited. This is only supported for  Dedicated IP access. </td>
</tr>
<tr>
<td>Shell access capabilities for Developers </td>
<td>From the [Edge-Cloud Console](https://console.mobiledgex.net/site1?pg=0), Developers have shell access to their containers for the purpose of debugging and testing.  You use the ‘Run’ command to go inside container and  ‘Show Log’ to view changes. </td>
</tr>
<tr>
<td>Terminal access capabilities for Developers </td>
<td>From the [Edge-Cloud Console](https://console.mobiledgex.net/site1?pg=0), Developers have shell access to their VMs for the purpose of debugging and testing.  Use the terminal commands from the AppInst Page. </td>
</tr>
<tr>
<td>DME Metrics </td>
<td>

A powerful monitoring tool is available and provides valuable metrics to assist you in making informed decisions about your application deployment and their locations.  You can view data such as the number of users associated with an application, or the number of users communicating to your backend instances. This valuable data can help you scale up your deployments based on user activity. The dashboard also provides several ways to filter your data or analytics, drilling even further down to examine your application's usage and performance.  

Snapshots of your application's analytics are represented visually by tiles that you control.
</td>
</tr>  
<tr>
<td>Audit logging supported </td>
<td>

We generate audit logs based on User ID. You can view your own historical activities from the [Edge-Cloud Console](https://console.mobiledgex.net/site1?pg=0).

You can also view logs and examine historical activities by users within your Organization. These logs can be used for diagnostic purposes or for error correction. </td>
</tr>
<tr>
<td>Integrate with GitHub Actions </td>
<td>

You can integrate [GitHub Actions](https://github.com/features/actions) into your own edge applications hosted on GitHub to auto-deploy your applications to our cloudlets. 

<b>Note</b>: The current version of [GitHub Actions](https://github.com/features/actions) only supports Docker and Kubernetes-based deployments. </td>
</tr>
<tr>
<td>Automatic Onboarding of Cloudlets </td>
<td>Operators can automatically onboard their Cloudlets.</td>
</tr>
<tr>
<td>Cloudlet Metrics </td>
<td>Operators can view their deployed Cloudlets through a single pane of glass. </td>
</tr>
<tr>
<td>Cloudlet Event Logs </td>
<td>Operators can view event logs for their deployed Cloudlets. </td>
</tr>
<tr>
<td>Cloudlet Pools </td>
<td>Operators can make their cloudlets private, and Organizations that are part of the cloudlet pool can only view those particular cloudlets. </td>
</tr>
<tr>
<td>GPU support </td>
<td>
[Nvidia T4](https://www.nvidia.com/en-us/data-center/tesla-t4/) GPUs are supported in pass-through mode for virtual machines, enabling the entire GPU to be exclusively dedicated to a virtual machine. </td>
</tr>
</tbody>
</table>  
## Known Issues

There are no known issues documented at this time.

