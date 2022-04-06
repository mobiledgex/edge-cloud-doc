---
title: MobiledgeX Assisted OpenStack Deployment Options
long_title:
overview_description:
description: Discusses MobiledgeX assisted Openstack options
---

## Deployment Scenario 1:</strong> <strong>Operator Provides Bare Metal Server IPMI Access to MobiledgeX

In this Deployment option, operator provides bare metal Server Management IPMI access to MobiledgeX. MobiledgeX installs operating system, OpenStack (IaaS) and configure server side networking based on the specifications provided by the operator. MobiledgeX then deploys and manages the cloudlet.

## Deployment Scenario 2:</strong> <strong>Operator Installs MobiledgeX Recommended Operating System in Bare Metal Servers and Provide SSH Access to MobiledgeX

In this Deployment option, operator setup bare metal servers with MobiledgeX recommended operating system and server side networking. MobiledgeX will then be provided with SSH access to the server. MobiledgeX installs Openstack (IaaS) and deploy cloudlets based on the network specifications provided by the operator.

## MobiledgeX Assisted OpenStack Deployment Checklist

### Bare metal server minimum requirements

- 1 Baremetal Server - **Mandatory**
- 32-64 vCPU - **Mandatory**
- 128-256 GB RAM - **Mandatory**
- 500GB-1TB HDD/Disk - **Mandatory**
- One 10 GB Ethernet Network Interface card - **Mandatory**
- Out of band management interface/IPMI console - **Mandatory** only for Deployment Option 1

### Bare metal server preferred requirements

- 2 Bare-metal Servers or More
- 200 vCPU or more in Total
- 500 GB RAM or more in Total
- 2TB HDD/Disk or more in Total
- one 10 GB Network Interface card for Cloud Data Network and one 1GB or 10 GB Network Interface card for Cloud Management Network on each server
- PCI PassThrough GPU (eg: NVIDA T4) card or vGPU license for each server
- Out of band management interface/IPMI console

### Bare metal networking requirements

- /28 External Public &amp; Wireless Network with a minimum of 8 ip’s.
- LACP Bonding in Network Switches.
- Bare Metal Server SSH access for MobiledgeX [ only for Deployment Option 2]

**Networks**

- External UE Wireless Network - **Mandatory**
- Internal L2 only isolated Network - **Optional** needed only if IaaS Openstack API endpoints need to be isolated and should not be on an External Accessible Wireless or Internet Network.
- External Internet Network - **Optional** needed only if UE Wireless Network can’t reach MobiledgeX Public end points.
- Bare metal Out of band management IPMI Network - **Optional**

### Bare metal OS requirements

- CentOS 7
- RHEL 7
- Ubuntu 16.04 or above

### Firewall requirements

- For both Open Networks &amp; Operator Fire-walled networks, MobiledgeX manages separate IaaS stack firewalls for the Cloudlet and mobile Applications.

#### Egress

- Open egress access to Internet to reach MobiledgeX Public Endpoints.

#### Ingress

- Operator handset devices should have have ingress access for all app TCP ports opened on the mobile network side towards cloudlet. i.e All firewall ports open from mobile network towards Cloudlet.

