---
title: "Best Practices : Sizing Applications"
long_title: 
overview_description: 
description: 
Some tips and tricks for sizing your application instances on MobiledgeX before deploying on cloudlets

---

**Last Updated: 08/19/2021**

This document provides guidance for estimating resource requirements for most common edge use cases. Given the variety of application configuration needs, it’s important to size your application’s backend appropriately to avoid overestimating your potential load which can result in consuming underutilized resources, and limits the available resources on the cloudlet(s). Further, underestimating your load may cause a degradation in the end user experience. 

The below table provides a recommended baseline on resource consumption needs. While there may be additional factors that can change vertical and/or horizontal scaling considerations for application instances, we feel that the following recommendations can help you size your backend needs to reduce the potential for application performance degradation and maximize utilization of available resources.
<table>
<tbody>
<tr>
<th>Application Edge Use Case</th>
<th>Middleware Technology</th>
<th>Resource Consumption</th>
</tr>
<tr>
<td>Low Latency Synchronization</td>
<td>Photon PUN / WebRTC / Edge Multiplay</td>
<td>Low vCPU Consumption Per 100s of Users</td>
</tr>
<tr>
<td>AI / Computer Vision</td>
<td>Pytorch / TensorFlow / OpenCV</td>
<td>Medium GPU Consumption Per 10s of IOT Devices</td>
</tr>
<tr>
<td colspan="1" rowspan="1">

Remote Rendering 

(Cloud Gaming &amp; CloudXR )</td>
<td>WebRTC / OpenXR / Unity / Unreal</td>
<td>High GPU Consumption per User</td>
</tr>
<tr>
<td>Video Streaming &amp; Analytics</td>
<td>FFMPEG / WebRTC</td>
<td>Use Case Dependent</td>
</tr>
</tbody>
</table>

As a general recommendation, we encourage developers to start with the smallest resource that they think they need and then while testing and validating their application, if performance issues are noticed while load testing, then consider **vertically** and/or **horizontally** scaling your application instances.

## Load Estimation

These questions will help provide the data necessary to start the benchmarking:

- What is your expected average number of concurrently connected users?
- What is your expected max concurrently connected users count?
- How long does it take a copy of your application to become available for traffic?

For example, the developers of **Application X** expect an average of 200 Concurrent Users (CCU) at any given time, a potential max of 800, and they have an application that takes roughly 2 minutes to initialize and begin to serve traffic. Once you have determined a load estimate, you can then attempt to [stress test](/developer/design/how-to-stress-test) your application to determine if you need to scale and how you would like to scale.

## Monitoring

While stress testing your applications based on your Load Estimates, you can leverage the MobiledgeX [Monitoring](/developer/deployments/monitoring-and-metrics) tools to help make informed decision about when it is necessary to scale our your applications. As shown in the diagram below, you can simply select a deployed application instance and then check the performance of the instance across various compute metrics such as CPU, Memory, Disk Utilization, etc. Based on the values you are noticing, you may then update your application instances accordingly based on the recommendations in the following sections. 
![MobiledgeX Monitoring](/developer/assets/monitoring/monitoring-3.0-screen.png "MobiledgeX Monitoring")

## Vertical Scaling

Vertical Scaling refers to the process of adding additional compute resources to your application. In the context of MobiledgeX, this means updating your application to take advantage of a larger compute [flavor](/developer/deployments/deployment-workflow/flavors). For example, if you notice in your application monitoring that the CPU utilization is exceeding an expected threshold like 70%, then you might consider switching to a flavor that has more vCPUs allocated to it. Specifically, if your application was using a m4.medium flavor with 2 vCPUs allocated, then you might want to consider upgrading to an m4.large flavor with 4 vCPUs allocated to your application instances. 
## Horizontal Scaling

Horizontal Scaling refers to the process of adding additional application instances to your application. MobiledgeX offers [auto-provisioning](/developer/deployments/application-runtime/auto-prov) and [auto-scaling](/developer/deployments/application-runtime/autoscale) policies. Auto-Provisioning Policies are avaliable for application types and allow you to deploy new instances to nearby cloudlets.  Auto-Scale Policies are avaliable for Kubernetes and Helm based applications and allow you to define when to scale up or down your application instance based on demand on the same cloudlet. Refer to the respective guide to learn how to setup these policies for your application. 

