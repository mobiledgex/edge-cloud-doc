---
title: MobiledgeX Assisted Deployment for Bare Metal Openstack
long_title:
overview_description:
description: MobiledgeX assisted deployment
---

## MobiledgeX Assisted OpenStack Deployment Where Operator Provides Bare Metal Servers to MobiledgeX

In MobiledgeX assisted OpenStack Deployment model, the operator provides a bunch of bare metal servers to MobiledgeX directly, or to a MobiledgeX approved IaaS provider. The intended server must be configured with L2 &amp; L3 network connectivity (in switches and router) for wireless and internet network traffic.

MobiledgeX, or the MobiledgeX IaaS provider, installs the most optimal operating systems on these bare metal servers, constructs the IaaS OpenStack, and builds the cloudlet on this Stack. MobiledgeX will also guide the Networking design, manage the network configurations on the bare metal side, and support Firewall in IaaS Stack for open networks, or provide recommended ingress and egress firewall specifications for restricted traffic scenarios. The operator manages switches and routers, and oversees the network’s main firewall, while MobiledgeX maintains the cloudlets and supports the rest of the Edge operations.

![](/operator/assets/cloudlet-deployment-operator/scenario1b-RA.png "")

