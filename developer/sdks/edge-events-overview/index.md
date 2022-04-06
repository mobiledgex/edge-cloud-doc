---
title: Edge Events Overview
long_title: Maintain Optimal Connectivity with Edge Events
overview_description:
description:
MobiledgeX Edge Events allows developers to dynamically find the closest edge cloudlet based on the client's location and cellular connectivity.

---

## Why Use Edge Events

To take advantage of edge computing, a client device needs to be connected to the closest backend server, ideally on the same cellular network. However, a lot can change during application runtime, affecting how you determine the most optimal cloudlet for a client. For example, a client could move to a closer cloudlet, a cloudlet could be undergoing maintenance, or an auto-provision policy could add or remove an app instance. In each of these cases, it is helpful for your client app to call our FindCloudlet API, which will provide you the best application instance at that time based on your cellular connection and location. But as a client, it is hard to determine when to call FindCloudlet, without constantly polling. That is where EdgeEvents comes into play.

EdgeEvents is a streaming API that provides a bidirectional connection between the client device and the MobiledgeX Distributed Matching Engine (DME) to answer how to best maintain an edge connection. Periodic data updates such as location or latency are sent from the client to the MobiledgeX DME, which will then send relevant events to your device, such as a closer cloudlet. At this point, you can respond accordingly to your application needs.

![Edge Events Architecture](/developer/assets/Edge-Events.jpg "Edge Events Architecture")

EdgeEvents also provides a wealth of statistics related to device, location, and latency through visualizations in the MobiledgeX console or MC APIs (mcctl). Developers can see user location patterns or latency heat maps to help figure out where to deploy new app instances. Developers can also see stats about the device information of their users to gain insights into their user base. These insights can be viewed on the [Monitoring](/deployments/monitoring-and-metrics/monitoring-edge-events) page of the MobiledgeX Edge-Cloud Console.

![Edge Events Map View](/developer/assets/monitoring/edge-events/cloudlet-location-default-page.png "Edge Events Map View")

## How To Use Edge Events

To help integrate Edge Events into your Client Applications, MobiledgeX has integrated the Edge Events API into our Android and iOS Client SDKs. Due to stability issues with GRPC in C#, we have beta support for Edge Events in the MobiledgeX Unity SDK. If you are interested in using Edge Events with Unity, please contact the MobiledgeX Support Team.

Using our SDKs, you can specify an Edge Events configuration that declares how often you would like to send updates regarding latency and location to the DME and a function for how your application would like to respond to various events that the DME sends to your client.

For simplicity, we recommend that you leverage the MobiledgeX Edge Events Default Configuration, which will provide your callback function with a new application instance on a different cloudlet based on the following events:

- **CloserCloudlet:** The client is closer to a different cloudlet on a Location Update
- **LatencyTooHigh:** The latencyThreshold is exceeded on a Latency Update and there is different cloudlet with lower latency
- **CloudletStateChanged:** CLOUDLET_STATE *is not *CLOUDLET_STATE_READY
- **CloudletMaintenanceStateChanged:** MAINTENANCE_STATE *is not *NORMAL_OPERATION
- **AppInstHealthChanged:** HEALTH_CHECK *is not *HEALTH_CHECK_OK
- **Error:** Will contain an error message for non critical errors

At each of these events, you will receive the next best App Instance for your application to fallback onto. It is then your app’s responsibility to connect to that new application instance and handle any state transfer if necessary.

For control over events or more customization, you can also choose to create your Edge Events Configuration, which will allow you more control over :

- If and how often location data is sent to the MobiledgeX DME
- If and how often latency data is sent to the MobiledgeX DME
- The update frequency for when Edge Events data should be sent to the server : **onStart**, **onInterval**, **onTrigger**.
- Which server events should trigger a FindCloudlet change

## Edge Events Workflow

Integrating Edge Events into your Application Lifecycle can be simply done in the following steps:

- Find your first Application Instance using RegisterClient and FindCloudlet methods in the SDK.
- Choose whether to enable or disable auto-migration to a new Application Instance. By default, this is enabled and will automatically switch your Edge Events connection to receive updates from a better instance when found. If this is not desired, you can disable it.
- Create either a Default Configuration or a Custom Configuration for Edge Events. If you choose to use [Performance Mode](/design/best-practice-sdk#proximity-vs-performance-mode--), which validates that the instance you connect to has the lowest latency, then you will be required to provide a port (preferably TCP) to determine latency.
- Call Start Edge Events from the MobiledgeX Matching Engine and pass in your configuration.
- If you would like to end Edge Events earlier for any reason, your app can call Stop Edge Events.


For specific example code, please refer to each SDK’s overview page and Documentation below.

## End To End Integration

<div class="embed-responsive embed-responsive-16by9">
<!-- Youtube and Video -->
<iframe class="embed-responsive-item" src="https://www.youtube-nocookie.com/embed/JycEIv9XIDU" ...>
</iframe>
</div>

