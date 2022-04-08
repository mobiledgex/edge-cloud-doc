---
title: VMware vCloud Director (VCD) Deployment
long_title:
overview_description:
description: Requirements for VMware Deployment
---

In the VCD Deployment model, the operator provides an account to MobiledgeX in their existing VCD with the suitably configured UE Wireless and external internet networks. The operator remains in management of the Provider Virtual Datacenter (Provider VDC), and its associated shared storage, external networking and switch configurations.

MobiledgeX is provided access to an Organizational Virtual Datacenter (Org VDC).  Full privileges within this organizational VDC are granted to create the required clusters, virtual machines, and Organizational networks in the MobiledgeX assigned account. MobiledgeX designs the Org VDC Networking design and on-boards the cloudlets. Mobiledgex also maintains the cloudlets and supports Edge operations.

## VCD Deployment Requirements Checklist

<table>
<tbody>
<tr>
<td>

**VMware version**
</td>
<td>

**Networking**
</td>
<td>

**Resources Pool Minimum for Trial**
</td>
<td>

**Preferred Resources**
</td>
<td>

**Storage**
</td>
<td colspan="1" rowspan="1">

**Org VDC Tenant Permissions**
</td>
</tr>
<tr>
<td>vCloud Director 10.0</td>
<td>NSX-V plus distributed vSwitches</td>
<td>32-64 vCPU</td>
<td>200 vCPU</td>
<td>

Single shared  datastore for compute cluster

</td>
<td>Organization Administrator role required. Vapp leases should be set to ’never expire’</td>
</tr>
<tr>
<td>vCloud Director 10.1</td>
<td>NSX-T plus distributed vSwitches</td>
<td>32-64 vCPU</td>
<td>200 vCPU</td>
<td>

Single shared  datastore for compute cluster

</td>
<td>Organization Administrator role required. Vapp leases should be set to ’never expire’</td>
</tr>
<tr>
<td>vCloud Director 10.2</td>
<td>NSX-T plus distributed vSwitches</td>
<td>32-64 vCPU</td>
<td>200 vCPU</td>
<td>

Single shared  datastore for compute cluster

</td>
<td>Organization Administrator role required. Vapp leases should be set to ’never expire’</td>
</tr>
<tr>
<td>vSphere 6.7 (ESXi)</td>
<td>

8 public IPv4 addresses

</td>
<td>

128-256G RAM

</td>
<td>

500G RAM

</td>
<td></td>
<td></td>
</tr>
<tr>
<td>vCenter Server 6.7</td>
<td></td>
<td>

500G-1TB Disk

</td>
<td>

2TB Disk

</td>
<td></td>
<td></td>
</tr>
<tr>
<td>NSX-T</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td>NSX-V</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
</tbody>
</table>

**Note:** Empty cells intentionally left blank.

### VCD Configuration Settings

MobiledgeX’s Cloudlet Manager Plugin accesses the VCD API endpoint to install the MobiledgeX Platform service referred to as the Cloudlet Resource Manager (CRM). The CRM acts as a Tenant of the Operator’s Virtualization Layer and utilizes VCD APIs to manage applications. The CRM also provides the infrastructure and application runtime statistics to the MobiledgeX Controller (over the Internet). MobiledgeX stores the credentials to the API securely. MobiledgeX requires that both Organization and Tenant access on the IaasS API level is granted via private and public API endpoints. It is not a requirement to place the IaaS endpoint directly on a public IP; it can reside behind a jumphost or by other security measures. However, the VCD API endpoint must be reachable from within the cloudlet itself.

The following values must be populated to enable MobiledgeX deployment within VCD.
<table>
<tbody>
<tr>
<th>Variable</th>
<th>Description</th>
</tr>
<tr>
<td>VDC_NAME</td>
<td>Name of the Organizational Virtual Datacenter</td>
</tr>
<tr>
<td>VCD_ORG</td>
<td>Name of the Organization assigned to MobiledgeX</td>
</tr>
<tr>
<td>VCD_USER</td>
<td>Username for MobiledgeX user</td>
</tr>
<tr>
<td>VCD_PASSWORD</td>
<td>Password for MobiledgeX user</td>
</tr>
<tr>
<td>VCD_IP</td>
<td>Cloud Director API endpoint address</td>
</tr>
</tbody>
</table>

