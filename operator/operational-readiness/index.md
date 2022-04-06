---
title: Operational Readiness
long_title:
overview_description:
description: Operational Readiness
---

The MobiledgeX platform requires an underlying IaaS for operation both for the internal components that comprise the MobiledgeX platform and for the developer deployments.

This raises the question of where the delineation between the MobiledgeX platform and the IaaS deployments is made. This document provides an answer to that question along with additional context.

**Operations Roles**

There are three roles defined in the MobiledgeX platform. The table below provides a brief description of each of these roles.

Note that an organization can span multiple roles; for example, an Operator that provides Developer support can be said to work within both the *Operator* and the *Developer* role.
| Operations Role  | Responsibility                                   |
|------------------|--------------------------------------------------|
| MobiledgeX Admin | Manages overall platform                         |
| Operator         | Manages cloudlet(s)                              |
| Developer        | Deploys to cloudlets via the MobiledgeX Platform |

**Role Delineation**

The easiest way to understand the responsibilities for Operators, Developers, and MobiledgeX Admins is by the use of a RACI chart. For those unfamiliar, a RACI chart is a matrix used to assign roles and responsibilities for tasks, milestones, or operational areas. This helps eliminate confusion by providing details on what roles are involved and at what level of involvement.

**RACI Example**

The table below illustrates this using the example of an operations department that needs to schedule a systems maintenance window.
| ** **       | Definition                    | Example                                                           |
|-------------|-------------------------------|-------------------------------------------------------------------|
| Responsible | Performs the work.            | Performs the actual work for the maintenance outage.              |
| Accountable | Signs off on completed work.  | Makes the final decision on when a maintenance outage will occur. |
| Consulted   | Provides input into the work. | Helps determine a date/time for a maintenance outage.             |
| Informed    | Is informed about the work.   | Told the date/time of a maintenance outage.                       |


**Detailed Responsibilities**

The RACI chart below provides the key responsibilities cross referenced to the involvement of each role.
| Operational Area                          | MobiledgeX | Operator | Developer | Notes                                                     |
|-------------------------------------------|------------|----------|-----------|-----------------------------------------------------------|
| Platform Data Accountability              | R A        |          |           |                                                           |
| Platform Endpoint Protection              | R A        |          |           |                                                           |
| Platform Identity and Access Management   | R A        |          |           |                                                           |
| Platform Application Level Controls       | R A        |          |           |                                                           |
| Platform Backup                           | R A        |          |           |                                                           |
| Platform Recovery                         | R A        | I        | I         | Inform only on potential service disruption.              |
| Platform Upgrades                         | R A        | I        | I         | Inform only on potential service disruption.              |
| Network Controls                          | C          | R A      |           | Consult on config change or potential service disruption. |
| Host Infrastructure                       | C          | R A      |           | Consult on config change or potential service disruption. |
| IaaS Security                             | I          | R A      |           | Includes endpoints, hypervisor, OS.                       |
| Physical Security                         | I          | R A      |           |                                                           |
| Deployment Data Accountability            |            |          | R A       |                                                           |
| Deployment Endpoint Protection            |            |          | R A       |                                                           |
| Deployment Identity and Access Management |            |          | R A       |                                                           |
| Deployment Application Level Controls     |            |          | R A       |                                                           |