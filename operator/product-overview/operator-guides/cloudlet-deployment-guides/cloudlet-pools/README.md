---
title: Cloudlet Pools
long_title:
overview_description:
description: Learn how to setup pool membership to restrict users from accessing cloudlets that are defined for a particular Cloudlet pool
---

MobiledgeX’s Edge Cloud Platform provides a flexible architecture that offers telecommunication companies the opportunity to transform public edge cloudlets into private edge cloudlets. Private edge cloudlets allow enterprise customers private hosting by providing them with cloud resources dedicated for their use only.

Turning the onboarded cloudlet into a Private Edge Cloudlet is easy with MobiledgeX’s *Cloudlet Pool *feature. Mobile Network Operators may now segment their edge infrastructure into private (enterprise) cloudlets from public cloudlets by setting up a *Cloudlet Pool* with a *Trust Policy* for their end customers looking to migrate their low-latency mission-critical workloads. *Cloudlet Pools* with *Trust Policies* provide a more stringent security level within the designated environments while providing greater control over data governance and data locality.

Cloudlet Pools are collections of cloudlets that are defined on a per-regional basis. As an operator, you may set up a pool membership where only users within the organization associated with the Cloudlet Pool can access the cloudlets defined for that particular pool. Setting up a Cloudlet Pool is useful in cases where you need to segment your private (enterprise) cloudlets from your public cloudlets. Cloudlet Pools may also be used to isolate cloudlets in the production phase of development and, therefore, will only be available for internal use. Here are some general guidelines to keep in mind when creating Cloudlet Pools.

