---
title: VM Pool Installation on VMware vCD
long_title:
overview_description:
description: Describes the end to end steps to deploy a MobiledgeX cloudlet using VM Pool Deployment option on VMware vCD Virtualized Infrastructure Manager.
---

This document focuses on the use of VMWare Cloud Director as the VIM for MobiledgeX VM Pool Deployment Model.

## Scope and Constraints

- Only cloud-native containerized workloads are currently supported; this includes docker and Kubernetes deployments.
- Deployment of native virtual machines (VMs) is not supported.
- Specialized device/GPU support is limited, and may require the MobiledgeX DevOps team to assist in the deployment process.
- The use of VIM level health checks and re-assignment based on machine policies is not supported.
- MobiledgeX only controls resource management within the scope of the MobiledgeX platform; VIM Operators have control over resource management beyond the platform. However, all changes must be done in coordination with MobiledgeX.

## Platform and Pool VMs

The MobiledgeX platform requires a dedicated instance to manage the deployment, communicate back to the MobiledgeX services, and orchestrate workloads. The dedicated instance is separate from the Pool VMs; these instances provide the compute capability for workloads deployed to the cloudlet.

## Operator Workflow

Step 1: Determine the correct version/format required.

Step 2: Download artifacts from the MobiledgeX repository.

Step 3: Verify the SHA256 Checksums.

Step 4: Load the resources into the VCD Catalog

Step 5: Validate Network Configuration

Step 6: Provide deployment information to MobiledgeX.

Step 7: Cloudlet Deployment (MobiledgeX Responsibility)

Step 8: Handover Testing

### Step 1: Determine versions

MobiledgeX will provide you with the version number and format information for the artifacts you will require for your environment. Versioning will come in the form of a full URL for download:

For example, for a VCD deployment of v3.1.5, you will be provided with the following artifact paths for download:

```
https://artifactory.mobiledgex.net/artifactory/baseimages/vsphere-ovf-3.1.5/mobiledgex-v3.1.5-vsphere-disk-0.vmdk

https://artifactory.mobiledgex.net/artifactory/baseimages/vsphere-ovf-3.1.5/mobiledgex-v3.1.5-vsphere.ovf
```

### Step 2: Download resources

MobiledgeX provides the platform image in several formats:
<table>
<tbody>
<tr>
<td colspan="1" rowspan="1">

**IaaS / VIM**
</td>
<td colspan="1" rowspan="1">

**File Format/Type**
</td>
<td colspan="1" rowspan="1">

