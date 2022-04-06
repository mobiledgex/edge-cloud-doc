---
title: VMpool Deployment Options
long_title:
overview_description:
description: Describes VMPool Deployment Options
---

### Deployment Option 1: Operator provides Virtualization stack end point to MobiledgeX

In this Deployment option, Operator provides MobiledgeX with Virtualization stack portal (eg: VMware vCloud Director vCD ,Red Hat Virtualization RHV etc). MobiledgeX will load VM base images on these platforms and spawn VM’s based on the agreed cloudlet resource quota with operators and create cloudlets based on the internet and wireless handset Network Specifications provided by the operator and manage them. MobiledgeX will provide required Firewall rules and Specifications to Operator to manage Firewall as well.

#### VMPool Deployment Checklist

##### Virtual Machine Minimum Requirements:

**Cloudlet Management**

- 1 VM for Cloudlet Resource Manager (CRM) - Mandatory
- 1 VM for shared root Load Balancer - Mandatory
- 1 VM for dedicated Load Balancer - Optional ( needed if app needs dedicated LB over shared root LB )

**Edge application workload** (per single app )

- 1 VM for docker based app instance.
- 2 VM’s for Kubernetes based app instance (incase of one master ,one node k8s cluster)

##### Networking Requirements

- External UE Wireless Network - Mandatory
- Internal L2 only isolated Network - Mandatory
- External Internet Network - Optional
- VM VPN Access Network - Optional

##### Virtual Machine Image Requirements:

- MobiledgeX will provide the Platform base image needed to spawn the VM’s on operator Infrastructure with supported File formats like qcow2,vmdk,ovf etc.

##### Virtual Machine Flavor Requirements:

**Cloudlet Management**

- vCPU : 2
- RAM Size (MB) : 4096
- DISK (GB) : 40

**Edge application workload**

- vCPU : 2,4,8 or 16
- RAM Size (MB) : 2048,4096,8192 or 16384
- DISK (GB) : 20,40,80 or 160
- GPU : 1 - Optional

### Deployment Option 2: Operator Pre-creates VM’s in Infrastructure and provide VM access to MobiledgeX

In this Deployment option, Operator manages Virtualization stack portal (eg: VMware vCloud Director vCD, Red Hat Virtualization RHV etc). MobiledgeX will provide needed VM base images to operators. Operator Infrastructure team spawn needed VM’s ,maintain VM cloud-init, VM network configuration and also maintain Firewall based on the rules and Specifications provided by MobiledgeX. MobiledgeX will create cloudlets based on the Network Specifications provided by the operator and manage them.

#### VMPool Deployment Checklist

Virtual Machine Minimum Requirements:

**Cloudlet Management**

- 1 VM for Cloudlet Resource Manager (CRM) - Mandatory
- 1 VM for shared root Load Balancer - Mandatory
- 1 VM for dedicated Load Balancer - Optional ( needed if app needs dedicated LB over shared root LB )

**Edge application workload** (per single app )

- 1 VM for docker based app instance.
- 2 VM’s for Kubernetes based app instance (incase of one master ,one node k8s cluster)

#### Networking Requirements

- External UE Wireless Network - Mandatory
- Internal L2 only isolated Network - Mandatory
- External Internet Network - Optional
- VM VPN Access Network - Optional

#### Virtual Machine Image Requirements:

- MobiledgeX will provide the Platform base image needed to spawn the VM’s on operator Infrastructure with supported File formats like qcow2,vmdk,ovf etc.

#### Virtual Machine Flavor Requirements:

**Cloudlet Management**

- vCPU : 2
- RAM Size (MB) : 4096
- DISK (GB) : 40

**Edge application workload**

- vCPU : 2,4,8 or 16
- RAM Size (MB) : 2048,4096,8192 or 16384
- DISK (GB) : 20,40,80 or 160
- GPU : 1 - Optional

