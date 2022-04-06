---
title: Unity Sample App
long_title: Add Edge Support to Unity Ping Pong
overview_description:
description:
Learn the potential benefits for low latency in a real-time application on an edge cloudlet server

---

**Last Modified:** 7/15/2021

The MobiledgeX Ping Pong application demonstrates how to integrate the MobiledgeX SDK as well as Edge Multiplay service into a Unity game or app. For this specific guide, we will be focusing on the MobiledgeX Unity SDK Integration. Please refer to the [Edge Multiplay Service](/services/unity-edgemultiplay) guides if you are interested in integrating Edge Multiplay into your Unity multiplayer games.

## Prerequisites

-  Basic development experience with Unity and C#.
-  Unity installation, with Desktop. Mobile Device (iOS &amp; Android) are recommended.
- Install Unity Hub [here](https://store.unity.com/download?ref=personal). Use version 2019.4 LTS, or the latest version available)
- Access the [MobiledgeX Unity SDK GitHub](https://github.com/mobiledgex/edge-cloud-sdk-unity) repo
- Git version control management on the command line.

## About the Ping Pong Application

This Ping Pong Game is built in Unity and is provided as a sample as reference to learn how to integrate Edge Multiplay. Edge Multiplay is an open source MobiledgeX Service that faciltates Multiplayer connectvity between players. The Edge Multiplay server is a dockerized websocket service written in NodeJS that is responsible for relaying messages between clients in real-time. The low latency of the edge allows for faster communication between players on a cellular network, which opens opportunities for more reliable real time gaming.

Edge Multiplay is deployed on operator networks around the world. As such in this guide, we will not be focused on the deployments, but instead focused on how to find the closest instance of Edge Multiplay through the MobiledgeX Unity SDK that we can use for the Unity Ping Pong application.

![Ping Pong Demo](/assets/adding-mobiledgeX-matchingengine-sdk-to-unity-ping-pong-demo-app/1.jpg "Ping Pong Demo")

## Step 1: Import the MobiledgeX Unity SDK

From any Unity project, you can import the MobiledgeX Unity SDK via the Package Manager. You can open it from *Window &gt; Package Manager* in Unity. To add our MobiledgeX Package, select the **+** icon and click on **“Add package from git URL…”**

![Package Manager](/assets/unity-sdk/add-git-url.png "Package Manager")

Enter `https://github.com/mobiledgex/edge-cloud-sdk-unity.git` in the text field, which will automatically start the process of importing the package into your application.

Once that completes, you will see the MobiledgeX SDK within your Package Manager and the SDK will be available under the Packages tab of your Project.

![MobiledgeX Unity Package](/assets/unity-sdk/mobiledgex-package.png "MobiledgeX Unity Package")

## Step 2: Setup Edge Multiplay

Once the MobiledgeX SDK has finished installing, there will now be a new **MobiledgeX Menu**. From the MobiledgeX Menu **Import EdgeMultiplay**, select `MobiledgeX/Examples/EdgeMultiplay`

To test Edge Multiplay, we have provided an example implementation of Ping Pong with Edge Multiplay. Under the EdgeMultiplay menu, click `Examples/PingPong`, which will begin importing the Edge Multiplay

![Edge Multiplay Import](/assets/edgemultiplay/PingPongEdgeMultiplayMenu.png "Edge Multiplay Import")

Once the import finishes, you will now have PingPongGame as a folder under your Assets. Under PingPongGame/Scenes, there will be a `PingPongScene`, which you may open.

## Step 3: Connecting to Edge Multiplay Servers

To test this Ping Pong game, you will need to connect to an instance of the Edge Multiplay servers. We have provided a set of sample servers available to connect with based on the credentials below.

- **Organization Name** : `MobiledgeX-Samples`
- **App Name** : `EdgeMultiplay`
- **App Version** : `1.3`

To use these credentials, using the MobiledgeX Menu go to `MobiledgeX/Setup`, which will open a Unity window for inputting the credentials. Once you have entered the credentials above, you will need to click Setup, which will register and make sure the credentials above are valid on the MobiledgeX platform.

![MobiledgeX Setup Window](/assets/unity-sdk/mobiledgex-menu.png "MobiledgeX Setup Window")

If this is successfully, you may now **Run** the Ping Pong scene.

If you see the following text, you have successfully connected to an instance of the server. To play the Ping Pong Sample, you will need to **Build and Run** another instance of the client.

![Connect to Ping Pong](/assets/edgemultiplay/pingpongtext.png "Connect to Ping Pong")

## MobiledgeX SDK Integration

For the rest of this guide, we will be breaking down how Edge Multiplay integrates with the MobiledgeX Unity SDK and highlighting the key areas of the code base to understand how the SDK works. We will show how to use the MobiledgeX Distributed Matching Engine APIs to register the user and find the optimal edge data center (cloudlet) running the app. To learn more about the workflow, you may refer to the [SDK Technical Overview Documentation](/sdks/tech-overview).

We will be showing the implementation for the following:

**RegisterClient()** - Identifies the user (Organization Name) and application details (appName and appVersion), and allows the usage of MobiledgeX integration.

**FindCloudlet()** - Returns the edge application server to communicate with, in the form of an AppPort list that needs to be parsed to retrieve your particular application’s server details. Either TCP or UDP transport. A cloudlet is a small-scale cloud datacenter.

### Edge Manager

All the integration code responsible for leveraging the Unity SDK is included with the EdgeMultiplay Edge Manager script. This script is located in `Assets/EdgeMultiplay/Scripts/EdgeManager.cs`.

As part of the Monobehavior callbacks, in the [Awake](https://github.com/mobiledgex/edge-multiplay-unity-client/blob/main/EdgeMultiplay/Scripts/EdgeManager.cs#L127) function, we first create the MobiledgeXIntegration object, which is responsible for communicating with the MobiledgeX Distributed Matching Engine APIs.

```
integration = new MobiledgeXIntegration();
```

Using an empty constructor,  MobiledgeXIntegration will use the application credentials provided above in the Setup Windows. If you would like to override the Setup window, you may do so by providing the parameters to the constructure as shown in the example below.

```
integration = new MobiledgeXIntegration(orgName, appName, appVers);
```

With an integration object created, we can use it to begin making API calls to MobiledgeX.

### Connect To Server

In the static [ConnectToServer](https://github.com/mobiledgex/edge-multiplay-unity-client/blob/f9160cdcf2f2e40cfe9931211ba134e38817ff01/EdgeMultiplay/Scripts/EdgeManager.cs#L190) function, Edge Multiplay then begins the process of establishing a connection using the MobiledgeX APIs to determine the closest application instance and then establish a connection with that server.

Below is the relevant code ([Github reference](https://github.com/mobiledgex/edge-multiplay-unity-client/blob/f9160cdcf2f2e40cfe9931211ba134e38817ff01/EdgeMultiplay/Scripts/EdgeManager.cs#L215-L238)) from Edge Multiplay responsible for handling the MobiledgeX APIs

```
integration.UseWifiOnly(useAnyCarrierNetwork);
integration.useFallbackLocation = useFallBackLocation;
wsClient = new MobiledgeXWebSocketClient();
await integration.RegisterAndFindCloudlet();
integration.GetAppPort(LProto.LPROTOTCP);
string url = integration.GetUrl("ws") + path;
```

Breaking this down by line, the first two lines are responsible for setting default parameters for the SDK. Specifically, the UseWifiOnly parameter specifies whether to connect with our regional APIs or a specific carrier based on the SIM card your phone is using. By leveraging the cellular APIs, you will tend to see signficantly reduced latency; however if a user is using a cell connection not supported by MobiledgeX, then it is recommened to use the regional APIs by setting `UseWifiOnly` to true.

The `useFallbackLocation` paramter similarly specifies a default location to use if the SDK is unable to determine the location of the device. Location is a required parameter in order to determine the closest server to the user and we will look more closely at the `Location Service` provided with the SDK later in this guide.

### Register Client and Find Cloudlet

The next integration method that is used is `integration.RegisterAndFindCloudlet()`. This function combines both APIs mentioned above into a single function that will need to be called. Because this is a network call to the MobiledgeX APIs, it takes some time before an answer is returned and this is required to be made asynchronously.

If desired, you may call Register Client and Find Cloudlet separately. Find Cloudlet is particularly relevant to call multiple times in your application lifetime since users might move to a different location that is closer to a different cloudlet. Knowing when to call Find Cloudlet can be determined using [Edge Events](/sdks/edge-events-overview).

```
await integration.RegisterClient(); //registers the device with the MobiledgeX APIs based on the Setup
```

```
await integration.FindCloudlet(); //finds the closests application instance
```

### Establish Connection

If `RegisterAndFindCloudlet` is successful, MobiledgeXIntegration will have stored FindCloudletReply, which contains information about your backend server: *Full Qualified Domain Name*, *Port Mappings*, etc.

Depending on how you configured your application, you may now have all the information you need to access your application. However if you used a [Shared Load Balancer](/design/load-balancing) for your application, it is possible that the ports may have been mapped differently than what you may have assigned when creating your application. As such, it is generally recommended to call the `GetAppPort` function to determine what your port has been mapped to.

**Note:** Edge Mulitplay only has one TCP port exposed, so we did not specify a port number since `GetAppPort` grabs the first AppPort it finds. If you have multiple ports, you must specify the port number and protocol specific to the connection you want. This allows you to create as many connections as needed.

```
appPort = integration.GetAppPort(LProto.L_PROTO_UDP, 5555)
```

With the port mappings determined, we can then get the URL necessary to connect to the actual server. In this case for Edge Multiplay, we want to establish a Websocket connection to the server, so we specify the "ws" prefix to be used to connect with. Now that you have the URL to connect to, you can begin communicating with that server for your application.

### Location Service

At the top of the Edge Manager ([Github Reference](https://github.com/mobiledgex/edge-multiplay-unity-client/blob/f9160cdcf2f2e40cfe9931211ba134e38817ff01/EdgeMultiplay/Scripts/EdgeManager.cs#L34)), you may have noticed that the Edge Manager component requires the Location Services component to be added to the Game Object.

The LocationService class provides developers easy functions to request permissions, and grab Location objects ready to be used in other MobiledgeX functions. MobiledgeXIntegration functions use this class to grab GPS location data to find the nearest cloudlet.

```
 yield return StartCoroutine(MobiledgeX.LocationService.EnsureLocation());

```

The above code requests location permissions from the user and waits until LocationService is running before moving on.

**Note:** MobiledgeX.LocationService uses the device Location once during the application lifetime. This is specifically used within the **Find Cloudlet** function and **Edge Events** to find the closest cloudlet to the user.

