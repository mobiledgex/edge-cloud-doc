---
title: Direct vs. Restricted Access
long_title:
overview_description:
description: Learn about the different access types used depending on the IaaS type supported
---

## Resource Management and Workflow

MobiledgeX presently supports [OpenStack Tenant Deployment](/operator/supported-iaas-stacks/openstack/openstack-tenant-deployment) as the Virtual Machine Orchestration layer.

With the OpenStack model, the MobiledgeX Platform is a tenant on an existing OpenStack environment within the operator’s infrastructure. As the operator, you register your cloudlet by providing MobiledgeX with a pool of compute resources and access to the OpenStack API endpoint by specifying a few required parameters, such as dynamic IP addresses, cloudlet names, location of cloudlets, certs, and more, using the [Edge-Cloud Console](https://console.mobiledgex.net/#/). MobiledgeX relies on this information to remotely access the cloudlets to determine resource requirements as well as dynamically track usage. Once MobiledgeX completes its remote probe of the operator’s infrastructure, a record of inventory is maintained within a cloudlet registry.

## Direct vs. Restricted Access

**Note:** While VSphere is available as a *Platform Type*, only Direct access is currently supported, but is considered an alpha feature at this point; Restricted access for VSphere is under development and currently not supported. If you wish to schedule a demo for VSphere, contact MobiledgeX.

MobiledgeX relies on the ability to access the operator’s infrastructure (API endpoint) to set up the cloudlets via the Controller to perform various operational tasks. Providing MobiledgeX Direct access makes it seamless for MobiledgeXAdmin to access the operator’s API endpoint through a public network, and to perform those tasks. However, we understand that different operators often use varying security methods, so providing MobiledgeX with Direct access to the API endpoint over the public network may not always be feasible. To overcome this challenge, MobiledgeX provides operators with a means to restrict access from the public network to their infrastructure by specifying the Restricted access type through the [Edge-Cloud Console](https://console.mobiledgex.net/#/). Using the Restricted access type will allow MobiledgeX to create a cloudlet object to then create cloudlets.

If Restricted access type is used, operators are required to take additional steps to ensure their infrastructure is set up so that access to the API endpoint is available and information can be exchanged. Operators will need to create their cloudlets by following a few steps provided directly within a cloudlet Manifest file to bring up the cloudlet. For steps on how to set up Restricted access, refer to the steps as described in <a href="https://operators.mobiledgex.com/edge-cloud-console-guide-for-operators#to-create-and-deploy-cloudlets-using-restricted-access">
**To create and deploy cloudlets using Restricted access**.</a>

## OpenRC and CACert Data for OpenStack Cloud Management

For OpenStack, simple client environment scripts such as OpenRCs are supported and represented as a `key=value pair`. These scripts are available to help increase the efficiency of client operations. Additionally, CACert Data is supported, which is a collection of the trusted certificate authority (CA) used to encrypt and secure data transmission over the internet and authenticate and authorize users connecting to sites. MobiledgeX stores these OpenRC and CACert Data in a separate secure storage environment.

Often times, MobiledgeX will add the OpenRC details on behalf of the operator. In this case, the OpenRC Data field may be left blank and MobiledgeX will provide operators the *Physical Name* of the cloudlet to be provided in the *Physical Name* field. However, if there is a need to upload a new OpenRC file or the CACert Data file was not uploaded, the operator must upload the files manually and provide a *Physical Name*.