**Notes**
</td>
</tr>
<tr>
<td>OpenStack</td>
<td>qcow2</td>
<td>[QEMU](https://www.qemu.org/) Copy on Write format.</td>
</tr>
<tr>
<td>VMWare</td>
<td>vmdk</td>
<td>Virtual Machine DisK Image</td>
</tr>
<tr>
<td>VMWare</td>
<td>ovf</td>
<td>XML file that contains metadata for the VM, Template, or App Template.</td>
</tr>
<tr>
<td>VMWare</td>
<td>mf</td>
<td>A manifest file containing all SHA1 checksums for all files in the VMWare deployment package.</td>
</tr>
</tbody>
</table>

MobiledgeX will direct you to download the correct format for your environment.

These files can be downloaded in one of two ways:

#### Directly from Artifactory GUI

You can use your console username/password to log into the MobiledgeX Artifactory installation and download the artifacts using the web browser of your choice. The files are under the Base images folder and are further broken down by format/type.

![Directories in Artifactory](/operator/assets/vm-pool/artifactory.png "Directories in Artifactory")

#### From the CLI

The files can also be downloaded directly from the command line using cURL.

For example, the following commands would be provided for the download of the vSphere format of version 3.1.5 of the software:

```
curl -u &lt;CONSOLEUSER&gt;:&lt;CONSOLEPASS&gt;  -O "https://artifactory.mobiledgex.net/artifactory/baseimages/vsphere-ovf-3.1.5/mobiledgex-v3.1.5-vsphere-disk-0.vmdk"
```

```
curl -u &lt;CONSOLEUSER&gt;:&lt;CONSOLEPASS&gt;  -O "https://artifactory.mobiledgex.net/artifactory/baseimages/vsphere-ovf-3.1.5/mobiledgex-v3.1.5-vsphere.ovf"
```

### Step 3: Verify the SHA256

It is vital to ensure that the artifacts are not corrupted in the file transfer. Artifactory computes a SHA256 Checksum for each file it serves. You will need to generate the SHA256 checksum on the downloaded file and then compare it to the checksum in Artifactory.

![Checksum in Artifactory](/operator/assets/vm-pool/checksum-artifactory.png "Checksum in Artifactory")

#### Computing the SHA256

The process of computing the SHA256 varies by platform; for Linux you can use the [sha256sum](https://www.computerhope.com/unix/sha256sum.htm) utility (you may need to install this using your package manager):

```
$ sha256sum  mobiledgex-v3.1.5-vsphere.ovf
167fefcf151002e9f4b411c09d455d8b0d194c7adc3804fd0eb255109eff130f
mobiledgex-v3.1.5-vsphere.ovf

```

For macOS, you can use the [sha2](https://formulae.brew.sh/formula/sha2#default) package, which can be installed via [Homebrew](https://brew.sh/).

```
$ sha2 -256 mobiledgex-v3.1.5-vsphere.ovf
SHA-256 (./mobiledgex-v3.1.6.qcow2) = 167fefcf151002e9f4b411c09d455d8b0d194c7adc3804fd0eb255109eff130f

```

Under Windows, you can use the [Get-FileHash](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-filehash?view=powershell-7) commandlet in PowerShell to calculate the SHA256:

![Powershell](/operator/assets/vm-pool/powershell.png "Powershell")

If the SHA256 calculated locally does not match the value provided in Artifactory, delete the file and retry the download. If this still does not match, please contact MobiledgeX support.

### Step 4: Load resources to VCD

The specific steps required to load the VCD catalog resources will vary depending on the software’s version and the user’s permissions. The examples below should work for all software versions; however, the screenshots/names may not match up directly with newer versions.

#### VCD Workflow


- Connect to the VCD portal.
- Navigate to Libraries → App Templates
- Select Source and upload OVF and VMDK files downloaded in Step 2.


![VCD portal](/operator/assets/vm-pool/vcd-portal.png "VCD portal")


- Select **Next**.
- The Review Details option screen will display.
- Under **Select vApp Template Name**, select the catalog to which you are deploying the vAPP.


![Select catalog](/operator/assets/vm-pool/vcd-portal-select-template.png "Select catalog")


- Select **Finish**.


![Upload and process template](/operator/assets/vm-pool/vapp-templates.png "Upload and process template")


- Wait for the template to complete uploading and processing.


If any errors are returned, please check your permissions. Most load failures are due to the user not having the correct permissions.

**Notes:**

- Appropriate user permissions will be required to upload media and other resources to the Catalog. If your permissions do not allow you to upload, please see your VCD Administrator.
- Resources can be supplied in either [vApp Template](https://docs.vmware.com/en/VMware-Cloud-Director/9.7/com.vmware.vcloud.user.doc/GUID-8B4E64F0-E036-4940-9CB1-2C7AC72E86F6.html) or as a [VMWare Virtual Machine](https://docs.vmware.com/en/VMware-Cloud-Director/9.7/com.vmware.vcloud.user.doc/GUID-87FC6344-1F98-4CB5-A21B-6D08F89FC7B7.html). Please ensure you are importing the correct format.
- On older versions of the VCD software, there is the possibility that the resources supplied are built using a newer/unsupported hardware version. If this happens, please contact MobiledgeX support.

For additional information, please see the [VMWare Cloud Directory documentation portal.](https://docs.vmware.com/en/VMware-Cloud-Director/index.html)

#### Provision virtual machines

Once the artifacts have been loaded into the catalog, the required virtual machines can be created for the installation process. At a minimum, the values provided below in the VM Configuration table should be met.

#### VM configuration

<table>
<tbody>
<tr>
<td colspan="1" rowspan="1">

**Resource**
</td>
<td colspan="1" rowspan="1">

**Value**
</td>
</tr>
<tr>
<td>vcpu</td>
<td>4</td>
</tr>
<tr>
<td>memory</td>
<td>16 Gb</td>
</tr>
<tr>
<td>disk</td>
<td>400 Gb</td>
</tr>
<tr>
<td>network</td>
<td>1GB</td>
</tr>
</tbody>
</table>

At a minimum, four VMs will be required per datacenter to fully standup the environment.

#### Assumptions

- Operators will define the size of VMs within the VMPool based on our request and upload it to their data store.
- Operators will host us as a tenant and offer standard RBAC methods to consume VMPool created in this process.
- Operators will create required VMs and create a flat network binding across all VMs within a Pool and attach an IP address and name them.
- Operators will assign specific VMs external access to the internet and create routes to ingress internal VMs within Pool and egress to external network internet or mobile network.

### Step 5: Validate network configuration

All virtual machines created as part of this deployment will require full access to the full complement of deployed virtual machines.

please refer to our [Firewall Requirement](/operator/product-overview/security-and-privacy-standards-policies/firewall/index.md) section for the network firewall, and security groups configuration needed.

#### Note:

- All VMPool VMs, including those with internal-network access only, should have egress access to the internet.
- All VMPool VMs must have their system time synchronized with the NTP server.

### Step 6: Provide deployment information

The following should be provided for each VM that has been deployed.

- Datacenter
- VM Name
- External IP
- Internal IP

### Step 7: Cloudlet deployment

The MobiledgeX DevOps team will use the information above to deploy the cloudlet and confirm that it communicates with all necessary services and works correctly. During this process, MobiledgeX requests that the operator has a defined contact point if there are any issues with the deployed VMs, network, firewall, or other problems.

### Step 8: Handover testing

After completing the cloudlet deployment, the MobiledgeX DevOps team will run through the deployment test process to validate the configuration. Once this is complete, the customer will deploy workloads to the cloudlet. Simultaneously, the MobiledgeX support team monitors the deployment and management until both MobiledgeX and the operator agree that the cloudlet is working correctly.