- Operators must *own* the cloudlets they wish to add members to by [creating the Cloudlet Pool](/operator/product-overview/operator-guides/cloudlet-deployment-guides/cloudlet-pools#to-create-a-cloudlet-pool).
- If a cloudlet is not part of a pool, it’s considered a public cloudlet.
- Cloudlets assigned to one or more pools are considered private cloudlets.
- A Cloudlet Pool may be associated with one or more organizations, allowing users within that organization to access and use those cloudlets to deploy their applications.
- Auto-clusters are reserved only for private cloudlets, or members of the cloudletpool. Operators will not be able to see clusters or app instances on public cloudlets.Organizations not associated with a Cloudlet Pool will not see or have access to those cloudlets.
- Targeted organizations associated with Cloudlet Pools may still deploy their applications to other public cloudlets, or to other private cloudlets from other organizations or pools.

- Operators can view developers’ logs and events from the [monitoring](/operator/product-overview/operator-guides/debugging/operator-monitoring-and-metrics) dashboard if they are part of the Cloudlet Pool.

Finally, to offer managed edge services to end customers, the platform must provide access to the Operator, allowing the collection of metrics used to detect performance anomalies and institute measures that increase their customer’s workloads’ operational efficiencies. A list of insights provided by the platform can be found at[ https://developers.mobiledgex.com/design/testing-and-debugging](/operator/developer/design/testing-and-debugging).

## To Create a Cloudlet Pool

**Step 1:** In the MobiledgeX Edge-Cloud Console, go to the left navigation and select **Cloudlet Pools**, then click the **+** sign on the top right-hand corner of the screen. The Create Cloudlet Pool menu opens

![Create Cloudlet Pool screen](/operator/assets/operator-ui-guide/create-cloudlet-pool.png "Create Cloudlet Pool screen")

**Step 2:** In the **Region** box, select either **US** or **EU** from the dropdown menu. Once specified, the **Cloudlets** selection box auto-populates with all available cloudlets for that region.

**Step 3:** Type in a name for the **Pool Name**.

The **Operator ** field is required and will auto-populate with the name of the organization you are currently managing.

**Step 4:** From the *Cloudlet* selection box, highlight the cloudlet(s) and select the single arrow to add individual cloudlets and associate them to the Cloudlet Pool, or you can select the double arrows to select all available cloudlets at once to add them to the pool.

**Step 5:** Select **Create**. The **Step 2 Invite Organizations** screen opens. <br>
**Note:** If you wish to invite organizations to your Cloudlet Pool at a later time, click **Cancel**. You will be brought back to the Cloudlets Pools screen. Otherwise, proceed to **Step 6**.

**Step 6:*** Region*, *Pool Name*, and *Operator* fields will all auto-populate with the information specified during **Step 1 Create Pool**.

**Step 7:** From the **Organization** selection box, type in the name of the Organization you wish to invite to include as part of the Cloudlet Pool.

**Step 8:** Select **Create Invitation**. As an OperatorManager or OperatorContributor, you’re sending an invite as a query to the DeveloperManager of the organization you wish to invite to become a member of your Cloudlet Pool. They will then create a query response to either accept or reject the invite.

![Invite Organization to Cloudlet Pool](/operator/assets/cloudlet-pool-invite-org.png "Invite Organization to Cloudlet Pool")

If you wish to invite additional organizations or remove organizations as members of your Cloudlet Pool(s), you can do so from the Cloudlet Pools page using the Actions menu, as shown below.

![Cloudlet Pools: Actions menu options](/operator/assets/cloudlet-pool-actions-menu.png "Cloudlet Pools: Actions menu options")

Once Developers are part of your Cloudlet Pool, you may view Developer metrics. For more information, refer to the [Monitoring and Metrics Guide](/operator/product-overview/operator-guides/debugging/operator-monitoring-and-metrics).

### Permissions and roles

The following table outlines the permissions and roles associated with sending and viewing Cloudlet Pool invitations.
<table>
<tbody>
<tr>
<td>

**Roles**
</td>
<td>

**Invite**
</td>
<td>

**Response**
</td>
<td>

**ShowGranted/Pending**
</td>
<td>

**ShowInvite**
</td>
<td>

**ShowResponse**
</td>
</tr>
<tr>
<td>OperatorManager</td>
<td>X</td>
<td></td>
<td>X</td>
<td>X</td>
<td>X</td>
</tr>
<tr>
<td>OperatorContributor</td>
<td>X</td>
<td></td>
<td>X</td>
<td>X</td>
<td>X</td>
</tr>
<tr>
<td>OperatorViewer</td>
<td></td>
<td></td>
<td>X</td>
<td>X</td>
<td>X</td>
</tr>
</tbody>
</table>

### Example Request/Response Query

```
mcctl --addr https://console.mobiledgex.net org create name=mydevorg  type=developer
Organization created
mcctl --addr https://console.mobiledgex.net org create name=myoporg  type=operator
Organization created
mcctl --addr https://console.mobiledgex.net cloudletpool create region=US name=mypoolxxx org=myoporg
{}
mcctl --addr https://console.mobiledgex.net cloudletpoolinvitation create region=US cloudletpool=mypoolxxx cloudletpoolorg=myoporg org=mydevorg
Invitation created
mcctl --addr https://console.mobiledgex.net cloudletpoolresponse create region=US cloudletpool=mypoolxxx cloudletpoolorg=myoporg org=mydevorg decision=accept
Response created
mcctl --addr https://console.mobiledgex.net cloudletpoolresponse showgranted region=US cloudletpool=mypoolxxx cloudletpoolorg=myoporg org=mydevorg
- org: mydevorg
  region: US
  cloudletpool: mypoolxxx
  cloudletpoolorg: myoporg

mcctl --addr https://console.mobiledgex.net cloudletpoolresponse delete region=US cloudletpool=mypoolxxx cloudletpoolorg=myoporg org=mydevorg
Response deleted
mcctl --addr https://console.mobiledgex.net cloudletpoolresponse showpending region=US cloudletpool=mypoolxxx cloudletpoolorg=myoporg org=mydevorg
- org: mydevorg
  region: US
  cloudletpool: mypoolxxx
  cloudletpoolorg: myoporg

```

