---
title: C# Download Instructions
long_title: C# SDK
overview_description:
description:
Download the Matching Engine C# SDK to create applications for your device

---

**Last Modified:** 11/23/21

The MobiledgeX Client Library enables an application to register and then locate the nearest edge cloudlet backend server for use. The client library also allows verification of a device’s location for all location-specific tasks. Because these APIs involve networking, most functions will run asynchronously, and in a background thread.

The Matching Engine C# SDK provides everything required to create applications for your devices.

**Note:** If you are want to develop Apps using Unity, please see the Unity C# SDK documentation, [here](/developer/sdks/unity-sdk/unity-sdk-download/index.md).

## Prerequisites

- Visual Studio Community 8.4 or later.
- .Net Standard 2.0
- Nuget
- A running AppInst on your edge server
- An Android or iOS device to test with
- A SIM card from a supported carrier for initial application development is recommended; alternatively, if a supported carrier is not available, Wifi may be utilized

## Download the C# SDK and libraries

Step 1: Create a login and an Organization on the [Console](https://console.mobiledgex.net/). The creation of a login will automatically generate a user account and allows for access to [Artifactory](https://artifactory.mobiledgex.net/), giving you access to the C# Nuget repository.

**Note:** With a login, you can download the C# SDK library as well as upload a server image to install on the edge network.

Step 2: Access the C# MatchingEngine library using Nuget.

Step 2a: Type `nuget sources Add -Name MobiledgeX -Source https://artifactory.mobiledgex.net/artifactory/api/nuget/nuget-releases -username &lt;yourUserName&gt; -password &lt;yourPassword&gt;` .

Step 2b: Type `nuget list -Source "MobiledgeX"`.

Step 2c: Type `nuget install MobiledgeX.MatchingEngineSDKRestLibrary `. This will retrieve the latest version automatically.

Step 3: Locate the pre-extracted MatchingEngineSDKRestLibrary.dll file in the home directory.

```
~/.nuget/packages/mobiledgex.matchingenginesdkrestlibrary
cd ~/.nuget/packages/mobiledgex.matchingenginesdkrestlibrary/&lt;newest_version&gt;/lib/netstandard2.0/
cp MatchingEngineSDKRestLibrary.dll &lt;unity project&gt;/developer/assets/Plugins

```

## Optional Step

If you prefer to add the Nuget package using the Visual Studio Community IDE instead, follow these steps.

Step 1: Right-click on your project dependencies folder.

Step 2: Select **Manage Nuget Packages**.

Step 3: Add the same source repository provided in Step 2 above.

Step 4: Select the most recent library version.

## Where to Go from Here

Access the MobiledgeX C# Library for examples and sample code, [here](https://api.mobiledgex.net/swagger/mexdemo/edge-cloud-sdk-csharp/html/index.html).

