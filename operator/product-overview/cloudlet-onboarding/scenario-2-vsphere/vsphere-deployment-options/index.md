---
title: VSphere Deployment options
long_title:
overview_description:
description: Discusses VSphere deployment options
---

In this Deployment option, MobiledgeX software runs on VMware Esxi servers managed by operator VMware VCenter. MobiledgeX is provided with access to the operator VCenter APIs. MobiledgeX deploys cloudlet and manages the resources via operator Provided VCenter access.

#### vSphere Deployment Checklist

##### Minimum Resource Requirements:

- 32-64 vCPU - **Mandatory**
- 128-256 GB RAM - **Mandatory**
- 500GB-1TB HDD/Disk - **Mandatory**.**** It should be shared storage for DRS/HA

##### Preferred Resource Requirements:

- 200 vCPU or more in Total
- 500 GB RAM or more in Total
- 2TB HDD/Disk or more in Total. It should be shared storage for DRS/HA.
- PCI PassThrough GPU (eg: NVIDA T4) or vGPU enabled with corresponding licenses to use it.

##### VMware vSphere Requirements:

- vSphere version 6.7 or above
- Minimum 3 vSphere hosts.
- vCenter Server administrator access to vSphere hosts.

##### Networking Requirements:

- /28 External Public or External Wireless Network with a minimum of 8 ip’s.

**Networks**

- External UE Wireless Network - **Mandatory**
- External Internet Network - **Optional** needed only if UE Wireless Network can’t reach MobiledgeX Public end points.
- Internal L2 only isolated Network - Mandatory

##### Image Requirements

- Operator can download MobiledgeX Platform base image needed to create cloudlet directly during cloudlet on-boarding with MobiledgeX provided Artifactory credentials on supported file formats like qcow2, vmdk, etc.

#### Flavor Requirements:

**Cloudlet Management**

- vCPU: 8
- RAM Size (MB):
- DISK (GB):

**Edge application workload**

- vCPU: 2,4,8 or 16
- RAM Size (MB): 2048, 4096, 8192, or 16384
- DISK (GB): 20, 40, 80, or 160
- GPU: 1 - Optional

##### 