### VCD APIs

The following is a list of vCloud User Operation APIs which should be made available to the MobiledgeX Tenant for operations within the MobiledgeX Org VDC.

**POST** /catalog/{id}/catalogItems

**GET** /catalog/{id}/metadata

**GET** /catalog/{id}/metadata/{key}

**GET** /catalogItem/{id}

**PUT** /catalogItem/{id}

**DELETE** /catalogItem/{id}

**GET** /catalogItem/{id}/metadata

**POST** /catalogItem/{id}/metadata

**GET** /catalogItem/{id}/metadata/{key}

**PUT** /catalogItem/{id}/metadata/{key}

**DELETE** /catalogItem/{id}/metadata/{key}

**GET** /catalogs/query

**GET** /entity/{id}

**GET** /login

**POST** /login

**GET** /media/{id}

**PUT** /media/{id}

**DELETE** /media/{id}

**GET** /media/{id}/metadata

**POST** /media/{id}/metadata

**GET** /media/{id}/metadata/{key}

**PUT** /media/{id}/metadata/{key}

**DELETE** /media/{id}/metadata/{key}

**GET** /media/{id}/owner

**GET** /mediaList/query

**GET**/network/{id}

**GET** /network/{id}/metadata

**GET** /network/{id}/metadata/{key}

**GET** /org

**GET** /org/{id}

**POST** /org/{id}/catalog/{catalogId}/action/controlAccess

**GET** /org/{id}/catalog/{catalogId}/controlAccess

**GET** /org/{id}/metadata

**GET** /org/{id}/metadata/{key}

**GET** /query

**GET** /schema/{schemaFileName}

**GET** /session

**DELETE** /session

**POST** /sessions

**GET** /task/{id}

**POST** /task/{id}/action/cancel

**GET** /tasksList/{id}

**GET** /vApp/{id}

**PUT**/vApp/{id}

**DELETE** /vApp/{id}

**POST** /vApp/{id}/action/consolidate

**POST** /vApp/{id}/action/controlAccess

**POST** /vApp/{id}/action/deploy

**POST**/vApp/{id}/action/discardSuspendedState

**POST** /vApp/{id}/action/enterMaintenanceMode

**POST** /vApp/{id}/action/exitMaintenanceMode

**POST** /vApp/{id}/action/installVMwareTools

**POST** /vApp/{id}/action/recomposeVApp

**POST** /vApp/{id}/action/relocate

**POST** /vApp/{id}/action/undeploy

**POST** /vApp/{id}/action/upgradeHardwareVersion

**GET** /vApp/{id}/controlAccess

**GET** /vApp/{id}/guestCustomizationSection

**PUT** /vApp/{id}/guestCustomizationSection

**GET** /vApp/{id}/leaseSettingsSection

**PUT** /vApp/{id}/leaseSettingsSection

**POST** /vApp/{id}/media/action/ejectMedia

**POST** /vApp/{id}/media/action/insertMedia

**GET** /vApp/{id}/metadata

**POST** /vApp/{id}/metadata

**GET** /vApp/{id}/metadata/{key}

**PUT** /vApp/{id}/metadata/{key}

**DELETE** /vApp/{id}/metadata/{key}

**GET** /vApp/{id}/networkConfigSection

**PUT** /vApp/{id}/networkConfigSection

**GET** /vApp/{id}/networkConnectionSection

**PUT** /vApp/{id}/networkConnectionSection

**GET** /vApp/{id}/networkSection

**GET** /vApp/{id}/operatingSystemSection

**PUT** /vApp/{id}/operatingSystemSection

**GET** /vApp/{id}/owner

**PUT** /vApp/{id}/owner

**POST** /vApp/{id}/power/action/powerOff

**POST** /vApp/{id}/power/action/powerOn

