---
title: Unity Edge Events (Beta)
long_title:
overview_description:
description:
Learn how to integrate Edge Events into your Unity applications and games.

---

Edge Events allows your Unity app to continuously send and get updates from MobiledgeX in order for our platform to determine if there is a more suitable cloudlet for your client to connect to. To simplify integration, the Unity SDK provides a Default Configuration method that you may utilize, that sets parameters for when your app would like to switch to a different cloudlet. To learn more about Edge Events, refer to your guide on [Maintaining Optimal Connectivity to the Edge](https://dev-stage.mobiledgex.com/sdks/edge-events-overview).

These continuous events are sent through a [GRPC](https://grpc.io/) bi-directional network connection as opposed to our REST APIs. However, current GRPC plugin support within Unity is currently experimental and as such, we offer the Edge Events feature in beta. This guide will show you how to integrate the GRPC version of the MobiledgeX Unity SDK into your application to start experimenting with Edge Events.

## Installation


- First download and unzip the GRPC experimental plugin from GRPC website: [GRPC Plugin 2.26.0](https://packages.grpc.io/archive/2019/11/6950e15882f28e43685e948a7e5227bfcef398cd-6d642d6c-a6fc-4897-a612-62b0a3c9026b/csharp/grpc_unity_package.2.26.0-dev.zip).
- Once you unzip it, drag and drop the `Plugins` into your Unity project.
- From the Unity package manager, select the plus sign icon and then choose `Add package from git URL...` and paste the following link, which imports the Unity SDK from the edge-events branch: [https://github.com/mobiledgex/edge-cloud-sdk-unity.git#edge-events](https://github.com/mobiledgex/edge-cloud-sdk-unity.git#edge-events)


![Add Package from Git](/developer/assets/add-comp-vision-unity/add-package-git.png "Add Package from Git")

## Setup


- From the menu, select **MobiledgeX &gt; Setup**.
- Enter the credentials specific to your application that has been deployed to the edge via the MobiledgX Console. For testing purpose, you may use any of the credentials associated with the MobiledgeX Samples.
- Then select **Setup**. On MacOS, this will trigger a security warning that the GRPC DLL is not signed. This warning will not be triggered on Windows.


![GRPC Warning](/developer/assets/unity-edge-events/grpc-warning.png "GRPC Warning")


- After this security warning is triggered, you will need to head into MacOS secruity settings and select **Allow Anyway** for the `grcp_csharp_ext.bundle`.


![MacOS Secruity](/developer/assets/unity-edge-events/macos-secruity.png "MacOS Secruity")


- Once the security warning has been resolved, select **Setup** again, which should now succeeded.


## Edge Events Configs

To make using Edge Events simpler, the SDK provides a configuration to make it easier to determine what events and settings you would like to listen to. These configs are located in the MobiledgeX menu under **Edge Event Config**.

![Edge Event Config Menu](/developer/assets/unity-edge-events/edge-events-menu.png "Edge Event Config Menu")

This will open up a menu with the various settings you can use to configure MobiledgeX Edge Events. You can scroll over the tooltips for each event to learn more about the specific event and how you would like to configure them.

![Edge Events Configs](/developer/assets/unity-edge-events/edge-events-configs.png "Edge Events Configs")

To utilize edge events configs, need to add the `EdgeEventsManager` component into your scene. Then when you use MobiledgeXIntegration object, you will be able to pass the EdgeEventsManager component to the Intergration and then listen for when a better suitable cloudlet has been found.

```
mxi = new MobiledgeXIntegration(FindObjectOfType&lt;EdgeEventsManager&gt;());
mxi.NewFindCloudletHandler += HandleFindCloudlet;
```

