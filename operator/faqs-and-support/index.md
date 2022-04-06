---
title: FAQs and Support
long_title:
overview_description:
description: Access the MobiledgeX most frequently asked questions and answers on terminology and how the platform operates.
---

## Support  

If you have any questions about our product and usage, please review our existing documentation on our [Operator Portal](https://operators.mobiledgex.com/) or consult the FAQs section below. If you cannot find what you are looking for, please contact our [support@mobiledgex.com](support@mobiledgex.com).

## FAQs

Here are the most frequently asked questions about MobiledgeX’s product and offering. If you have questions and don’t see them here, please submit them to [support@mobiledgex.com](support@mobiledgex.com) and we will do our best to publish your questions along with answers in a timely fashion. Please do check back periodically as we continuously update our FAQ page.

**What are my resource usage metrics?**

Monitoring data with the Edge-Cloud Console assumes the application was deployed via the Console, and this data can therefore not be observed outside the Console.

Different metrics are available for the different deployment methods.

Using the MobiledgeX SDK to find/connect to a cloudlet will help provide additional metrics including devices connected.

The Alert Event framework that is under development is designed to provide alerts on certain events (low disk, CPU, etc).

**What is my cloudlet utilization in terms of reserved capacity (CPU, RAM, disk)?**

This information is not currently exposed via the console or the API.

An operator should be able to pull this information from the substrate level (OpenStack, VIO, etc).

**What is my active utilization (what is currently being used by applications deployed to the cloudlet) versus what is reserved?**

Monitoring data in the console; this assumes that the application was deployed via the console (otherwise monitoring data will not be available) and that the operator is part of the organization that has the application deployed. This information is not consumable outside of the console.

An operator should be able to pull this information from the substrate level (OpenStack, VIO, etc).

**What is deployed to the cloudlet currently (what applications, what organizations, etc)?**

This information is only available to the superuser group or to the organizations that own the clusters and application instances. An on-prem deployment should have superuser permissions and would be able to pull this data.

One concern here is the legal aspect. For example, a deployment to a cloudlet that gets a DMCA takedown notice, or violates PCI, HIPPA, or GDPR.

**How do I evacuate a node (due to some sort of failure, EOL of the hardware, etc)? Can I migrate the applications on that node to another node?**

Currently, this task must be performed at the substrate level (OpenStack, VIO, etc).

Ideally, the application will be deployed in a HA configuration where it can survive the failure of a node on a cloudlet.

**How do I expand my capacity? More generally, how do I manage capacity?**

There are two steps here: one is adding it to the substrate, the other is making it available to MobiledgeX. This currently is a process that MobiledgeX will need to work with the operator to perform.

**How do I handle stateful data?**

Docker volumes are currently supported.

**Do I need to do anything to manage the DME, such as provide hints, recommend certain architectural decisions, etc?**

Nothing currently; DME works at a layer above the cloudlet operator.

