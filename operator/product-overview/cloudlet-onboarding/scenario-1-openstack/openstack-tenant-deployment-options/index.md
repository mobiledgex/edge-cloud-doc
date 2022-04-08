---
title: OpenStack Tenant Deployment Options
long_title:
overview_description:
description: Discusses the various OpenStack Tenant Deployment options
---

## Deployment Option A: Operator Provides OpenStack End Point Credentials to MobiledgeX

In this Deployment option, MobiledgeX software is a tenant on an existing Operator OpenStack environment.  MobiledgeX is provided with a pool of compute resources and access to the OpenStack API endpoint. MobiledgeX create cloudlets and needed platform software components using these resources and endpoint access and manage the cloudlets henceforth. MobiledgeX will also manage required Firewall in OpenStack tenant level for open networks. The operator can optionally manage additional Firewall as well for restricted cases.

### OpenStack tenant deployment checklist

#### Minimum resource requirements

- 32-64 vCPU - **Mandatory**
- 128-256 GB RAM - **Mandatory**
- 500GB-1TB HDD/Disk - **Mandatory**

#### Preferred resource requirements

- 200 vCPU or more in Total
- 500 GB RAM or more in Total
- 2TB HDD/Disk or more in Total. It could be local or shared storage.
- PCI PassThrough GPU (eg: NVIDA T4) or vGPU enabled with corresponding flavors and licenses available to use it.

#### OpenStack preferred requirements

- OpenStack Version: **Queens** or Higher
- Tenant level access to OpenStack **Services** (Heat, Glance, Ceilometer, Neutron, Nova) &amp; OpenStack **APIs** to do basic VM instance, stack and network level operations.
- Tenant level access for flavor creation/deletion.
- No CPU and RAM overcommit ratio set on compute nodes
- Neutron ML2 port security enabled
- VM instance console access (VNC, SPICE, etc.)

#### Networking requirements

- /28 External Public or External Wireless Network with a minimum of 8 IPs.
- IaaS OpenStack API endpoint need to be reachable from OpenStack external/Provider networks.

#### Networks

- External UE Wireless Network - **Mandatory**
- External Internet Network - **Optional** needed only if UE Wireless Network can’t reach MobiledgeX Public end points.

#### Image requirements

- Operator can download MobiledgeX Platform base image needed to create cloudlet directly during cloudlet on-boarding with MobiledgeX provided Artifactory credentials on supported file formats like qcow2, vmdk, etc.
- Operator need to upload MobiledgeX Platform base image to OpenStack Glance first time. All subsequent base images will be loaded automatically after every MobiledgeX cloudlet up-grades.

#### Flavor requirements

**Cloudlet Management**

- vCPU: 2
- RAM Size (MB): 4096
- DISK (GB): 40

**Edge application workload**

- vCPU: 2,4,8 or 16
- RAM Size (MB): 2048,4096,8192 or 16384
- DISK (GB): 20,40,80 or 160
- GPU: 1 - Optional

## Deployment Option B: Operator Onboards MobiledgeX Cloudlet via MobiledgeX Console

In this Deployment option, MobiledgeX software will be a tenant on an existing Operator OpenStack environment Operator will access MobiledgeX console, furnish cloudlet general and geographic information along with OpenStack tenant access credentials and create the cloudlets based on the instructions provided in MobiledgeX console. MobiledgeX will manage the cloudlets automatically henceforth. MobiledgeX will also manage required Firewall in OpenStack level for open networks. Operator can optionally manage additional Firewall as well for restricted cases.

### OpenStack tenant deployment checklist

#### Minimum resource requirements

- 32-64 vCPU - **Mandatory**
- 128-256 GB RAM - **Mandatory**
- 500GB-1TB HDD/Disk - **Mandatory**

#### Preferred resource requirements

- 200 vCPU or more in Total
- 500 GB RAM or more in Total
- 2TB HDD/Disk or more in Total. It could be local or shared storage.
- PCI PassThrough GPU (eg: NVIDA T4) or vGPU enabled with corresponding flavors and licenses available to use it.

#### OpenStack preferred requirements

- OpenStack Version: **Queens** or Higher
- Tenant level access to OpenStack **Services** (Heat, Glance, Ceilometer, Neutron, Nova) and OpenStack **APIs** to do basic VM instance, stack and network level operations.
- Tenant level access for flavor creation/deletion.
- No CPU and RAM overcommit ratio set on compute nodes
- Neutron ML2 port security enabled
- VM instance console access (VNC, SPICE, etc.)

#### Networking requirements

- /28 External Public or External Wireless Network with a minimum of 8 IPs.
- IaaS OpenStack API endpoint need to be reachable from OpenStack external/Provider networks.

#### Networks

- External UE Wireless Network - **Mandatory**
- External Internet Network - **Optional** needed only if UE Wireless Network can’t reach MobiledgeX Public end points.

#### Image requirements

- Operator can download MobiledgeX Platform base image needed to create cloudlet directly during cloudlet on-boarding with MobiledgeX provided Artifactory credentials on supported file formats like qcow2, vmdk, etc.
- Operator needs to upload MobiledgeX Platform base image to OpenStack Glance first time. All subsequent base images will be loaded automatically after every MobiledgeX cloudlet upgrades.

#### Flavor requirements

**Cloudlet Management**

- vCPU : 2
- RAM Size (MB) : 4096
- DISK (GB) : 40

**Edge application workload**

- vCPU: 2,4,8 or 16
- RAM Size (MB): 2048,4096,8192 or 16384
- DISK (GB): 20,40,80 or 160
- GPU: 1 - Optional

