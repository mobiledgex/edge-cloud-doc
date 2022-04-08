---
title: Security & Trust Policy
long_title: 
overview_description: 
description: 
Learn how to secure your applications using the MobiledgeX Trust Policy

---

**Last Modified: 11/18/21**

## Trust Policy

A **Trust Policy** allow you to control the outbound connections your instances are permitted to make. By default, all outbound traffic is allowed; when a trust policy is created, all outbound traffic is blocked except for the specific ports, protocols, and Remote IP CIDR defined in the Trust Policy.

Because Trust Policies are at the cloudlet-level, there is no configuration required to enable Trust Policies. You simply enable the Trust *option* when you create your application, where it will get deployed to the Trusted cloudlet. Keep in mind that restrictions on the outbound traffic will occur, whether you have manually created or auto-provisioned your application instances.

**Note:** Non-trusted applications cannot be deployed to Trusted cloudlets.

![Trust Policy option](/developer/assets/developer-ui-guide/trusted-policy.png "Trust Policy option")

All existing Trust Policies are displayed on the Trust Policy page.

![Trust Policy page](/developer/assets/developer-ui-guide/trust-policy-page.png "Trust Policy page")

