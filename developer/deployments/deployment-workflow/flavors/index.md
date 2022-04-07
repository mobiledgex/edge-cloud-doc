---
title: Flavors
long_title:
overview_description:
description:
Understanding Flavors and how to choose them

---

**Last Modified:** 8/20/2021

The term **Flavor** is used by the MobiledgeX platform to define varying resource configurations. Flavors can also be referred to as compute substrates. Flavors include several different resource dimensions and are divided by regions, as listed below. Selected Flavors are specified when you create a cluster instance. To designate the Flavor, choose the best Flavor suited to run your application instances while delivering consistent processing performance; refer to [Sizing your Deployment](/developer/design/sizing-applications/index.md) for guidelines.

| **Memory** | Amount of memory allocated to the application                    |
|------------|------------------------------------------------------------------|
| **Disk**   | Amount of disk space allocated to the application for storage    |
| **vCPU**   | Number of virtual CPUs provided to the application               |
| **GPU**    | Number of GPUs provided to the application                       |
| **vGPU**   | This is supported. Please see details below under **GPU usage**. |

On the MobiledgeX platform, application instances are hosted on cluster instances. The defined Flavor, which may be either the default Flavor for the application or the Flavor for the cluster instance, defines the resources available for use by the application instance. When additional application instances are deployed, additional cluster instances are created to host the new application instances. Since a cluster instance exists solely to support a deployed application instance, the resources provided to the cluster instance may be viewed as those resources being supplied to the application instance.

## vCPU  

The term vCPU is used to describe hardware virtualization and is a way to quantify the amount of performance you can expect from a virtual machine. For a developer, the assumption is, if you have a virtual machine that is defined with two vCPUs, you can expect approximately the same level of performance you would receive from a bare metal server with two CPU cores. Operators may use a vCPU as a way to divide the available virtual cores in a server among the tenants running on that server.

Although some vendors map physical cores to vCPU, the vCPU is more accurately described as a measure of processing time on the CPU.

Regarding deployments on the MobiledgeX Platform, you should expect a vCPU to equate approximately to the number of physical cores in a modern datacenter class server. However, there may be some variation that may depend on the type and age of the underlying hardware used.

## GPU usage  

MobiledgeX supports GPU passthrough and virtual GPUs(vGPU). The flavor name will indicate GPU support. The flavor details page will show the number of GPUs (in the case of GPU passthrough) or vGPU slices (in the case of vGPU). GPU flavors are supported on cloudlets that support GPUs.

## VM Deployments  

Flavors are also used in virtual machine deployments. Flavors within virtual machine deployment provide resources to the virtual machine directly, as opposed to container-based workloads where a host cluster receives the provided resources.

## Guidelines for Specifying Flavor

When denoting the Flavor for your application instance, the Flavor assigned to the application instance is dependent on the following scenarios. For information on how to size your deployment and select the most appropriate Flavor for your application instance, refer to the [sizing your deployment](/developer/design/sizing-applications/index.md) document.

**Case 1. Manual**. When a cluster instance is designated as Manual (created manually), the Flavor that is selected for the cluster instance is the default Flavor for all application instances without an app-specified Flavor. Please see Case 3 for further details of the app-specific Flavor.

**Case 2. Automatic**. When an auto-cluster instance is created, the Flavor that is automatically applied to all application instances associated with that auto-cluster will be the Flavor identified as the most optimum resource for the application instance within the auto-cluster. Please note that application instances with a manually designated app-specific Flavor will default to use the Flavor automatically selected by the auto-cluster. Additionally, if an app-specific Flavor is not designated for the application instance, the default Flavor specified for the auto-cluster will be applied as the Flavor for the application instance.

**Case 3. App-specific Flavor**. When an application is associated with an app instance, a Flavor may be designated to be used explicitly by that application within the app instance. The App-specific Flavor can be used by applications associated with a manual cluster instance only. The App-specific Flavor serves as that specific application’s default Flavor. When designating a Flavor, if an app-specific Flavor for the application instance is not selected, the default Flavor applied for that application will be the Flavor designated for the manual cluster instance.

The following actions may be performed on this page:

- Filter Flavors by region
- Type in a few letters to auto-populate your search results

![Flavors page](/developer/assets/flavorespage.png "Flavors page")

