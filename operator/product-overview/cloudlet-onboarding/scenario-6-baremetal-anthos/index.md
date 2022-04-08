---
title: "IaaS Type: Bare Metal Anthos"
long_title:
overview_description:
description: Support for Bare Metal Anthos
---

In the Anthos bare metal deployment option, workloads run on a Kubernetes cluster on bare metal. This implementation allows for efficient use of resources as there is no virtualization layer. The Google Kubernetes stack is directly installed on the bare metal servers, and then the MobiledgeX platform is deployed to install and manage applications. Developer workloads are separated into namespaces, and network policies are automatically created when the MobiledgeX platform deploys these workloads to keep them separated. This model supports only Kubernetes-based applications. The cluster can be viewed within the Google Anthos dashboard when registered with a GCP account. Security and RBAC control of the developer workloads is maintained within the MobiledgeX ecosystem and not on the public cloud.

![Anthos Reference Architecture](/operator/assets/hybrid-edge.png "Anthos Reference Architecture")

## Anthos on Bare Metal Minimum Requirements

<table>
<tbody>
<tr>
<td colspan="1" rowspan="1">

**Hardware Requirements**
</td>
<td colspan="1" rowspan="1">

**Software Components**
</td>
<td colspan="1" rowspan="1">

**Network Requirements**
</td>
</tr>
<tr>
<td>RAM size: 128-256GB</td>
<td>RAM size: 500G</td>
<td>2 10G Ethernet interfaces on public network, bonded</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

32-64 vCPU

</td>
<td colspan="1" rowspan="1">

200 vCPU

</td>
<td>DHCP range: preferably full /28 but at a minimum 8 IPs, in addition to those assigned to the host</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

Disk range: 500GB-1TB

</td>
<td>Disk size: 2T</td>
<td>SSH access from MobiledgeX (can be via Linux jumphost)</td>
</tr>
<tr>
<td>Out of band management interface/console</td>
<td>GPU: NVIDA T4</td>
<td>All firewall ports open from mobile network</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Egress access to internet</td>
</tr>
</tbody>
</table>

## MobiledgeX + Anthos Benefits

- Multi-tenancy and isolation
- Bare Metal efficiency
- Single click deployment
- Observability
- Cloud burst
- Security
- Cost optimization
- Control retention
- Automation
- Insight to metadata collection and analysis

## Benefits of Using MobiledgeX

- Application Orchestration and Deployment Workflow **:** Allow the end user to utilize the system in a truly serverless scheme where all deployment tasks are simplified
- Collect application metrics and analyze those values to improve awareness of MobiledgeX components to run the applications
- Automatic scaling of application containers and VMs deployed based on demand and client application load using zero-touch configuration
- Workload deployment with a graphical user interface to simplify DevOps process

- Access to logs that MobiledgeX collects from various sources to store and analyze from a single collection

- Ability to view alarm to help operator take action for the repair and maintenance of workload applications and MobiledgeX components

- Health Checks to identify inconsistencies, irregularities, and issues that can possibly degrade operational efficiency
- Metrics and Insights:**** Utilize defined application metrics to detect and rectify performance anomalies

Contact us for more information at support@mobiledgex.com.

