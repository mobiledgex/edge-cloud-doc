---
title: 3.0
long_title: Edge-Cloud Release Notes for 3.0
overview_description:
description: Edge-Cloud Release Notes for 3.0
---

The **Edge-Cloud 3.0** release offers many new features and enhancements. The following release notes cover details about these features and improvements and provide a list of known issues.

Documentation and resources can be found on our [Operator Portal](/operator/index.md), where we continuously publish new content and resources to help you realize the potential of our solutions and offers.

### New Features on Edge-Cloud

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
<td>Resource Management</td>
<td colspan="1" rowspan="1">

Operators will no longer need to rely on their hardware for resource availability. They can now use the Controller as a resource management tool where during the creation of cloudlets, resource quota limits can be specified. During cluster instance creation or VM-based app creation, resource validation occurs. The advantages of this include getting notified through our alerting system when resources are impacted and exceed the defined threshold, and allowing operators to respond quickly by modifying or increasing the resource limits and capacity. Additionally, new APIs are available to view resource capacities and the ability to display a snapshot of the resource infrastructure usage.

Learn more about Resource Management [here](/operator/product-overview/operator-guides/debugging/reports/index.md)
[.](https://ops-stage.mobiledgex.com/product-overview/operator-guides/debugging/reports) </td>
</tr>
<tr>
<td>Operator Reports and Scheduler</td>
<td colspan="1" rowspan="1">

Operators can generate a summary of usage reports detailing the status of their cloudlets. The information is provided in .pdf format. Reports can be scheduled based on intervals you define.

While operators can view cloudlet resource usage as part of the report, we currently do not display cloudlet resource usage information on a per-developer basis, even if the developers are part of a Cloudlet Pool.

Learn more about Report Scheduler [here](/operator/product-overview/operator-guides/debugging/reports#report-scheduler/index.md).</td>
</tr>
<tr>
<td>Invite Developers to join Cloudlet Pool</td>
<td colspan="1" rowspan="1">

Operators can now send invitations to developers to join Cloudlet Pools. Once Developers are part of the Cloudlet Pool, operators can be alerted when quota limits are reached, cloudlets are down, and developer metrics and logs can be viewed and accessed.

Learn more about inviting developers to join Cloudlet Pools [here](/operator/product-overview/operator-guides/cloudlet-deployment-guides/cloudlet-pools#to-create-a-cloudlet-pool/index.md).</td>
</tr>
<tr>
<td>Monitoring Developer Metrics and Usage Information</td>
<td colspan="1" rowspan="1">

Operators can retrieve developer usage information if the developer organization is part of the cloudlet pool. Information may include usage, logs, and the number of devices connected.

Learn more about Monitoring Developers Metrics and Usage [here](/operator/product-overview/operator-guides/debugging/operator-monitoring-and-metrics#viewing-developer-metrics/index.md).</td>
</tr>
<tr>
<td>Trust Policy</td>
<td colspan="1" rowspan="1">

Operators can turn their public cloudlets into private edge cloudlets. Furthermore, operators can segment their edge infrastructure and apply an additional security level with Trust Policies. These policies define security group rules that permit outbound traffic with specific outbound traffic rules.

Learn more about Trust Policy [here](/operator/product-overview/operator-guides/cloudlet-deployment-guides/deploying-cloudlets#what-is-trust-policy/index.md).</td>
</tr>
<tr>
<td>Multiple Cloudlets per VDC</td>
<td>Operators can now run multiple cloudlets per VDC.</td>
</tr>
<tr>
<td>Restricted Cloudlet on VM Pool</td>
<td>Previously, our support for restricted cloudlets was only available on OpenStack. Now, we have added support for restricted cloudlet on VM Pool.</td>
</tr>
<tr>
<td>Trust Policy on VCD</td>
<td>Previously, we only supported Trust Policy on OpenStack. Now, we support Trust Policy on VCD.</td>
</tr>
<tr>
<td>Support for GPU on VCD</td>
<td>This feature is partially supported and requires manual GPU mapping with the VM in the vSphere configuration.</td>
</tr>
<tr>
<td>Support for vGPU</td>
<td>vGPU is now supported.</td>
</tr>
<tr>
<td>Support for Cloudlet Event Streaming through Kafka</td>
<td colspan="1" rowspan="1">

You can now set up Kafka on a cloudlet to view and filter real-time events by either operator or developer. All events about the cloudlet can be pushed to the Kafka cluster.

However, developer audit events for Kafka are not supported in this release.

Learn more about Kafka [here](/operator/product-overview/operator-guides/debugging/reports#using-kafka-to-push-cloudlet-events/index.md).</td>
</tr>
<tr>
<td>Helm Chart support</td>
<td>We now support Helm Chart v3.</td>
</tr>
<tr>
<td>Health Checks on VM</td>
<td>We now support application-level health checks on VMs so that when a VM is stopped, a **Healthcheck Fail Server** alert is sent.</td>
</tr>
<tr>
<td>Supported Alerts</td>
<td colspan="1" rowspan="1">

Operators can now receive alerts when cloudlets are down or when resource limitations have exceeded. Alerts can also be created for application instances that exceed resource levels.

Learn more about the Supported alerts [here](/operator/product-overview/operator-guides/debugging/health-check-and-alert#supported-alerts-/index.md).</td>
</tr>
<tr>
<td>Alert Severity</td>
<td colspan="1" rowspan="1">

You can now classify alerts based on severity levels.  The severity levels include **info**, **warning**, and **error**.

Learn more about the Alert Severity [here](/operator/product-overview/operator-guides/debugging/health-check-and-alert#severity-levels\/index.md)
[.](https://ops-stage.mobiledgex.com/product-overview/operator-guides/debugging/health-check-and-alert#severity-levels\)
</td>
</tr>
<tr>
<td>New Cloudlet Usage Alerts</td>
<td colspan="1" rowspan="1">

Operators can now generate alerts for cloudlet and cloudlet usage exceeding resource limitations.

Resource limitations may include the following:

·      App instance CPU exceeding defined levels

·      App instance MEMORY exceeding defined levels

·      RESTART of app instances

Learn more about Cloudlet Alerts [here](https://ops-stage.mobiledgex.com/product-overview/operator-guides/debugging/reports).</td>
</tr>
<tr>
<td>New metrics available for client cloudlet usage</td>
<td colspan="1" rowspan="1">

We now support collecting and retrieving client cloudlets using metrics through `mcctl` and the console latency map.

Learn more about Client Cloudlet Usage [here](/operator/operator-specific-mcctl-and-rest-apis/mcctl-reference#client-cloudlet-usage-metrics/index.md).</td>
</tr>
<tr>
<td>New metrics for client app usage</td>
<td colspan="1" rowspan="1">

We now support displaying client application usage metrics through `mcctl` and the console latency map.

Learn more about Client App Usage metrics [here](/operator/operator-specific-mcctl-and-rest-apis/mcctl-reference#client-app-usage-metrics/index.md).</td>
</tr>
<tr>
<td>MC API for app instance and cluster instance</td>
<td colspan="1" rowspan="1">

We added support to display application instance, cluster instance, and cloudlet pools usage if developers are part of the operator’s Cloudlet Pool through our APIs.

Learn how to view Developer app/clusters instances [here](/operator/operator-specific-mcctl-and-rest-apis/mcctl-reference#cluster-usage/index.md).</td>
</tr>
<tr>
<td>Client Cloudlet metrics</td>
<td colspan="1" rowspan="1">

`mcctl` command is available to show client cloudlet usage.

Learn more about Client App Usage Metrics [here](/operator/operator-specific-mcctl-and-rest-apis/mcctl-reference#client-cloudlet-usage-metrics/index.md).</td>
</tr>
<tr>
<td>Automatic onboarding for VM Pool</td>
<td>We now support automated onboarding for VM Pool.</td>
</tr>
<tr>
<td>Windows VM on VCD</td>
<td>We now support Windows VM on VCD. For deployment of Windows VMs on VCD, there is a new App field **vmostype** which must be populated with the appropriate Windows version.</td>
</tr>
<tr>
<td>Health Check and IAAS Cloudlets</td>
<td>Health Check will now fail if the IaaS cloudlets go down</td>
</tr>
</tbody>
</table>

###  Behavior changes and enhancements

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
<td>Events Manager: monitoring events, usage, metrics enhancements</td>
<td colspan="1" rowspan="1">

We have made significant enhancements to the monitoring components. In addition to collecting events and audit events for applications, clusters, and cloudlets, retrieving this data is now performed using the combined events and audits commands. Our search capabilities have been expanded with additional filter and tag options to further refine your search, and you can go from a Live view and switch views to perform a more specific search. Usage logs, which let you view application instances across client devices, locations, etc., help you understand the application activity occurring within your cloudlets. You can also view usage logs for cluster instances and cloudlet pools.

Last, viewing metrics information has been expanded to include cloudlets, clusters, and application instances. Metrics information may include vCPU infrastructure usage, disk infrastructure usage, and memory usage, all viewable through a UI graphical interface.

Learn more about Events Manager [here](/operator/product-overview/operator-guides/debugging/operator-monitoring-and-metrics/index.md).</td>
</tr>
<tr>
<td>Disabling EdgeBox</td>
<td colspan="1" rowspan="1">

As an OperatorManager, you can enable members of your organization to onboard cloudlets, run and deploy edge applications, and test locally without impacting existing network infrastructure. When you create an operator organization, the organization is operating in a default restricted mode: `edge-box only`, which does not allow members within your organization to deploy cloudlets. To change this default mode, contact MobiledgeX Support to lift the restriction. Once the restriction is lifted, members of your organization can start deploying cloudlets.

Learn more about EdgeBox [here](/operator/product-overview/cloudlet-onboarding/edgebox-proof-of-concept-testing/index.md).</td>
</tr>
<tr>
<td>Flavor selection for cluster and app instances</td>
<td>Previously, you can select a cloudlet and flavor based on regions when you create a cluster or application instance. In this release, we have made changes so that only the flavors that support those cloudlets appear as options when a cloudlet or a list of cloudlets are selected. Further, only cloudlets that support the flavor are available in the selection list when a flavor is selected.</td>
</tr>
<tr>
<td>Delete Alert Receivers</td>
<td>Previously when a user was deleted, the alert receiver associated with the user’s name could not be deleted. Now, as an OrgAdmin, you can delete alert receivers after the user has been deleted.</td>
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
<td>

**Description**
</td>
</tr>
<tr>
<td>Adding additional worker nodes fails on VCD</td>
<td>Increasing the number of worker nodes to an existing cluster fails on VCD, resulting in the VM remaining in a power-off state. To work around this issue, set the number of worker nodes back to the original number of nodes initially configured and manually power up the VM from the Cloud Director</td>
</tr>
<tr>
<td>VM application statistics</td>
<td>Currently, VM application statistics work with VCD, with the exception of **Disk usage**, **Network sent**, and **Network received**.</td>
</tr>
<tr>
<td>Support for GPU on VCD</td>
<td>This feature is partially supported and requires manual GPU mapping with the VM in the vSphere configuration.</td>
</tr>
<tr>
<td>Health check status for UDP</td>
<td>Currently, we don’t provide health checks on UDP ports.</td>
</tr>
<tr>
<td>Incorrect login attempts</td>
<td>Currently, we do not lock out users if multiple login attempts fail. However, there is a one-second penalty delay when users input an invalid username or password, making it difficult for bots to compromise user credentials.</td>
</tr>
<tr>
<td>Support for VM deployment on VM Pool</td>
<td>Currently, we do not support VM deployment on VM Pool.</td>
</tr>
<tr>
<td>Mapping GPU count for flavors with vGPU</td>
<td>While we show vGPU mapping, we do not display the details of the GPU/vGPU hardware model, slicing, FPS, etc. Therefore, you cannot select a flavor based on those details.  </td>
</tr>
<tr>
<td>Health checks may not work with some applications</td>
<td>Our health check makes TCP connections to exposed ports and closes them right away. If this is unexpected from the application side, health-check should be turned off for those application ports.</td>
</tr>
<tr>
<td>Adding a public cloudlet to a private cloudlet pool</td>
<td>Currently, we do not allow operators to include a public cloudlet as part of a member of a private cloudlet pool if there are existing cluster instances or application instances deployed on the public cloudlet.</td>
</tr>
<tr>
<td>Unable to detect flavors on OpenStack</td>
<td>Currently, deleted flavors on OpenStack are undetected and therefore, will not show as deprecated when cached. As a result, the cloudlet info will not reflect the deleted flavor within the flavor list.</td>
</tr>
<tr>
<td>Refresh action is not visible for the deployment type VM</td>
<td>Currently, the refresh action is hidden for the deployment type windows VM for OpenStack or VCD.</td>
</tr>
</tbody>
</table>

