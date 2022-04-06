---
title: Technical Overview
long_title: MobiledgeX SDK Technical Overview
overview_description:
description:
Learn how our APIs work to connect Client Applications to deployed Application Instances

---

**Last Modified:** 11/3/2021

This guide provides you with a closer look at the MobiledgeX API layer, and how to use our APIs to connect to deployed application instances. The following diagram illustrates the architecture of MobiledgeX’s platform. We will be focusing on the API layer depicted in this diagram. You can find more detailed information about our architecture in our [product overview](https://developers.mobiledgex.com/product/overview) guide.

![](/developer/assets/getting-started/architectural-diagram.png "")

## Why Use the MobiledgeX APIs and SDKs

Once an application instance has been provisioned on the MobiledgeX platform, a URI will be generated for that instance and you can use that URI to connect directly to that application instance. But that is no different from deploying to any public cloud service and as such, just using a URI will not ensure an edge connection. To ensure an edge connection, our APIs are responsible for finding the closest application instance that has been deployed based on a device’s cellular connection and geo-location.

Taking this one step further, our SDKs build on top of our APIs to make it dramatically simpler to find the closest deployed application instance using a few function calls as well as simplifying the process of maintaining an edge connection as a device’s network state or geo-location changes. Moreover, by leveraging the MobiledgeX SDK, it becomes easier to [monitor usage statistics](https://developers.mobiledgex.com/deployments/monitoring-and-metrics) of your application within the MobiledgeX console.

In short, the MobiledgeX APIs and SDKs are responsible for making sure your client application is connected to the best possible application instance to provide an edge connection.

## Distributed Matching Engine

In order to find the closest deployed application instance for your client app, all client apps are required to communicate with a Distributed Matching Engine (DME). Typically, each DME is associated with an operator using their MCC-MNC ID. MCC stands for **Mobile Country Code** and MNC stands for **Mobile Network Code**. The MCC-MNC code cooperatively creates a unique identification for an operator within a country. For reference, this is the full list of MCC-MNCs : [https://www.mcc-mnc.com/](https://www.mcc-mnc.com/)

Each DME is responsible for :

- Maintaining a list of all available application instances on cloudlets with the DME’s associated MCC-MNC or regional identifier.
- Identifying the best available application instance for the client app, based on the client’s provided geo-location.

Our DMEs can be accessed at `https://&lt;mcc-mnc&gt;.dme.mobiledgex.net:38001`. For example, try connecting to `https://262-01.dme.mobiledgex.net:38001` in a web browser. This is the DME responsible for all application instances on cloudlets provided by Deutsche Telekom in Germany. Although you may receive a JSON response returning `Not Implemented`, you have communicated with that DME.

The primary reason MobiledgeX associates each DME with a MCC-MNC is to create a mapping between a device’s cellular network connection and the best cloudlet hosted by an operator to serve the device. From a device’s cellular network connection, it is possible to determine the MCC-MNC of the associated operator in both [Android](https://developer.android.com/reference/android/telephony/TelephonyManager#getCarrierIdFromSimMccMnc()) and [iOS](https://developer.apple.com/documentation/coretelephony/ctcarrier/1620324-mobilenetworkcode). Since most cloudlets are hosted by one of our operator partners, MobiledgeX is able to label each cloudlet with the appropriate MCC-MNC. So, by using the MCC-MNC as a key to pick a DME, the DME can serve app instances that are deployed to cloudlets with the same MCC-MNC. As an example, this means if your phone has a Deutsche Telekom SIM Card for cellular service (MCC-MNC = 262-01) and then communicates with the DME at `https://262-01.dme.mobiledgex.net:38001`, your client app will only be served an application instance hosted by Deutsche Telkom with an MCC-MNC of 262-01. By using this mapping, MobiledgeX creates an edge connection by :

- Returning an application instance from a DME that is geographically close to an end user.
- Minimizing the number of network hops required to reach an application instance hosted by the same cellular operator as the end user.


To minimize latency using MobiledgeX and ensure a fast and stable edge connection, building application for devices with a cellular connection is highly recommended. However, for use cases with devices that do not have a cellular connection and can only connect to the internet with Wifi, MobiledgeX offers regional DMEs, which are responsible for all application instances on cloudlets within a given deployable region like EU, US, or KR. For example, `https://eu-mexdemo.dme.mobiledgex.net:38001/` is responsible for managing application instances and cloudlets deployed to the EU region. To see what cloudlets are associated with a given region, you can check the [cloudlets](https://developers.mobiledgex.com/deployments/deployment-workflow/cloudlets) page within the MobiledgeX console.

To make managing these regions easier, we also provide a WiFi DME (`https://wifi.dme.mobiledgex.net:38001/` ), which will send requests to the closest regional DME. In our SDKs, you can use the `UseWifiOnly(true)` function to send all DME requests to the WiFi DME instead of sending requests to the DME with your device’s associated MCC-MNC.

Whether you are developing an application using our REST APIs or leveraging our available SDKs, you will need to make network requests to the appropriate DME for your client application.

- Using our **REST APIs**, your app will be responsible for selecting the appropriate DME. If your app cannot get MCC-MNC information, we recommend connecting to the Wifi DME.
- Using our **SDKs**, the `MatchingEngine` class will automatically select the appropriate DME based on your device’s cellular MCC-MNC. If your device doesn’t have a cellular connection, please call `UseWifiOnly(true)` on the MatchingEngine.

For our [Android](https://developers.mobiledgex.com/sdks/android-sdk) and [iOS](https://developers.mobiledgex.com/sdks/ios-sdk) SDKs, we recommend using the `MatchingEngine` class. For the [Unity SDK](https://developers.mobiledgex.com/sdks/unity-sdk), we recommend using the `MobiledgeXIntegration` class.

In the next few sections, we will cover the various API requests and the order in which you will use these APIs to make a network request.

## Register Client

After you have selected your DME, or used the `MatchingEngine` class, your first API request is **Register Client**. The `RegisterClient` API registers your client with the nearest DME. You will invoke the HTTP request, `https://&lt;DMEURL&gt;:38001/v1/registerclient`. For a list of parameters that must be supplied to the `RegisterClient` API request, refer to our [API](https://api.mobiledgex.net/#operation/RegisterClient) documentation.

For all of our SDKs, we provide two public methods on the `MatchingEngine` class to make the `RegisterClient` API request.

- `CreateRegisterClientRequest`: This method is responsible for wrapping the parameters you wish to send into a `Request` object used in the next method.


```
RegisterClientRequest rc = dme.CreateRegisterClientRequest(app_name, app_version, org_name);
```


- `RegisterClient`: This method is responsible for making the network request to the DME using the `Request` object created in the previous method. Among the data returned is a session cookie that is needed to make further API requests. You will also receive a status, which notifies you of whether or not your call was successful. As mentioned previously, you may override your selected DME and connect to a different DME. Please allow for some additional time for the data to return from the network request.


```
dme.RegisterClient(rc); //network call
// OR
dme.RegisterClient(DMEURL, DMEPORT, rc); //network call with DME Override
```

`RegisterClient` is primarily used to verify that your application has been created. If the application definition does not exist for your organization, the status will return `RS_FAIL`. If this occurs, provide an [application definition](https://developers.mobiledgex.com/deployments/deployment-workflow/app-definition) for your organization and resend the API request.

## Find Cloudlet

Once you’ve successfully made a `RegisterClient` request and received a session cookie from the DME, you may then use the `FindCloudlet` API to retrieve the domain name of the nearest cloudlet that is running on our Server application. You invoke the HTTP request, `https://&lt;DMEURL&gt;:38001/v1/findcloudet`. For the list of parameters that must be supplied to the `findcloudlet` API request, refer to our [API](https://api.mobiledgex.net/#operation/FindCloudlet) documentation.

We provide two public methods on the `MatchingEngine` class to make the `FindCloudlet` API request for all of our SDKs.

- `CreateFindCloudletRequest`: This method is responsible for wrapping all the parameters you wish to send into a `Request` object that will be used in the next method.


```
FindCloudletRequest fc = dme.CreateFindCloudletRequest(location, session_cookie);
```


- `FindCloudlet`: This method is responsible for making the network request to the DME using the `Request` object created in the previous method. Like `RegisterClient`, you can override your selected DME and connect to a different DME. Take note that it must be the same DME used for `RegisterClient`. Please allow some additional time for the data to return from the network request.


```
dme.FindCloudet(fc); //network call
// OR
FindCloudletReply findCloudletReply = await dme.FindCloudet(DMEURL, DMEPORT, rc); //network call with DME Override
```

The following data is returned, making it possible for you to connect to the nearest cloudlet that is hosting your server side application.

- Fully Qualified Domain Name (FQDN): This is the domain name of the cloudlet hosting your application.
- A list of all available ports provided by the cloudlets for your application.

Once you have successfully made a `FindCloudlet` request, you can now start communicating with your server side application based on the FQDN and ports received, just like you would with any client-server application.

## Get Connection

**Note:** This is available only if you are using our SDKs.

Although not required, we do recommend using our `Get&lt;protocol&gt;Connection` methods, which are found in our `MatchingEngine` class, where `&lt;protocol&gt;` is the type of connection you wish to use, such as **TCP**, **UDP**, **Websocket**, or any other type of protocols. See the [API](https://api.mobiledgex.net/#section/Introduction) documentation for a full list of supported protocols based on the specific SDK you wish to use.

The `GetConnection` methods we provide are responsible for making an optimized connection between the cloudlet and your client application based on the device’s network options. For example, in our Android SDK, if you are on a smartphone that is connected to both Wifi and cellular, the `GetConnection` method will automatically select cellular, allowing a direct connection to the cloudlet, as opposed to going through the internet over Wifi, which will nullify the benefits of the Edge.

Here’s an example. If your server application is a web server, you can connect to it by using `GetHTTPConnection`, as follows:

```
Dictionary&lt;int, AppPort&gt; appportsDict = dme.GetHTTPAppPorts(findCloudletReply);
int public_port = findCloudletReply.ports[0].public_port;
AppPort appPort = appPortDict[public_port];
HTTPClient http = await dme.GetHTTPClient(findCloudletReply, appPort, public_port, 5000);
HTTPResponseMessage message = await http.GetAsync("/");

```

The sample code above is responsible for retrieving a list of all ports returned via the `FindCloudlet` request, which can be used to get an `HTTPClient` object. Because applications may have multiple ports exposed for different purposes, the SDK provides a dictionary that maps port numbers to the `AppPort` objects. These `AppPort` objects contain all the information required for a complete URL and information, such as which protocol the port uses and whether the port is TLS enabled. The specified `AppPort` can then be passed into the `GetConnection` method to create the connection object.

With the `HTTPClient` object, we can then create a network request to the deployed web server to retrieve the appropriate data from the server side application, just like connecting to a public cloud server.

## End to End

The following graphic illustrates each of the API calls covered above to connect your client application with your deployed server application successfully. The blue lines shown connect to the DME while the green line connects to your application.

![](/developer/assets/endtoend2.png "")

