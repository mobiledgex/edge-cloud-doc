---
title: "Best Practices : Client SDKs"
long_title: Best Practices using MobiledgeX Client SDKs
overview_description:
description:
Learn the best practices for utilizing the MobiledgeX Client SDKs for Android, iOS, and Unity

---

In this guide, the best practices for utilizing MobiledgeX’s SDKs are explained. Before reading this guide, it is recommended that you read [Connecting Client Application to Deployed Cloudlets](/sdks/overview), which details how to use our SDKs and APIs. Specifically, this guide will cover:

- When and how often `FindCloudlet` should be used within your application’s deployment
- When should your application use `VerifyLocation`
- What is the Performance Metrics API, and when is it used
- WiFi Use Cases

## SDK Basics  

The process for connecting to a cloudlet will require your application to call two functions: `RegisterClient` and `FindCloudlet`. Calling these functions provides the URI of an application instance from a cloudlet that will best serve your client. The best-returned application instance is determined by two factors: *the user’s current location* and *the network connection*. Once your client application receives the URI, it may begin communicating with your deployed backend server. Please see the diagram below.

![](/assets/connect-client-app/endtoend.png "")

## FindCloudlet  

### When to call FindCloudlet  

FindCloudlet is responsible for finding the optimum deployed application instance within a cloudlet, depending on a user’s location and network connection. For most applications, it is advised that you call `FindCloudlet` at the start of your application’s lifecycle. Calling this function provides a URI to begin communicating with your backend application. The goal of edge computing is to provide your client applications with the best possible backend regardless of the user’s behavior. Your client applications should update MobiledgeX’s backend with the latest location and network connection data. Providing this data can be done by calling `FindCloudlet` at anytime during your client application’s deployment.

When should you call `FindCloudlet`? There are other cases, besides at the start of your application’s lifecycle, in which to call `FindCloudlet`. Here are some examples:

- The backend server is unresponsive.
- The user has physically moved geographically. (i.e., driving or significant travel from the user’s original physical location).
- The end-user switches from WiFi to a cellular connection, or vice versa.
- The latency of the connection has increased to an unacceptable level.

In these examples, it is likely the current backend for your client may not have the optimum application instance for its situation. Therefore, for these examples, it is recommended that your application should call `FindCloudlet` again. From the `FindCloudlet` call, MobiledgeX will match your application with a backend that provides optimum service. During development, this should be implemented in an event-driven framework, where the above events will trigger your application to call `FindCloudlet` again. This call will again return an application instance, and your client app should begin communicating with this updated instance. Please note, the application instance may remain the same.

## Proximity vs. Performance mode  

As part of each SDK, the `FindCloudlet` function has an optional parameter, `FindCloudletMode`. `FindCloudletMode` is an enum that has two settings: **Proximity** and **Performance**. These parameters allow your application to choose the mode in which `FindCloudlet` returns an application instance for use. By default, if you do not enter this parameter into your `FindCloudlet` call, it will automatically enter **Proximity** mode. **Proximity** mode returns the equivalent information that would be returned by using the REST API directly. As a result, the MobiledgeX Distributed Matching Engine (DME) is responsible for finding your application the best cloudlet for your location and network carrier. This mode is recommended for most application developers.

However, **Proximity** mode is unable to verify if the application instance has the lowest possible latency within available application instances. To resolve this, our SDK offers the second option-**Performance** mode. In **Performance** mode, instead of calling the `FindCloudlet` REST API, the SDK calls `GetAppInstList` and receives a list of all the application instances that are deployed for your application. Next, the SDK measures latency by using the `PerformanceMetrics` API and designates the application instance with the lowest latency. Please note that **Performance** mode may take some additional time to determine which application instance has the lowest latency. Depending on your application’s requirements, having a low latency may be a prerequisite. If this is the case, **Performance** mode is recommended.

If you would like to learn how to implement Performance mode for a language specific SDK, please refer to our [SDK manuals](/apis).

## Performance Metrics  

The `PerformanceMetrics` API of the SDK contains the **NetTest** class. **NetTest** class measures the latency of an application instance. As mentioned in the `FindCloudlet` section, this API is used in the **FindCloudletPerformance** mode to determine the lowest latency application instance from a cloudlet.

It is recommended to use `PerformanceMetrics` primarily for measuring the latency of your current connection to an application instance. `PerformanceMetrics` are useful to determine if it is necessary to switch to a different application instance using `FindCloudlet`. `PerformanceMetrics` can be utilized for debugging. Using `PerformanceMetrics` to measure latency ensures the ability to provide the best possible performance to users.

It is recommended to establish the **NetTest** class on a separate thread. Setting **NetTest** class on a different thread will not block your application’s main thread, ensuring that `PerformanceMetrics` will not impact the performance of your application. Please note that if your application is running multiple latency tests for several application instances, it may take an extended time to run. It should be run in the background, not to degrade the performance of your application.

## WiFi Use Case  

[Connecting Client Applications to Deployed Cloudlets](/sdks/overview) explains how the SDK uses the **MCC-MNC** from your device’s cellular connection to select the DME for your client application. However, when your device cannot establish a cellular connection, your device will be unable to determine an **MCC-MNC**. In this instance, the SDK will opt to connect to the WIFI DME: `https://wifi.dme.mobiledgex.net:38001`.

WIFI DME is an auxiliary connection option. WIFI DME ensures a device can connect to the nearest app instance when a cellular connection cannot be established. In this case, the WIFI DME requests are implemented through a process called [NS1 lookup](https://ns1.com/resources/how-geographic-routing-works). The [NS1 lookup](https://ns1.com/resources/how-geographic-routing-works) process will route WIFI DME requests to the closest regional DME.

MobiledgeX supports three regions: **US**, **EU**, and **JP**, each of which will contain a list of all application instances that have been deployed to those respective regions.

For example, when a WIFI DME request originates from the US, that request will be connected to the US Region DME. Please note, in this case, your client application **will not** be able to see application instances that have been deployed in other regions. It is recommended to utilize a VPN or superseding the `RegisterClient` or `FindCloudlet` calls if a connection to another region is desired while WiFi DME is established.

