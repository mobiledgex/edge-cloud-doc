---
title: Auto Provisioning Policy
long_title: Automatic Deployments using the Auto Provisioning Policy
overview_description:
description:
Learn about how to use the MobiledgeX Auto Provisioning Policy to do automatic deployments to various cloudlets on the MobiledgeX platform

---

**Last Modified: 11/18/21**

## Automatic Deployments using the Auto Provisioning Policy

MobiledgeX provides several distinctive policies to manage your applications. Setting up these policies provides opportunities to allocate more compute resources, define trust settings, and more.

Policies are applied on a per regional basis, and the same policy may be mirrored across multiple regions. While many policy names may exist across different regions for applications associated with cloudlets within those regions, policy names are shared between the different policy types. Therefore, you cannot have the same name applied to auto-scale policy, auto provision policy, or trust policy.

### Terminology and settings

- **Deploy Request Count(DRC)**
<br>The number of FindCloudlet requests that trigger AppInst deployment on a Cloudlet with closer proximity.
- **Undeploy Request Count(URC)**
<br>Threshold active connections below which an AppInst will be removed (0 = Undeploy is disabled).
- **Deploy Interval Count(DIC)**
<br>The number of consecutive intervals (approx 5 mins per interval) over which the DRC must be met to trigger deployment.
- **Undeploy Interval Count(s)(UIC)**
<br>The number of consecutive intervals (approx 5 mins per interval) over which the URC must be met to trigger removal.
- **Min Active Instances(MIA)**
<br>The minimum number of instances to deploy at all times. This the HA setting.
- **Max Instances(MxI)**
<br>The maximum number of instances regardless of the number of requests. Must be greater or less than MIA.

The information below describes how Auto Provision Policy works for Application Instances.

## Auto Provisioning Policy: App Instances

The auto provision policy can be set to manage the deployment of application instances to different cloudlets providing better service and redundancy. When applying an auto-provision policy to an application, MobiledgeX immediately checks to ensure enough application instances exist to satisfy the Min Active Instances (MIA). If required, the new application instances are deployed to the cloudlets in the order in which the cloudlets are defined in the policy. See examples below.

**Example 1:**


- App has no AppInsts
- Policy is applied with 4 cloudlets and MIA =2
- AppInsts deployed to cloudlets 1 and 2


**Example 2:**


- App already has 1 AppInst deployed
- Policy applied with 4 cloudlets and MIA=2
- Existing AppInst is on cloudlet 3 in the policy list
- One new AppInst deployed to cloudlet 1


The following checks and actions are performed at each interval (approx. 5 minutes).

- If any cloudlet that does not already have an AppInst has had DRC requests for the last DIC intervals and MxI has not been reached, deploy an AppInst to the cloudlet.
- If the number of AppInsts is greater than the MIA and any AppInst has less active connections than URC for the last UIC intervals, remove the AppInst.
- If the number of AppInsts is greater than the MIA and there are no active connections to any cloudlets for the last UIC intervals, remove AppInsts by scanning the cloudlet list in reverse order, i.e., remove AppInsts from the last cloudlets in the list first.
- When an Auto Prov policy is removed from an App, any AppInstances deployed by the policy will be removed.

Auto provisioning will not deploy a new application instance on a cloudlet where an instance for the application already exists, regardless of whether that app was created manually or provisioned automatically. Once you create the auto provision policy, you can reference the policy when creating a new application from the Apps page. Multiple policies may be attached to the same application to provide different levels of automation across other groups of cloudlets.

You will receive an error if you attempt to delete an auto provision policy where an application is associated with that policy. To correctly delete an auto provision policy, you must first delete the application attached to the policy and then proceed to delete the policy.

**Note:** Currently, only Docker and Kubernetes deployments can be auto-provisioned at this time.

### To create an auto-provision policy:


- Select **Policies** from the left navigation, the select **Auto Provisioning Policy** from the dropdown menu.
- Select the plus sign icon in the top right of the Auto Provisioning Policy page.
- From the Create Auto Provisioning Policy screen, enter information for the required fields.
- Select the cloudlet(s) specific to the region you selected. Use the arrow to move your cloudlet selection to the box on the right.
- Now click **Create**. Your Auto-Provisioning Policy appears on the Policies page. The quick access menu under Actions let you add cloudlet, delete cloudlet, or delete the entire Auto-Provisioning Policy.
- Once your auto provision policy is created, apply the policy to your [applicaton definition](/developer/deployments/deployment-workflow/app-definition/index.md) under the **Advanced Settings**.


![Create Auto Provisioning Policy screen](/developer/assets/provision.png "Create Auto Provisioning Policy screen")

