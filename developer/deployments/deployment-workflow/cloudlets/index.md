---
title: Cloudlets
long_title:
overview_description:
description:
Service your applications through our cloudlets

---

**Last Modified:** 11/15/2021

**Note:** The Cloudlet page is read-only and cannot be modified.

MobiledgeX cloudlets are deployed as close to the wireless network edge as possible, enabling you to access the most optimal backend for servicing your applications. Several cloudlet components directly contribute to providing you with this level of access. The determining factors that dictate where you can deploy your applications include resource policies, preset locations, and the availability of cloudlets.

The Cloudlets page lets you view the available cloudlets where you can deploy your applications. For some cities, you may notice there are multiple cloudlets available. Different operators provide these cloudlets, and you have your choice of cloudlets to deploy your application instances.

The following actions may be performed on this page:

- Filter the available cloudlets by specific regions
- To filter by group, simply drag and drop the Region or Operator header into the **Drag header here to group** by option.
- Use the Search bar to search for specific cloudlet. Type in a few letters to auto-populate your search results
- Zoom in and out to increase or decrease the view of the map
- Hover your mouse over the highlighted [numbered] cloudlets on the map to view the name of the available cloudlet
- Select the actual highlighted cloudlet to drill down to the location. Click the icon available on the bottom left corner of the map to return to the original map view
- Toggle **Map:** to only view a list of cloudlets and hide the entire map
- Select the refresh button to refresh the list of available cloudlets

![](/developer/assets/cloudletspage.png "")

### Cloudlet Pools

Cloudlet Pools are collections of cloudlets that are defined on a per-regional basis. One of the advantages of becoming a member of a Cloudlet Pool is having the ability to deploy your applications to a private cloudlet. This, however, does not restrict you from deploying to other *public* cloudlets or deploying to other *private* cloudlets associated with other organizations you may be part of. Operators may set up a Pool membership where they will invite the DevManager of a specified organization to become a member of the Cloudlet Pool. If you are part of the organization that received an invite from the Operator to associate with a Cloudlet Pool, you can either accept or deny the invite via a query to become a member of that Pool. Once you become a member, you can view your Pool membership from the Cloudlet Pool page.

![](/developer/assets/cloudletpools.png "")

#### Permissions and roles

Refer to the table below to understand the permissions depending on your organizational role.
| Role           | Invite | Response | showgranted/pending | showinvite | showresponse |
|----------------|--------|----------|---------------------|------------|--------------|
| DevManager     | X      | X        | X                   | X          |
| DevContributor |
| DevViewer      |

### Example Request/Response query

```
mcctl --addr https://console.mobiledgex.net:443 --skipverify org create name=mydevorg  type=developer
Organization created
mcctl --addr https://consolemy.mobiledgex.net:443 --skipverify org create name=myoporg  type=operator
Organization created
mcctl --addr https://console.mobiledgex.net:443 --skipverify cloudletpool create region=US name=mypoolxxx org=myoporg
{}
mcctl --addr https://console.mobiledgex.net:443 --skipverify cloudletpoolinvitation create region=US cloudletpool=mypoolxxx cloudletpoolorg=myoporg org=mydevorg
Invitation created
mcctl --addr https://console.mobiledgex.net:443 --skipverify cloudletpoolresponse create region=US cloudletpool=mypoolxxx cloudletpoolorg=myoporg org=mydevorg decision=accept
Response created
mcctl --addr https://console.mobiledgex.net:443 --skipverify cloudletpoolresponse showgranted region=US cloudletpool=mypoolxxx cloudletpoolorg=myoporg org=mydevorg
- org: mydevorg
  region: US
  cloudletpool: Load Balancerpoolxxx
  cloudletpoolorg: myoporg

mcctl --addr https://console.mobiledgex.net:443 --skipverify cloudletpoolresponse delete region=US cloudletpool=mypoolxxx cloudletpoolorg=myoporg org=mydevorg
Response deleted
mcctl --addr https://console.mobiledgex.net:443 --skipverify cloudletpoolresponse showpending region=US cloudletpool=mypoolxxx cloudletpoolorg=myoporg org=mydevorg
- org: mydevorg
  region: US
  cloudletpool: mypoolxxx
  cloudletpoolorg: myoporg

```

