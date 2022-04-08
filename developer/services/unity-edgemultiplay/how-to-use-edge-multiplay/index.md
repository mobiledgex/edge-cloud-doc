---
title: Getting Started with EdgeMultiplay
long_title: 
overview_description: 
description: 
How To Use the MobiledgeX Unity SDK and EdgeMultiplay Client to build a Multiplayer Game

---

**Last Modified:** 04/02/2021

Edge Multiplay is a solution to make building a multiplayer game in Unity open and transparent, especially for real time games that need lower latency. Have questions or suggestions to make this solution even better? [Join the MobiledgeX Community Discord!](https://discord.gg/VZPu6AvSp5)

The NodeJS Docker Server Code is Avaliable and [Open Sourced on Github](https://github.com/mobiledgex/edge-mutiplay-node-server).

The Unity Client for this Docker Server is also **open source** and integrated with our MobiledgeX SDK. We have provided a few sample servers that are deployed globally on the MobiledgeX Edge-Cloud platform. In this guide, we will walk you through how to setup and connect to these sample servers using the MobiledgeX Unity SDK. For more documentation on the MobiledgeX Edge Multiplay client, please refer to our [API documentation](https://mobiledgex.github.io/edge-multiplay-unity-client/).

<div class="col-xs-12 col-md-10 offset-md-1 col-lg-8 offset-lg-2">
  <div class='embed-container'>
    <iframe src='https://www.youtube.com/embed/8fGakyNBotg' frameborder='0' allowfullscreen>

</iframe>
  </div>

</div>

## Prerequisites

- You will need [Git](https://git-scm.com/download) installed to import the Unity SDK.
- Supported Version of Unity. Please refer to our [Unity SDK documentation](/developer/sdks/unity-sdk/unity-sdk-download/index.md).

## Adding EdgeMultiplay to your Unity project

From a new Unity project, import the MobiledgeX Unity SDK. To do this, open the Package Manager under the Window Menu `Window/Package Manager`.

![Open Unity Package Manager](/developer/assets/edgemultiplay/PackageManager.gif "Open Unity Package Manager")

Next, click the `+` icon and **Import Using Git URL**. Copy and paste this URL : `https://github.com/mobiledgex/edge-cloud-sdk-unity.git`

![Add MobiledgeX Package using git url](/developer/assets/edgemultiplay/add_using_git_unity.gif "Add MobiledgeX Package using git url")

Once the MobiledgeX SDK has finished installing, there will now be a new **MobiledgeX Menu**. From the MobiledgeX Menu **Import EdgeMultiplay**, select `MobiledgeX/Examples/EdgeMultiplay`

![Add EdgeMultiplay from MobiledgeX Menu](/developer/assets/edgemultiplay/EdgeMultiplay_Example.gif "Add EdgeMultiplay from MobiledgeX Menu")

## Connect to EdgeMultiplay Server sample

Once EdgeMultiplay is installed in your Project Assets, we need to provide application credentials to the MobiledgeX SDK to find the closest EdgeMultiplay Server.

From MobiledgeX Menu go to `MobiledgeX/Setup`

![MobiledgeX Menu](/developer/assets/unity-sdk/mobiledgex-menu.png "MobiledgeX Menu")

### Edge Multiplay Credentials

Add the following credentials:

- **Organization Name** : `MobiledgeX-Samples`
- **App Name** : `EdgeMultiplay`
- **App Version** : `1.3`

![EdgeMultiplay Application Definition](/developer/assets/edgemultiplay/EdgeMultiplay-AppDefsv1-1.png "EdgeMultiplay Application Definition")

Then click **Setup**

Now you are all set to connect to an Edge Multiplay Game Server!

## Testing Edge Multiplay with Ping Pong

To test Edge Multiplay, we have provided an example implementation of Ping Pong with Edge Multiplay. In Your Projects folder, under `EdgeMultiplay/Examples`, there is a `PingPongExample.unitypackage` file. Double click it to import that example into your assets.

![Connected to Edge Multiplay Server](/developer/assets/edgemultiplay/PingPongEdgeMultiplayMenu.png "Connected to Edge Multiplay Server")

![Import PingPong to your project](/developer/assets/edgemultiplay/PingPongImportPackage.png "Import PingPong to your project")

Once the import finishes, you will now have PingPongGame as a folder under your Assets. Under PingPongGame/Scenes, there will be a `PingPongScene`. Open that scene and click **Run**.

If you see the following text, you have successfully connected to an instance of the server. To play the Ping Pong Sample, you will need to **Build and Run** another instance of the client.

![Connected to Edge Multiplay Server](/developer/assets/edgemultiplay/pingpongtext.png "Connected to Edge Multiplay Server")

