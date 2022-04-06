---
title: SDK Release Notes
long_title: MobiledgeX SDK Release Notes
overview_description:
description:
Release Notes for all versions of the MobiledgeX SDKs for Android, iOS, and Unity. Learn about the new features and known issues for each release.

---

**Last Modified:** 07/27/2021

With every release, MobiledgeX endeavors to make our platform more accessible and efficient for developers to build cutting edge applications. We look to our developer community to help inform which features we should prioritize as the MobiledgeX platform continues to advance. If you have any feedback or questions when using our platform, please contact [Vasanth Mohan](mailto:vasanth.mohan@mobiledgex.com) in the [MobiledgeX Slack Community](https://mobiledgexcommunity.slack.com/).

## MobiledgeX SDK 3.0.0

July 27th, 2021

### What’s New

- [MobiledgeX Edge Events](/sdks/edge-events-overview) : Edge Events is a **NEW** feature of the MobiledgeX SDKs that allows you to receive events from MobiledgeX to determine the optimal edge server to connect with for your client device. This can be used in tandem with the [MobiledgeX Monitoring tools](/deployments/monitoring-and-metrics/monitoring-edge-events) to make smarter decision on how to best optimize your application.

- SDKs made available today for iOS and Android devices
- Unity SDK with Edge Events is currently available in beta

</li>
- Updated the MobiledgeX SDK Demo Application with the latest SDK to make it easier to try Edge Events.
- MobiledgeX Services (Computer Vision and Edge Multiplay) now support Github Actions CI/CD and can now be used as references to integrate [MobiledgeX Github Actions](/deployments/ci-cd/github-actions) into your applications CI/CD pipeline.

### Known Issues

If you receive the following error and cannot compile your Unity project, restart Unity.

![](/assets/unity-sdk/metadata_error.png "")

## MobiledgeX SDK 2.4.1 

March 9th, 2021

### What’s New

#### Unity

- **NEW** Add an option to get location based on IP Address instead of GPS.
- On mobile, if a user rejects the Location Permission prompt, a `Location Exception` is thrown.
- Added support for non-cellular devices such as VR Headsets like Oculus Quest.
- Support for multiple connections to different Applications with new MobiledgeXIntegration Constructor
- Local Network permission on iOS is set to false by default to avoid triggering the Local Network permission prompt.

- **NEW** Added option to switch logging between development and production in MobiledgeX Settings

#### Android

- **NEW** API Documentation for the [Android SDKs](https://mobiledgex.github.io/edge-cloud-sdk-android/).
- Fixed: Throwing `RegisterClient` Exception if RegisterClient fails to provide the reasoning behind the failure.
- Added extra Logging for GRPC Exceptions to help debug.

### Known Issues

If you receive the following error and cannot compile your Unity project, restart Unity.

![](/assets/unity-sdk/metadata_error.png "")

## MobiledgeX SDK 2.4.0 

December 10th, 2020

### What’s New

#### Unity

- Added two new scripts for UDP support by the SDK
- [MobiledgeXUDPClient.cs](https://mobiledgex.github.io/unity-samples/class_mobiledge_x_1_1_mobiledge_x_u_d_p_client.html) is a client implementation to simplify handling UDP connections.
- ExampleUDP.cs is an example of how to use MobiledgeXUDPClient.
- Location based on IP address added as an option for FindCloudlet to determine the closest application instance.
- Added a [useSelectedRegionInProduction](https://mobiledgex.github.io/unity-samples/class_mobiledge_x_1_1_mobiledge_x_integration.html#a7c7dc4ff08d287757270a3cdce00c2b6) to enable the Region Override selector in mobile phone builds.
- [DeviceInfoIntegration](https://mobiledgex.github.io/unity-samples/class_mobiledge_x_1_1_device_info_integration.html) added as part of the PlatformIntegration constructor.
- **Join The Community** added to MobiledgeX Menu links to ["MobiledgeX Community" Discord server](https://discord.gg/7jJH5ezeKq).

#### ALL SDKs

- Added a new CreateURI / GetHost function to make it easier to get the Uri from the FindCloudlet Request.
- **LProto.HTTP** Enum has been removed. Please use **LProto.TCP** for SDK methods instead.

#### Samples

- **NEW** Multiplayer Example : EdgeMultiplay provided in the MobieldgeX Menu Sample using Websockets &amp; UDP (EdgeMultiplay), to be found under MobiledgeX Menu (MobiledgeX/Examples).
- **NEW** [Video Example](https://youtu.be/8fGakyNBotg) on how to use Edge Multiplay.
- **NEW** Example of the MobiledgeX [Ping Pong](/sdks/unity-sdk/unity-sdk-sample) sample application using Edge Multiplay.
- **NEW** [Open Source NodeJS Multiplayer Game Server](https://github.com/mobiledgex/edge-mutiplay-node-server) for Edge Multiplay
- [Computer Vision Example](/services/computer-vision/add-comp-vision-unity) updated to support 2.4 SDK and includes more supported Servers.
- Open Source [Magic Leap Sample](https://github.com/mobiledgex/edge-cloud-sampleapps/tree/master/unity/MagicLeapFaceDetectionPOC) connecting to the MobiledgeX Computer Vision Server

#### Documention

- **NEW** API Documentation for the [Unity SDK](https://mobiledgex.github.io/unity-samples/index.html)
- **NEW** API Documentation for the [C# SDK](https://api.mobiledgex.net/swagger/mexdemo/edge-cloud-sdk-csharp/html/index.html)
- **NEW** API Documentation for [Unity Edge Multiplay](https://mobiledgex.github.io/edge-multiplay-unity-client/)
- [How to Stress Test an Application Instance on MobiledgeX](/design/how-to-stress-test)

### Known Issues

If you receive the following error and cannot compile your Unity project, restart Unity.

![](/assets/unity-sdk/metadata_error.png "")

## MobiledgeX SDK 2.1.3 

September 24th, 2020

### What’s New

#### Unity

- SDK Version displayed in MobiledgeX Editor Window.
- You can use fallback location in production, if your device doesn’t support Location Services use mobiledgeXIntegration.useFallBackLocation = true.
- ComputerVision Example added to the SDK.
- Optional region selection to connect to an app instance in a specific region (works in Unity Editor Only).
- Easier support for Magic Leap and non-mobile devies.

#### Android

- Added a log message to clarify that the SDK can only be used after granting location permissions and then calling MatchingEngine.setMatchingEngineLocationAllowed(true).

#### ALL

- LProto.UDP has been fixed and now returns the correct mapped UDP Port.

#### Computer Vision

- Deployed GPU specific Computer Vision app instances with the App Name ComputerVision-GPU for Object and Pose Detection

### Known Issues

If you receive the following error and cannot compile your Unity project, restart Unity.

![](/assets/unity-sdk/metadata_error.png "")

## MobiledgeX SDK 2.1.2 

July 21st, 2020

### What’s New

#### Unity

- Added .NET 4.x support for the SDK.
- Added a Remove Function to the SDK Menu to make it easy to uninstall our SDK and upgrade to a newer version.
- Added an optional authentication token field to the MobiledgeXSettings asset.
- For iOS Builds, added a fallback on to the wifi dme when on a roaming network. This is because iOS does not provide information about the roaming carrier network.
- Added an EnsureLocation function to LocationServices. If you are using Location Services, please wait on this function for your app to get valid GPS location data from your device.
- Renamed MobiledgeXSocketClient to MobiledgeXWebsocketClient
- MobiledgeXWebsocketClient now sends Binary instead of Text

#### iOS

- Added a fallback on to the wifi dme when on a roaming network. This is because iOS does not provide information about the roaming carrier network.
- Renamed getHTTPConnection to getHTTPClient

#### Bug Fixes

- Fixed an issue where the Unity SDK passed the wrong carrier name when searching for any carrier in Find Cloudlet
- Fixed an issue where Find Cloudlet Performance mode was not returning location data

### Upgrade From 2.1.0

#### Unity

In order to upgrade to the latest version of the SDK, you will need to do the following:

- Delete the following files &amp; folders from the Assets folder of the project. In future updates, you can use the new Remove menu function instead.


- Assets/link.xml
- *Assets/Plugins/MobiledgeX/*
- Assets/Resources/MobiledgeXSettings.asset

![](/assets/release-notes/upgrade-delete-step.png "")


- Re-add the Unity Git Package to your project by going to the Unity Package Manager and re-inputting the [Git URL](https://github.com/mobiledgex/edge-cloud-sdk-unity.git). For more detailed instructions on this procedure, take a look at the [Unity SDK guide](/sdks/unity-sdk/unity-sdk-download).


### Documentation

**New** Guides Have Been Added on how to use the **mcctl** tool:

- How to use the mcctl utility for Developers
- mcctl utility Reference Guide


* The Ping Pong tutorial was updated to use the latest version the Unity SDK

### Known Issues

If you receive the following error and cannot compile your Unity project, restart Unity.

![](/assets/unity-sdk/metadata_error.png "")

## MobiledgeX SDK 2.1.0

June 17th, 2020

### Upgrade  

#### Android

In your application build.gradle project file, please update the following lines with the correct version number so that the new MobiledgeX libraries can be downloaded. Click **sync gradle file** if prompted by the Android Studio IDE in order to start the upgrade.

```
dependencies {
   // ...
   implementation "com.mobiledgex:matchingengine:2.1.0"
   implementation ’com.mobiledgex:mel:1.0.11’

}
```

Additionally, the following functions have changed and you will need to update your app appropriately:

* The retrieveNetworkCarrierName function has been renamed to GetCarrierName to be consistent across all our SDKs.

#### Unity

In order to upgrade to the latest version of the SDK, you will need to do the following:

1. Delete the following files &amp; folders from the Assets folder of the project. In future updates, we plan to automatically delete these for you.

- Assets/link.xml
- Assets/Plugins/MobiledgeX/
- Assets/Resources/MobiledgeXSettings.asset

![](/assets/release-notes/upgrade-delete-step.png "")

2. Re-add the Unity Git Package to your project by going to the Unity Package Manager and re-inputting the [Git URL](https://github.com/mobiledgex/edge-cloud-sdk-unity.git). For more detailed instructions on this procedure, take a look at the [Unity SDK guide](/sdks/unity-sdk/unity-sdk-download).

Additionally, a few function names have changed on the **MobiledgeXIntegration** class. If you were using any of the following functions, here is what you need to update:

- **Major:** FindCloudlet now returns a bool instead of the FindCloudletReply.
- **Major** : GetLocationFromDevice is now a private function. If you need to get Location data, please use the Location Services class.
- **Major** : GetWebsocketConnection no longer calls RegisterAndFindcloudlet on behalf of developers. You will now need to call that function first, followed by calling the newly added GetAppPort function in order to use GetWebsocketConnection.
- **Major** : The GetURI function has now been renamed to GetURL. GetURL now returns an L7 url as a string, given an L7 protocol i.e. http, https, ws, etc.
-  **Minor: The useWifiOnly function has now been renamed to UseWifiOnly
-  **Minor : The function IsEdgeEnabled is now a private function.

### New Features  

- FindCloudlet now has an optional parameter called FindCloudletMode, which is an enum that supports two modes: Proximity and Performance. By default, FindCloudlet will use Proximity, which will return the same App Instance that is served via the DME. In Performance mode, the SDK will test all App Instances on a cloudlet and return back the App Instance with the lowest latency.
- New public functions for all SDKs on the Matching Engine Class : **getHost(FindCloudletReply, AppPort)** &amp; **getPort(AppPort)**. Together, both functions can be used to create the URI for the application instance returned via FindCloudlet.
- For **Unity only**, the SDK automatically fills in the App Name in the MobiledgeXSettings Window based on the Application Name in your Unity Project. If the App Name you deployed to MobiledgeX does not match the Application Name of your Unity project, please update the App Name in the MobiledgeXSettings Window to match the App Name that has been deployed to MobiledgeX.

### Documentation

- New Guide documenting the API of Computer Vision Sample Application. Useful if you want to deploy the [open source Computer Vision server](https://github.com/mobiledgex/edge-cloud-sampleapps/tree/master/FaceDetectionServer) to one of the MobiledgeX cloudlets and connect to it with a client app.
- The Unity Ping Pong Sample Application has been updated to use the 2.1 Unity SDK and new import procedure. We have also updated the Ping Pong Guide to walk you through how to setup the Unity SDK using the package manager.

### Known Issues

If you receive the following error and cannot compile your Unity project, restart Unity.

![](/assets/unity-sdk/metadata_error.png "")

#### iOS

On iOS, if you are on a roaming network, the MCCMNC the SDK returns is the MCCMNC of your original network instead of the MCCMNC of your current roaming network, which is not the intended behavior.

## MobiledgeX SDK 2.0.0

May 5th, 2020

### Upgrade

If you were using an older version of any of the SDKs, follow the instructions on our [SDK &amp; Libraries](/sdks) page for the specific platform and download the latest release, then upgrade your project.

**Recommendations:**

- **Android:** Use the createDefault&lt;API&gt;Request, which has the majority of the defaults set via the Builder API. API refers to the functions listed below.
- **Swift, Unity, C#:** Optional parameters are now included in the APIs. Named parameters are available if a parameter is included in the create request for thing such as AuthToken, Tags, Cell ID, etc. A list of all optional parameters can be found on our API documentation.
- **Unity:** Re-download the [Integrations scripts](https://github.com/vmohanx/edge-cloud-sampleapps/tree/master/unity/PingPongGameExample/PingPongGame/Assets/Scripts/Integration) from the edge cloud sample apps if you were using them prior to this release.

### New Features  

The following functions are provided by our SDKS Android, Unity, iOS to connect to a deployed cloudlet. Please refer to our API documentation for API examples used within each SDK.
| Function           | Description                                                                                                                                                                                                                                                                                                                                    | What’s New                                                                                                                                                                                                                                                                                                       |
|--------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| RegisterClient     | Registers the client with the closest Distributed Matching Engine (the nearest edge location in the Operator network) and validates the legitimacy of the mobile subscriber. All session information is encrypted.                                                                                                                             |  All SDKs: parameter **dev_name** **has **been **renamed *to **org_*name**. All SDKs: carrier_name has been removed as a parameter                                                                                                                                                                               |
| FindCloudlet       | Locates the most optimal edge computing footprint and allows the registered application to find the application backend by leveraging location, application subscription, and service provider agreement. If there are no suitable cloudlet instances available, the client may connect to the application server located in the public cloud. |  All SDKs: Added a performance test to return the most suitable cloudlet based on network latency.  All SDKs: Added “wifi“ as a potential value for carrier_name in order to connect to a clouldet without a cellular connection. All SDKs: *appname, app*version, and *org_name* parameters are no longer used. |
| VerifyLocation     | Verifies that the GPS coordinates accurately report the actual location of the device.                                                                                                                                                                                                                                                         | N/A                                                                                                                                                                                                                                                                                                              |
| GetConnection      | Function that gets a “connection” object (depending on Protocol of specified connection and language) bound to the cellular interface and connected to the application backend.                                                                                                                                                                | Unity: Patched GetHTTPConnection to connect to the correct URL                                                                                                                                                                                                                                                   |
| PerformanceMetrics | Performance Metrics API tracks the average latency of the edge network for your application server’s Application Instance.                                                                                                                                                                                                                     | All SDKs: NetTest now has direct testing options if it is desired to run outside FindCloudlet.                                                                                                                                                                                                                   |

### Documentation  

New Workflow Tutorial added using GitHub Actions to deploy Docker applications to the MobiledgeX Edge-Cloud Console.

### Known Issues

There are no known issues documented at this time.

