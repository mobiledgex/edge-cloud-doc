---
title: Openstack Tenant Deployment
long_title:
overview_description:
description: Supported OpenStack Tenant Deployment
---

## OpenStack Tenant Deployment Where Operator Provides a Tenant on Their Existing OpenStack to MobiledgeX

In this model, the operator supplies an OpenStack Tenant account within their existing OpenStack Infrastructure (for eg: VMware VIO, Redhat RHOSP or Cisco VIM) to MobiledgeX with configured UE Wireless and External Internet Provider networks. With this model, the operator manages the OpenStack IaaS stack, flavors, and its associated external networking. MobiledgeX is provided access to the OpenStack endpoint, with granted permissions to create the VMs and networks in the assigned OpenStack tenant. Once the OpenStack tenant Networking design is finalized, either MobiledgeX or operator itself via MobiledgeX console onboards the cloudlets. MobiledgeX will maintain the cloudlets and support the rest of the Edge operations.

![](/operator/assets/cloudlet-deployment-operator/scenario2a-RA.png "")

## Scope and Constraints

MobiledgeX only controls resource management within the scope of the MobiledgeX platform; VIM Operators have control over resource management beyond the platform. However, all changes must be done in coordination with MobiledgeX.

## Operator Workflow

### Step 1: Validate OpenStack deployment

The OpenStack environment and permissions need to be configured to meet or exceed the minimum requirements provided below.
<table>
<tbody>
<tr>
<th>OpenStack Version</th>
<td colspan="1" rowspan="1">

- Queens or Higher

</td>
</tr>
<tr>
<th>OpenStack Services</th>
<td colspan="1" rowspan="1">

- Glance
- Glance Image Cache (if supported)
- Nova
- Heat
- Keystone
- Neutron
- Cinder
- Ceilometer

</td>
</tr>
<tr>
<th>OpenStack Required APIs</th>
<td colspan="1" rowspan="1">

- create stack (heat)
- server list, create, delete, set properties
- image list, save, create, delete
- network list, create, delete
- subnet list, create, delete
- router create, delete, add and delete ports
- flavor list, show, create
- security group rule list and create
- show limits

</td>
</tr>
<tr>
<th>OpenStack Endpoint</th>
<td>Available to MobiledgeX Controller VM</td>
</tr>
</tbody>
</table>

### Step 2: Validate network configuration

All virtual machines created as part of this deployment will require full access to the full complement of deployed virtual machines.

### Step 3: Provide deployment information

The following should be provided for each VM that has been deployed.

- Datacenter
- VM Name
- External IP
- Internal IP

### Step 4: Cloudlet deployment (MobiledgeX responsibility)

The MobiledgeX DevOps team will use the information above to deploy the cloudlet and confirm that it is communicating with all necessary services and working properly. During this process, MobiledgeX requests that the operator has a defined contact point in the event there are any issues with the deployed VMs, network, firewall, or any other issues.

### Step 5: Handover testing

Following the completion of the cloudlet deployment, the MobiledgeX DevOps team will run through the deployment test process to validate the configuration. Once this is complete, the customer will be able to deploy workloads to the cloudlet while the MobiledgeX support team monitors the deployment and management until both MobiledgeX and the operator agree that the cloudlet is working properly.

