---
title: Unity Download Instructions
long_title: Unity SDK
overview_description:
description:
Learn how to use the Matching Engine Unity SDK to create applications for Unity devices

---

**Last Modified:** 11/23/21

The MobiledgeX Client Library enables an application to register and then locate the nearest edge cloudlet backend server for use. The client library also allows verification of a device’s location for all location-specific tasks. Because these APIs involve networking, most functions will run asynchronously, and in a background thread.

The Matching Engine Unity C# SDK provides everything required to create applications for Unity devices.

For documentation on method usage and code snippets, you can refer to our [MobiledgeX Unity SDK Manual](https://mobiledgex.github.io/edge-cloud-sdk-unity).

## Prerequisites  

- Unity 2019.2 or newer, along with selected platforms (iOS, Android) for your project
- The SDK is compatible with (IL2CPP &amp; .NET 2.0) , (IL2CPP &amp; .NET 4.x) , (Mono &amp; .NET 2.0) **but not compatible with (Mono  &amp; .NET 4.x)**
- A running AppInst deployed on your edge server
- Git installed

## Download the Unity SDK Package  

### 2019.3.x and above

The fastest way to import the MobiledgeX Unity SDK into your project is by using the Package Manager. You can open it from *Window &gt; Package Manager* in Unity. To add our MobiledgeX Package, select the **+** icon and select **“Add package from git URL…”**

![Unity: Package Manager](/assets/unity-sdk/add-git-url.png "Unity: Package Manager")

Enter [https://github.com/mobiledgex/edge-cloud-sdk-unity.git](https://github.com/mobiledgex/edge-cloud-sdk-unity.git) in the text field, which will automatically start the process of importing the package into your application.

Once that completes, you will see the MobiledgeX SDK within your Package Manager and the SDK will be available under the Packages tab of your Project.

![Project: Packages tab](/assets/unity-sdk/mobiledgex-package.png "Project: Packages tab")

### 2019.2.x

In order to import the MobiledgeX package into your project, you will need to edit the **manifest.json file**. This file is located at <strong>
*UnityProjectPath/Packages/manifest.json*
</strong>. When opened, the file will be in this format:

```
{
  "dependencies": {
    "com.unity.": "..",
    .
    .
    .
   }

}
```

Under dependencies, add the following : `"com.mobiledgex.sdk": "https://github.com/mobiledgex/edge-cloud-sdk-unity.git"`

When you do, your manifest.json file should look like this (**minor** : do **NOT** include the comma if you add the mobiledgex line to the end of the dependency list):

```
{
  "dependencies": {
    "com.mobiledgex.sdk": "https://github.com/mobiledgex/edge-cloud-sdk-unity.git",
    "com.unity.": "..",
    .
    .
    .
   }

}
```

After you finish editing and save the file, select the Unity editor and it will automatically begin the process of importing the package.

## Using the MobiledgeX SDK

### Setup

Once you have successfully imported the Unity package, you will see a new tab as part of the Unity menu labeled **MobiledgeX**

![Unity menu: MobiledgeX](/assets/unity-sdk/mobiledgex-menu.png "Unity menu: MobiledgeX")

Select **Setup**, which will open a new Unity window asking you for your application’s

- `organization name`
- `app name`
- `app version number`

![Unity menu: Setup](/assets/unity-sdk/mobiledgex-unity-window.png "Unity menu: Setup")

After you provide your application credentials, select the setup button, which will communicate with the DME to verify that your application definition exists on the MobiledgeX console. If successful, your project will be set up with the correct plugins and resources necessary to use our APIs. You can verify if these files were generated correctly by looking in the Plugins and Resources folders of your project.

![Generated Plugins](/assets/unity-sdk/generated-plugins.png "Generated Plugins")

![Generated Resources](/assets/unity-sdk/generated-resources.png "Generated Resources")

![MobiledgeX settings](/assets/unity-sdk/mobiledgex-settings.png "MobiledgeX settings")

**Important:** Make sure your Resources/MobiledgeXSettings.asset file has the correct information for your application.

### Example Usage

Once that setup has been completed, you can very easily call all the necessary API requests to connect to a cloudlet with your application deployed. Here is some example code using the MobiledgeXIntegration class that comes with the package

#### Getting Edge Connection URL

MobiledgeX SDK uses the device Location and [the device’s MCC-MNC ID (if available)](/sdks/tech-overview) to connect you to the closest Edge cloudlet where you application instance is deployed.

If your carrier is not supported yet by MobiledgeX the SDK will throw a RegisterClientException. You can catch this exception and instead use WifiOnly(true) to connect to [the wifi dme](/sdks/tech-overview#distributed-matching-engine), which will connect you to the closest [regional DME](/sdks/tech-overview#distributed-matching-engine).

```
using MobiledgeX;
using DistributedMatchEngine;
using UnityEngine;
using System.Collections;
```

```
[RequireComponent(typeof(MobiledgeX.LocationService))]
public class YourClassName : MonoBehaviour
{
    IEnumerator Start()
    {
        yield return StartCoroutine(MobiledgeX.LocationService.EnsureLocation()); // Location is needed to connect you to the closet edge
        GetEdgeConnection();
    }

```

```
    async void GetEdgeConnection()
    {
        MobiledgeXIntegration mxi = new MobiledgeXIntegration();
        // you can use new MobiledgeXIntegration("orgName","appName","appVers");
        try
        {
            await mxi.RegisterAndFindCloudlet();
        }
        catch (RegisterClientException rce)
        {
            Debug.Log("RegisterClientException: " + rce.Message + "Inner Exception: " + rce.InnerException);
            mxi.UseWifiOnly(true); // use location only to find the app instance
            await mxi.RegisterAndFindCloudlet();
        }
        //FindCloudletException is thrown if there is no app instance in the user region
        catch (FindCloudletException fce)
        {
            Debug.Log("FindCloudletException: " + fce.Message + "Inner Exception: " + fce.InnerException);
            // your fallback logic here
        }
        // LocationException is thrown if the app user rejected location permission
        catch (LocationException locException)
        {
            print("Location Exception: " + locException.Message);
            mxi.useFallbackLocation = true;
            mxi.SetFallbackLocation(-122.4194, 37.7749); //Example only (SF location),In Production you can optionally use:  MobiledgeXIntegration.LocationFromIPAddress location = await MobiledgeXIntegration.GetLocationFromIP();
            await mxi.RegisterAndFindCloudlet();
        }
        mxi.GetAppPort(LProto.LPROTOTCP); // Get the port of the desired protocol
        string url = mxi.GetUrl("http"); // Get the url of the desired protocol
    }

}
```

If your device doesn’t have MCC-MNC ID (no sim card - for ex. Oculus device), Please use UseWifiOnly before RegisterAndFindCloudlet.

```
use mxi.UseWifiOnly(true);
await mxi.RegisterAndFindCloudlet();
```

**In UnityEditor**

While developing in Unity Editor (Location is not used), The fallback location by default is San Jose, CA.

If you wish to change the fallback Location, use SetFallbackLocation() before you call RegisterAndFindCloudlet().

```
 mxi.SetFallbackLocation(testLongtiude, testLatitude);
 await mxi.RegisterAndFindCloudlet();

```

By default in Unity Editor you will connect with the Wifi DME, which is specified using the TestCarrierInfoClass in the CarrierInfoIntegration script.

**Communicating with your Edge Server using REST**

For full example code, Please check [RunTime/Scripts/ExampleRest.cs]([https://github.com/mobiledgex/edge-cloud-sdk-unity/blob/master/Runtime/Scripts/ExampleRest.cs](https://github.com/mobiledgex/edge-cloud-sdk-unity/blob/master/Runtime/Scripts/ExampleRest.cs))

```
 async void GetEdgeConnection()
    {
        MobiledgeXIntegration mxi = new MobiledgeXIntegration();
        await mxi.RegisterAndFindCloudlet();
        mxi.GetAppPort(LProto.LPROTOTCP); // Get the port of the desired protocol
        string url = mxi.GetUrl("http"); // Get the url of the desired protocol
        StartCoroutine(RestExample(url)); // using UnityWebRequest
        RestExampleHttpClient(url); // using HttpClient
    }
 // using UnityWebRequest
 IEnumerator RestExample(string url)
    {
        UnityWebRequest www = UnityWebRequest.Get(url);
        yield return www.SendWebRequest();
        if (www.isHttpError || www.isNetworkError)
        {
           Debug.Log(www.error);
        }
        else
        {
            // Show results as text
            Debug.Log(www.downloadHandler.text);
            // Or retrieve results as binary data
            byte[] results = www.downloadHandler.data;
        }
    }
    // using HttpClient
    async Task&lt;HttpResponseMessage&gt; RestExampleHttpClient(string url)
    {
        HttpClient httpClient = new HttpClient();
        httpClient.BaseAddress = new Uri(url);
        return await httpClient.GetAsync("?q=x"); //makes a get request, "?q=x" is a parameter example
    }

```

**Communicating with your Edge Server using WebSockets**

MobiledgeX Unity Package comes with  WebSocket Implementation (MobiledgeXWebSocketClient).

 For Using MobiledgeXWebSocketClient:

 1. Start the WebSocket

 2. Handle received messages from your Edge server.

 3. Send messages. (Text or Binary)

 For full example code, Please check [RunTime/Scripts/ExampleWebSocket.cs](https://github.com/mobiledgex/edge-cloud-sdk-unity/blob/master/Runtime/Scripts/ExampleWebSocket.cs)

```
async void GetEdgeConnection()
{
    mxi = new MobiledgeXIntegration();
    await mxi.RegisterAndFindCloudlet();
    mxi.GetAppPort(LProto.LPROTOTCP);
    string url = mxi.GetUrl("ws");
    await StartWebSocket(url);
    wsClient.Send("WebSocketMsg");// You can send  Text or Binary messages to the WebSocket Server

}
async Task StartWebSocket(string url)
{
    wsClient = new MobiledgeXWebSocketClient();
    if (wsClient.isOpen())
    {
        wsClient.Dispose();
        wsClient = new MobiledgeXWebSocketClient();
    }
    Uri uri = new Uri(url);
    await wsClient.Connect(uri);

}
 // Handle received messages from your Edge server
 // Using MonoBehaviour callback Update to dequeue Received WebSocket Messages every frame (if there is any)

private void Update()
{
     if (wsClient == null)
     {
         return;
     }
     var cqueue = wsClient.receiveQueue;
     string msg;
     while (cqueue.TryPeek(out msg)
     {
         cqueue.TryDequeue(out msg);
         Debug.Log("WebSocket Received messgae : " + msg);
     }
 }

```

## Location

The MobiledgeX SDK uses a combination of device Location &amp; MCC-MNC codes to connect you to the closest edge data center where your backend is deployed.

The SDK comes with an easy to integrate Location Service Solution (LocationService.cs) that asks for the user’s permission to access the GPS location. LocationService.cs must be added to the Scene in order for the SDK to automatically ask for Location Permission and use the user’s location.

You can find LocationService component in the Unity Editor Inspector.

Select `AddComponent` then select (MobiledgeX/LocationService)

![Location Services Component](/assets/unity-sdk/mobiledgex-unity-location-service.png "Location Services Component")

If the user rejects the Location permission, a `Location Exception` will be thrown. Check ExampleRest.cs for handling location exception example.

Alternatively, here is an example of a different way to get the device’s location :

```
MobiledgeXIntegration mxi = new MobiledgeXIntegration();
mxi.SetFallbackLocation(longtiude, latitude);
// Fallback location is used by default in Unity Editor
// To enable location overloading outside the Editor
mxi.useFallbackLocation = true;
```

## Platform Specific

### Android

The minimum API we support for Android is API Version 24. In your player settings, make sure to set the minimum API to 24, otherwise you will be unable to build your project.

![Example: Android Version error](/assets/unity-sdk/android_version_error.png "Example: Android Version error")

## Known Issues

If you receive the following error and cannot compile your Unity project, restart Unity.

![Example: Metadata error](/assets/unity-sdk/metadata_error.png "Example: Metadata error")