**POST** /vApp/{id}/power/action/reboot

**POST** /vApp/{id}/power/action/reset

**POST** /vApp/{id}/power/action/shutdown

**POST**/vApp/{id}/power/action/suspend

**GET** /vApp/{id}/productSections

**PUT** /vApp/{id}/productSections

**GET** /vApp/{id}/question

**POST** /vApp/{id}/question/action/answer

**GET** /vApp/{id}/runtimeInfoSection

**GET** /vApp/{id}/screen

**POST** /vApp/{id}/screen/action/acquireTicket

**GET** /vApp/{id}/startupSection

**PUT** /vApp/{id}/startupSection

**GET** /vApp/{id}/virtualHardwareSection

**PUT** /vApp/{id}/virtualHardwareSection

**GET** /vApp/{id}/virtualHardwareSection/cpu

**PUT** /vApp/{id}/virtualHardwareSection/cpu

**GET** /vApp/{id}/virtualHardwareSection/disks

**PUT** /vApp/{id}/virtualHardwareSection/disks

**GET** /vApp/{id}/virtualHardwareSection/media

**GET** /vApp/{id}/virtualHardwareSection/memory

**PUT** /vApp/{id}/virtualHardwareSection/memory

**GET** /vApp/{id}/virtualHardwareSection/networkCards

**PUT** /vApp/{id}/virtualHardwareSection/networkCards

**GET** /vApp/{id}/virtualHardwareSection/serialPorts

**PUT** /vApp/{id}/virtualHardwareSection/serialPorts

**GET** /vAppTemplate/{id}

**PUT** /vAppTemplate/{id}

**DELETE** /vAppTemplate/{id}

**POST** /vAppTemplate/{id}/action/consolidate

**POST** /vAppTemplate/{id}/action/disableDownload

**POST** /vAppTemplate/{id}/action/enableDownload

**POST** /vAppTemplate/{id}/action/relocate

**GET** /vAppTemplate/{id}/customizationSection

**PUT** /vAppTemplate/{id}/customizationSection

**GET** /vAppTemplate/{id}/guestCustomizationSection

**PUT** /vAppTemplate/{id}/guestCustomizationSection

**GET** /vAppTemplate/{id}/leaseSettingsSection

**PUT** /vAppTemplate/{id}/leaseSettingsSection

**GET** /vAppTemplate/{id}/metadata

**POST** /vAppTemplate/{id}/metadata

**GET** /vAppTemplate/{id}/metadata/{key}

**PUT** /vAppTemplate/{id}/metadata/{key}

**DELETE** /vAppTemplate/{id}/metadata/{key}

**GET** /vAppTemplate/{id}/networkConfigSection

**PUT** /vAppTemplate/{id}/networkConfigSection

**GET** /vAppTemplate/{id}/networkConnectionSection

**PUT** /vAppTemplate/{id}/networkConnectionSection

**GET** /vAppTemplate/{id}/networkSection

**GET** /vAppTemplate/{id}/ovf

**GET** /vAppTemplate/{id}/owner

**GET** /vAppTemplate/{id}/productSections

**PUT** /vAppTemplate/{id}/productSections

**GET** /vAppTemplate/{id}/shadowVms

**GET** /vAppTemplates/query

**GET** /vApps/query

**GET** /vdc/{id}

**POST**/vdc/{id}/action/captureVApp

**POST** /vdc/{id}/action/cloneMedia

**POST** /vdc/{id}/action/cloneVApp

**POST** /vdc/{id}/action/cloneVAppTemplate

**POST** /vdc/{id}/action/composeVApp

**POST** /vdc/{id}/action/instantiateVAppTemplate

**POST** /vdc/{id}/action/uploadVAppTemplate

**POST** /vdc/{id}/media

**GET** /vdc/{id}/metadata

**GET**/vdc/{id}/metadata/{key}

**GET** /vms/query

## VCD  MobiledgeX Deployment Architecture

![vCloud Directory VMware Component Diagram](/operator/assets/vcd.png "vCloud Directory VMware Component Diagram")

