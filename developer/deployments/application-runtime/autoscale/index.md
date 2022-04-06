---
title: Auto Scaling with Kubernetes
long_title:
overview_description:
description:
Learn how to auto scale your Kubernetes (K8s) edge applications using MobiledgeX auto scale policies

---

**Last Modified:** 11/18/2021

## Auto Scale Policy  

The auto scale policy governs scaling up or down the number of nodes of a Kubernetes cluster to provide more or fewer compute resources respectively for your application. By optionally defining the target CPU load, Memory load, and/or number of Active Connections, the auto scale policy will automatically add or remove nodes within the Kubernetes cluster so that the average value per node is approximately equal to the target. Once the auto scale policy is created, it can be referenced when creating a new cluster from the cluster instance page.

![Add Auto Scale Policy to Cluster](/assets/auto-scale-policy/auto-scale-cluster.png "Add Auto Scale Policy to Cluster")

When creating a Kubernetes App Definition, under Advanced Settings, **ScaleWithCluster** should be set to **true** to have Kubernetes scale your app across all nodes within the cluster. Otherwise, your app will only run on one node in the cluster. As a result of that,  auto scale will not trigger, and you won’t be unable to take advantage of an auto scaled cluster.

**Note:** Auto scale only supports Kubernetes deployments at this time.

## Create An Auto Scale Policy

1. Select **Policies** from the left navigation, and select **Auto Scale Policy** from the dropdown menu. The Auto Scale Policy page opens.

2. Select the plus sign icon in the top right corner.

3. From the Create Auto Scale Policy screen, enter all required fields.

- For the **
**Minimum Nodes**, set the minimum number of cluster nodes for your application
- For the **
**Maximum Nodes**, set the maximum number of cluster nodes for your application
- For **
**Stabilization Window**, enter the time, in seconds, that the monitored field should be sampled before triggering an auto-scale action. Setting larger values helps to stabilize scaling, while smaller values will allow your application to be more responsive to traffic.

4. Enter the parameter(s) you would like your application to scale on. You must choose to use at least one parameter from this list. In other words, at least one value must be **non-zero**.

- **Target CPU:** The target average CPU load per node to maintain. Set to 0 to be disabled.
- **Target Memory:** The target average memory utilization load per node to maintain. Set to 0 to be disabled.
- **Target Active Connections:** The target number of active TCP connections per node to maintain. Set to 0 to be disabled.


- Once you have populated all required or relevant fields, select the **Create Policy** button at the bottom of the page.


![Auto-Scale Policy](/assets/auto-scale-policy/add-autoscale-policy.png "Auto-Scale Policy")

## Attach an Auto Scale Policy to a Kubernetes Cluster

There are two methods of attaching an auto scale policy to a Kubernetes cluster, by either creating a new cluster or updating an existing Kubernetes cluster.

- Select **Cluster Instances** in the Console left navigation.
- Select the plus sign icon in the top right to create a new Cluster Instance. Or, select the Actions icon of an existing Kubernetes cluster instance, and select **Update** from the dropdown menu.
- In the Deployment Type text box dropdown, select **Kubernetes**.
- In the Auto Scale Policy text box dropdown, select the Auto Scale Policy you just created.


![](/assets/autoscalecluster.png "")


- Select **Create** or **Update** at the bottom of the page.


