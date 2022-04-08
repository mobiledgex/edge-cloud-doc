---
title: Utilization Metrics
long_title: 
overview_description: 
description: 
Learn about the monitoring utilization metrics that are provided by MobiledgeX to help monitor the health and performance of your application.

---

Metrics refer to the availability of resources such as vCPU, memory, disk, RAM, etc. The MobiledgeX platform collects metrics for both cluster instances and application instances.

Collecting resource metrics is useful if you use them in conjunction with [alerts](/developer/design/testing-and-debugging/alarms) that can help you identify issues and quickly respond to them. For example, you can set alerts and be notified when you have exceeded the threshold for vCPU. Metric information can also be useful when you want to understand the utilization of your resources to determine the percentage of your resource’s capacity that is in use and whether to increase them based on user demand.

## Monitoring Dashboard

From the Edge-Cloud Console UI, select **Monitoring** from the left navigation. The Monitoring page opens. Make sure that you are managing the Organization that you wish to view metrics information. 

The MobiledgeX Edge-Cloud Console provides a **Monitoring Dashboard** to help you visually centralize, collect, aggregate, and analyze events so that you can get a bigger picture of what is going on across your infrastructure in real-time. Within a single pane of glass and a customizable UI to enlarge your view and change the graphic representation of your data, you can view both current and historical data, log and analyze pattern usages and trends to make informed decisions about your infrastructure to help your users get the most out of your services offered. 
### Filtering

The Monitoring Dashboard provides many ways to filter the data you need to view and access. You can view by organization, regions, metric types, app instance, cluster instance or cloudlet, and search by admins, developers, or operators. You can also filter by time ranges. While the maximum allocated days you can search for audit logs is one day (within the last 24hrs), you can further refine your search for logs with the span of the 24 hour period.  Start time default is 12:00a.m. and End Time default is 11:59p.m.

![Monitoring Metrics Window](/developer/assets/monitoring.png "Monitoring Metrics Window")

The toolbar at the top of the Monitoring page contains many options for filtering data.

![](/developer/assets/monitor-tools.png "")


- **Organization icon:** This allows you to choose which Organization you want to manage. This icon is helpful when you are not on the Organization page. Selecting this icon will create a dropdown menu of all your organizations.
- **Time Range button:** This allows you to filter data in absolute and in relative time ranges.
- **Instance button:** Here, you can select either App Instance or Cluster Instance.
- **Region icon:** Select between US and EU for data.
- **Visibility icon:** Select what data sets you want to see on your Monitoring dashboard.
- This dropdown menu will let you view aggregate utilization of resources between given start and end time.
- **Refresh icon**
- **Refresh Rate icon:** Select rate of latency
- **Search:** Will let you filter the observed app/cluster instances by searching for names or keywords.


You can also refresh your data and specify your refresh rate by **seconds**, **minutes**, or **hours**. You will see a progress bar at the top of the page which serves as an indicator. Click the eye icon to customize your view and include specific metrics information. 

You may find the following information displayed on your Monitoring Dashboard:

- Cluster level resource utilization, performance, and status metrics
- Load balancer (Layer 4) metrics and status
- Application Instance resource utilization, performance, and status metrics
- Application Instance event logs, showing state changes and other Application Instance events
- Distributed Matching Engine (DME) metrics, including location-based metrics for remote users

## Metrics Reference

The following table provides a list of metrics and their details for each cluster, application instance, and cloudlets. Head over to the [mcctl Utility Reference](/developer/tools/mcctl-guides/mcctl-reference) guide for more information on their commands and example usages.

### Cluster metrics 

<table>
<tbody>
<tr>
<td colspan="1" rowspan="1">

**Metric **
</td>
<td colspan="1" rowspan="1">

**Measurement Unit **
</td>
<td colspan="1" rowspan="1">

**Measurement Detail **
</td>
</tr>
<tr>
<td>CPU </td>
<td>Percentage </td>
<td>CPU usage expressed as a percentage of allocated CPU. </td>
</tr>
<tr>
<td>MEM </td>
<td>Percentage </td>
<td>Memory usage expressed as a percentage of allocated Memory. </td>
</tr>
<tr>
<td>DISK </td>
<td>Percentage </td>
<td>Filesystem usage expressed as a percentage of available disk. </td>
</tr>
<tr>
<td>NET </td>
<td>Bytes/Sec </td>
<td>Transmit and Received data expressed as bytes/sec averaged over sixty seconds (60s) </td>
</tr>
<tr>
<td>TCP </td>
<td>Integer </td>
<td>Total number of tcp connections / retransmissions expressed as an integer. </td>
</tr>
<tr>
<td>UDP </td>
<td>Integer </td>
<td>Total number of udp datagrams transmitted and received, plus any errors expressed as an integer. </td>
</tr>
</tbody>
</table>

### Application instances 

<table>
<tbody>
<tr>
<td colspan="1" rowspan="1">

**Metric**
</td>
<td colspan="1" rowspan="1">

**Measurement Unit **
</td>
<td colspan="1" rowspan="1">

**Measurement Detail **
</td>
</tr>
<tr>
<td>CPU </td>
<td>Percentage </td>
<td>CPU usage expressed as a percentage of allocated CPU. </td>
</tr>
<tr>
<td>MEM </td>
<td>Bytes </td>
<td>Memory footprint expressed in Bytes. </td>
</tr>
<tr>
<td>DISK </td>
<td>Bytes </td>
<td>Filesystem usage expressed in Bytes. </td>
</tr>
<tr>
<td>NET </td>
<td>Bytes/Sec </td>
<td>Transmit and Received data expressed as bytes/sec averaged over sixty seconds (60s) </td>
</tr>
<tr>
<td colspan="1" rowspan="1">

Connections per Port 

(Bytes Sent/Received) </td>
<td>Bytes/Sec </td>
<td>Bytes sent/received averaged over sixty seconds (60s). </td>
</tr>
<tr>
<td colspan="1" rowspan="1">

Connections per Port 

(Sessions) </td>
<td>Sessions </td>
<td>Count for accepted, handled, and active sessions. </td>
</tr>
<tr>
<td colspan="1" rowspan="1">

Connections per Port 

(Session Time Histogram) </td>
<td>Connection time in ms. </td>
<td colspan="1" rowspan="1">

Data is reported for: 

- P0 

- P25 
- P50 
- P75 
- P90 
- P95 
- P99 
- P99.5 
- P99.9 
- P100 

<br>
</td>
</tr>
</tbody>
</table>

