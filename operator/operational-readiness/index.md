---
title: Operational Readiness
long_title:
overview_description:
description: Operational Readiness
---

The MobiledgeX platform requires an underlying IaaS for operation both for the internal components that comprise the MobiledgeX platform and for the developer deployments.

This raises the question of where the delineation between the MobiledgeX platform and the IaaS deployments is made. This document provides an answer to that question along with additional context.

## Operations Roles

There are three roles defined in the MobiledgeX platform. The table below provides a brief description of each of these roles.

Note that an organization can span multiple roles; for example, an Operator that provides Developer support can be said to work within both the *Operator* and the *Developer* role.
<table>
<tbody>
<tr>
<th>Operations Role</th>
<th>Responsibility</th>
</tr>
<tr>
<td>MobiledgeX Admin</td>
<td>Manages overall platform</td>
</tr>
<tr>
<td>Operator</td>
<td>Manages cloudlet(s)</td>
</tr>
<tr>
<td>Developer</td>
<td>Deploys to cloudlets via the MobiledgeX Platform</td>
</tr>
</tbody>
</table>

### Role delineation

The easiest way to understand the responsibilities for Operators, Developers, and MobiledgeX Admins is by the use of a RACI chart. For those unfamiliar, a RACI chart is a matrix used to assign roles and responsibilities for tasks, milestones, or operational areas. This helps eliminate confusion by providing details on what roles are involved and at what level of involvement.

#### RACI example

The table below illustrates this using the example of an operations department that needs to schedule a systems maintenance window.
<table>
<tbody>
<tr>
<td colspan="1" rowspan="1">

** **
</td>
<th>Definition</th>
<th>Example</th>
</tr>
<tr>
<td>Responsible</td>
<td>Performs the work.</td>
<td>Performs the actual work for the maintenance outage.</td>
</tr>
<tr>
<td>Accountable</td>
<td>Signs off on completed work.</td>
<td>Makes the final decision on when a maintenance outage will occur.</td>
</tr>
<tr>
<td>Consulted</td>
<td>Provides input into the work.</td>
<td>Helps determine a date/time for a maintenance outage.</td>
</tr>
<tr>
<td>Informed</td>
<td>Is informed about the work.</td>
<td>Told the date/time of a maintenance outage.</td>
</tr>
</tbody>
</table>

#### Detailed responsibilities

The RACI chart below provides the key responsibilities cross referenced to the involvement of each role.
<table>
<tbody>
<tr>
<th>Operational Area</th>
<th>MobiledgeX</th>
<th>Operator</th>
<th>Developer</th>
<th>Notes</th>
</tr>
<tr>
<td>Platform Data Accountability</td>
<td>R A</td>
<td> </td>
<td> </td>
<td> </td>
</tr>
<tr>
<td>Platform Endpoint Protection</td>
<td>R A</td>
<td> </td>
<td> </td>
<td> </td>
</tr>
<tr>
<td>Platform Identity and Access Management</td>
<td>R A</td>
<td> </td>
<td> </td>
<td> </td>
</tr>
<tr>
<td>Platform Application Level Controls</td>
<td>R A</td>
<td> </td>
<td> </td>
<td> </td>
</tr>
<tr>
<td>Platform Backup</td>
<td>R A</td>
<td> </td>
<td> </td>
<td> </td>
</tr>
<tr>
<td>Platform Recovery</td>
<td>R A</td>
<td>I</td>
<td>I</td>
<td>Inform only on potential service disruption.</td>
</tr>
<tr>
<td>Platform Upgrades</td>
<td>R A</td>
<td>I</td>
<td>I</td>
<td>Inform only on potential service disruption.</td>
</tr>
<tr>
<td>Network Controls</td>
<td>C</td>
<td>R A</td>
<td> </td>
<td>Consult on config change or potential service disruption.</td>
</tr>
<tr>
<td>Host Infrastructure</td>
<td>C</td>
<td>R A</td>
<td> </td>
<td>Consult on config change or potential service disruption.</td>
</tr>
<tr>
<td>IaaS Security</td>
<td>I</td>
<td>R A</td>
<td> </td>
<td>Includes endpoints, hypervisor, OS.</td>
</tr>
<tr>
<td>Physical Security</td>
<td>I</td>
<td>R A</td>
<td> </td>
<td> </td>
</tr>
<tr>
<td>Deployment Data Accountability</td>
<td> </td>
<td> </td>
<td>R A</td>
<td> </td>
</tr>
<tr>
<td>Deployment Endpoint Protection</td>
<td> </td>
<td> </td>
<td>R A</td>
<td> </td>
</tr>
<tr>
<td>Deployment Identity and Access Management</td>
<td> </td>
<td> </td>
<td>R A</td>
<td> </td>
</tr>
<tr>
<td>Deployment Application Level Controls</td>
<td> </td>
<td> </td>
<td>R A</td>
<td> </td>
</tr>
</tbody>
</table>

