---
title: Operator Cloudlet Maintenance
long_title:
overview_description:
description: This page describes best practices to take cloudlet to maintenance state for maintenance activities by an operator.
---

Operators can enable Maintenance Mode for their cloudlets via the [MobiledgeX Console](https://console.mobiledgex.net/#/) to handle multiple operator scenarios such as data centers, power maintenance, and underlying IaaS platform or hardware upgrade activities.

The cloudlet maintenance option enables planned downtimes of cloudlets or any of the underlying components like IaaS, servers, switches or network configurations easily without affecting developer app deployments since no new app creations or operations are permitted during the maintenance window.

Please note that cloudlets should be in the maintenance state before the actual start of the operator maintenance window since this state change involve message exchanges between MobiledgeX Centralized Controller, MobiledgeX auto provisioning service and the cloudlet manager. Furthermore, Cloudlet Maintenance state can only be updated by users with either the **MobiledgeXAdmin** or **operator** role.

## To Enable Maintenance Mode for Cloudlet:

**Step 1:** From the [Edge-Cloud Console](https://console.mobiledgex.net/#/), select **Cloudlets** on the left navigation.

**Step 2:** Click on **Actions** tab of the Operator Cloudlet you plan to set the maintenance state and select the **Update** cloudlet option.

![](/operator/assets/updatecloudlet.png "")

**Step 3:** Under **Advanced Settings** section of Update Cloudlet, select the **Maintenance Start** option for the **Maintenance State** field (**No failover** option can be selected if Cloudlet AutoProvisioning failover to a different cloudlet of the same Operator is not planned for redundancy).

![](/operator/assets/operational-readiness/2.png "")

**Step 4:** Select the **Update** tab which will automatically put Cloudlet in maintenance state.

![](/operator/assets/operational-readiness/3.png "")

![](/operator/assets/maintenance.png "")

## To Restore Normal Operation of Cloudlet from Maintenance Mode:

**Step 1:** From the [Edge-Cloud Console](https://console.mobiledgex.net/#/), select **Cloudlets** on the left navigation.

**Step 2:** Select the **Actions** tab of the Operator Cloudlet which is already in the maintenance state and select the **Update** Cloudlet option.

![](/operator/assets/actionsupdate.png "")

**Step 3:** In **Advanced Settings** section of **Update Cloudlet,** select the **Normal Operation** option for **Maintenance State** field.

![](/operator/assets/operational-readiness/5.png "")

**Step 4:** Select the **Update** tab which will automatically put the Cloudlet back to normal operation and will be available online from the maintenance state.

![](/operator/assets/operational-readiness/6.png "")

![](/operator/assets/updatedcloudlet-1635786864.png "")

