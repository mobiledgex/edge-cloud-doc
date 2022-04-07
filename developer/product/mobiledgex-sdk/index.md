---
title: MobiledgeX Client SDKs
long_title:
overview_description:
description:
Learn how our SDKs are built on top of our APIs to make it simpler to find the closest deployed application instance

---

Based on a device’s location and cellular connection, MobiledgeX SDKs simplify the development process of connecting to the best deployed application instance. In other words, by integrating the SDK into your client application such as an Android or iOS app, your users will experience the benefits of edge computing.

For example, if user A is located in Spain and using a Telefonica Cellular Connection, our SDK will determine the closest cloudlet with your application to user A that is on the Telefonica network. Similarly, if user B is located in Germany and using a Deutsche Telekom (DT) Cellular Connection, our SDK will determine the closest cloudlet with your application to user B on the DT network.

<em>
**This ensures that the connection has low network latency and low network jitter.**
</em>

Moreover, in mobility use cases, where a device is moving around, our SDK will provide event callbacks to inform your application that there is a better cloudlet available to begin communicating with.

For developers, we provide native SDKs for Android, iOS, and C# / Unity. We also provide REST APIs that are available to use for other applications frameworks. If you would like for us to consider supporting another SDK, please contact our support team or message us in our Discord community.

At its simplest, our SDKs use the following two methods (in pseudocode) in order to determine the URI for an application instance.

- `session_cookie` **RegisterClient** `(org_name, app_name, app_version)`
- `url` **FindCloudlet** `(session_cookie, location)`

<div class="next_steps" markdown="1">

## MobiledgeX Client SDKs

To get started, head to our Client SDK section and download the SDK of your choice as well as run the provided sample applications.

- [Android SDK](/developer/sdks/android-sdk/index.md)
- [iOS SDK](/developer/sdks/ios-sdk/index.md)
- [Unity SDK](/developer/sdks/unity-sdk/index.md)

</div>

