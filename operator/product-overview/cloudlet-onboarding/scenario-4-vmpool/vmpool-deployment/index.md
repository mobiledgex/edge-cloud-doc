---
title: VMPool Deployment
long_title:
overview_description:
description: Supported VMPool deployment
---

## VMPool Deployment Where Operator Provides VMs to MobiledgeX

In the VMPool deployment model, cloudlet and app work loads are deployed to the operator-provided virtual machines (VMs). This model allows operators to manage VM resource management platform, manage VM creations along with VM associated Networking, Firewall &amp; NAT operations. MobiledgeX supplies the base image to spawns these VMs, own cloudlet Network design, delivers recommended firewall specifications to operators and constructs the cloudlets. MobiledgeX also maintains the cloudlets and supports the rest of the Edge operations.

VMPool deployment supports only cloud-native containerized workloads like Docker and Kubernetes deployments. Virtual Machine Provisioning deployment is not supported.

![](/operator/assets/cloudlet-deployment-operator/scenario1a-RA.png "")

