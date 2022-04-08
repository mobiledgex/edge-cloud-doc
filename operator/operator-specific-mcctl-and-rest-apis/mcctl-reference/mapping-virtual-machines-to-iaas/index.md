---
title: Mapping Virtual Machines to IaaS
long_title:
overview_description:
description: Learn how to map resources from the MobiledgeX platform to IaaS platforms using mcctl
---

## Mapping Virtual Machines to IaaS Resources

The MobiledgeX platform exposes unique node IDs for all deployed Cluster Instances (ClusterInsts) via the API. This allows for mapping resources within the MobiledgeX platform to resources in the underlying IaaS (VMware, OpenStack, Google Compute, AWS, Azure). This can be used by Operators to better manage and monitor the resources in use within their cloudlet.

This information is provided in a `vms` array under the `resources` array for cluster information. The following values are exposed:
<table>
<tbody>
<tr>
<th>Item</th>
<th>Meaning</th>
<th>Type</th>
<th>Example</th>
</tr>
<tr>
<td>name</td>
<td>vm name</td>
<td>string</td>
<td>mex-k8s-node-1-mexplat-stage-hamburg-cloudlet-test-mobiledgex”Unique, with actual format IaaS dependent</td>
</tr>
<tr>
<td>type</td>
<td>type of vm</td>
<td>string</td>
<td>loadbalancer, cluster-master, cluster-node</td>
</tr>
<tr>
<td>status</td>
<td>state of vm</td>
<td>string</td>
<td>ACTIVE, STOPPED</td>
</tr>
<tr>
<td>infraflavor</td>
<td>vm’s IaaS flavor</td>
<td>string</td>
<td>m4.small</td>
</tr>
<tr>
<td>ip_address</td>
<td>external and internal ip addresses</td>
<td>array</td>
<td>external IP: x.x.x.x</td>
</tr>
</tbody>
</table>

### Example with mcctl

The `mcctl` utility can be used to pull this information via the clusterinst show argument to the region subcommand:

```
  $ mcctl clusterinst show region=EU cluster=test01

- key:
   clusterkey:
     name: test01
   cloudletkey:
     organization: TDG
     name: mexplat-stage-hamburg-cloudlet
   organization: MobiledgeX
 flavor:
   name: x1.medium
 liveness: LivenessStatic
 state: Ready
 ipaccess: IpAccessDedicated
 allocatedip: dynamic
 nodeflavor: m4.large
 deployment: kubernetes
 nummasters: 1
 numnodes: 1
 masternodeflavor: m4.large
 resources:
   vms:
   - name: test01.mexplat-stage-hamburg-cloudlet.tdg.mobiledgex.net
     type: rootlb
     status: ACTIVE
     infraflavor: m4.medium
     ipaddresses:
     - externalip: 80.187.132.42
     - externalip: 10.101.44.1
   - name: mex-k8s-node-1-mexplat-stage-hamburg-cloudlet-test01-mobiledgex
     type: cluster-node
     status: ACTIVE
     infraflavor: m4.large
     ipaddresses:
     - externalip: 10.101.44.101
   - name: mex-k8s-master-mexplat-stage-hamburg-cloudlet-test01-mobiledgex
     type: cluster-master
     status: ACTIVE
     infraflavor: m4.large
     ipaddresses:
     - externalip: 10.101.44.10

```

#### Example with API

You can also work directly with the API by using the `/auth/ctrl/ShowClusterInst` route as illustrated below.

```
POST /auth/ctrl/ShowClusterInst

[
  {
    "key": {
      "clusterkey": {
        "name": "test01"
      },
      "cloudletkey": {
        "organization": "TDG",
        "name": "mexplat-stage-hamburg-cloudlet"
      },
      "organization": "MobiledgeX"
    },
    "flavor": {
      "name": "x1.medium"
    },
    "liveness": "LivenessStatic",
    "state": "Ready",
    "ipaccess": "IpAccessDedicated",
    "allocatedip": "dynamic",
    "nodeflavor": "m4.large",
    "deployment": "kubernetes",
    "nummasters": 1,
    "numnodes": 1,
    "masternodeflavor": "m4.large",
    "resources": {
      "vms": [
        {
          "name": "test01.mexplat-stage-hamburg-cloudlet.tdg.mobiledgex.net",
          "type": "rootlb",
          "status": "ACTIVE",
          "infraflavor": "m4.medium",
          "ipaddresses": [
            {
              "externalip": "80.187.132.42"
            },
            {
              "externalip": "10.101.44.1"
            }
          ]
        },
        {
          "name": "mex-k8s-node-1-mexplat-stage-hamburg-cloudlet-test01-mobiledgex",
          "type": "cluster-node",
          "status": "ACTIVE",
          "infraflavor": "m4.large",
          "ipaddresses": [
            {
              "externalip": "10.101.44.101"
            }
          ]
        },
        {
          "name": "mex-k8s-master-mexplat-stage-hamburg-cloudlet-test01-mobiledgex",
          "type": "cluster-master",
          "status": "ACTIVE",
          "infraflavor": "m4.large",
          "ipaddresses": [
            {
              "externalip": "10.101.44.10"
            }
          ]
        }
      ]
    }
  }

]
```

