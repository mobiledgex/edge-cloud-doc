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

| Title                                   | Description                                                                                                                                                                                                                                                      |
|-----------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Support for VCD Deployment (beta)       | MobiledgeX now supports vCD deployment v10.0-10.2 where the Operator provides a Tenant on their existing vCD to MobiledgeX. This approach allows the Operator to remain in control of the vCD and its associated external networking and switch configurations.  |
| PagerDuty Receiver Notifications        | We now support PagerDuty integration for Alert Manger notifications.                                                                                                                                                                                             |
| Invite Developers to join Cloudlet Pool | Invitations can now be sent to Developers to join Cloudlet Pools. Once Developers are part of the Cloudlet Pool, Operators can be alerted when quota limits are reached, cloudlets are down, and Developer metrics and logs can be viewed and assessed.          |



### Behavioral Changes on Edge-Cloud Console

| Title                           | Description                                                                                                                                                                                                                                                                                                                                                                                   |
|---------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Disabling Edgebox               | Members of your organization, by default, will not be able to immediately create cloudlets. The option **Edgebox** must be *disabled* by the MobiledgeX Admin to grant members the permission to create cloudlets. The goal of this feature is to ensure and preserve the integrity of the Operator’s enterprise infrastructure. Please contact your MobiledgeX Admin to disable **Edgebox**. |
| Direct Access                   | The ability to route traffic directly to your application instance is no longer available.                                                                                                                                                                                                                                                                                                    |
| Privacy Policy has been renamed | We have renamed **Privacy Policy** to **Trust Policy**. Currently, this feature is enabled when you create a cluster.  However, we’ve recently made a change where the feature is now applied during the creation of a cloudlet. This allows the policies to be defined by the Operator at the cloudlet level in order to enforce privacy on apps.                                            |

### Known issues

| Title                                                                                     | Description                                                                                                                                                                             |
|-------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Port restrictions for Docker and VM deployment types                                      | The current maximum allowed is as follow:- TCP ports= 1000- UDP ports- 10000                                                                                                            |
| Port restrictions for Kubernetes deployment type                                          | - TCP ports= 1000- UDP ports- 1000                                                                                                                                                      |
| MobiledgeX LB traffic packet size limitation                                              | Support for MobiledgeX Load Balancer UDP packet size is currently up to 1440 bytes. Larger packets are not supported at this time.                                                      |
| Audit logs                                                                                | The maximum allowed days you can search for audit logs is one day (within the last 24hrs).                                                                                              |
| Monitoring: Refresh rate is consistent                                                    | You may experience a delay in refresh rate (in seconds), often times between the graph and measurement data, when you attempt to refresh.**Workaround:** None                           |
| Trust Policy on vSphere                                                                   | Currently, this is not supported.**Workaround:**  None                                                                                                                                  |
| Trust Policy on VMPool                                                                    | Currently, this is not supported.**Workaround:**  None                                                                                                                                  |
| Restricted Cloudlets on VMPool                                                            | The onboarding of restricted Cloudlets on VMPool through the Edge-Cloud Console does not work.**Workaround:** Contact the MobiledgeX CloudOps team for assistance with this deployment. |
| vSphere restricted access fails to retrieve manifest                                      | Attempting to create a restricted access Cloudlet for vSphere fails when retrieving the manifest.**Workaround:** Contact the MobiledgeX CloudOps team to deploy manually.               |
| VCD support for Cloudlet deployment and Restricted on boarding                            | This is currently not supported through the Edge-Cloud Console.**Workaround:** Contact the MobiledgeX CloudOps team for assistance with this deployment.                                |
| Automatic Onboarding through the Edge-Cloud Console for VCD supported Cloudlet deployment | This is currently not supported.**Workaround:** Contact the MobiledgeX CloudOps team for assistance with deployment.                                                                    |
| Automatic Onboarding through the Edge-Cloud Console for VMPool                            | This is currently not supported.**Workaround:** Contact the MobiledgeX CloudOps team for assistance with deployment.                                                                    |
| GPU on vSphere                                                                            | Deploying applications using GPU as the Flavor type on vSphere Cloudlet is currently not supported.**Workaround:** None                                                                 |
| GPU on VCD                                                                                | Deploying applications using GPU as the Flavor type on VCD Cloudlet is currently not supported.**Workaround:** None                                                                     |
| GPU on VMPool                                                                             | Deploying applications using GPU as the  Flavor type on VMPool is currently not supported.**Workaround:** None                                                                          |
| VM deployment on VMPool                                                                   | Currently, VM deployment on VMPool is not supported.**Workaround:** None                                                                                                                |
| VM metrics on vCD                                                                         | Currently, viewing VM. metrics on vCD is not supported.Workaround: None                                                                                                                 |



