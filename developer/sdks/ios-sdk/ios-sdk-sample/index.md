---
title: Augmented Reality Sample App
long_title: Add Edge Support to MobiledgeX ARShooter SDK Sample
overview_description:
description:
Build on top of the MobiledgeX iOS AR shooting sample application that demonstrates how to use the iOS MobiledgeX SDK

---

**Last Modified:** 6/23/2021

This is a guide for the open source iOS Augmented Reality Shooter Sample Application that demonstrates a use case for integrating an ARKit application with a simple Socket.IO leaderboard server that is deployed on MobiledgeX.

To download the code and read instructions on how to run it yourself, check out code on the [MobiledgeX Samples Github](https://github.com/mobiledgex/edge-cloud-sampleapps/tree/master/iOS/ARShooterExample/ARShooterGame). In this tutorial, we’ll show you the key bits of code necessary on how the sample integrates the MobiledgeX iOS SDK.

## Prerequisites

- A MobiledgeX [Console Account](/getting-started/) to access our SDKs on the MobiledgeX [Artifactory](https://artifactory.mobiledgex.net)
- MacOS Computer and an iOS Device
- Xcode (From the Apple store, search for [Xcode](https://developer.apple.com/xcode/))
- An Apple ID. Create an ID from the developer site on [Apple](https://developer.apple.com)
- [Cocoapods](https://cocoapods.org) installation

## Import the iOS SDK Matching Engine Library

The MobiledgeX iOS MatchingEngine SDK is stored in Artifactory and we will pull it in using [Cocoapods](https://cocoapods.org/) (an iOS dependency manager).

In terminal, run the following commands:

- Install cocoapods `sudo gem install cocoapods`
- Install cocoapods-art `sudo gem install cocoapods-art`
- Go to root directory `cd ~`
- Create a `.netrc` file and put in credentials:

```
$ echo "machine artifactory.mobiledgex.net login &lt;ArtifactoryUsername&gt; password &lt;ArtifactoryPassword&gt;" &gt; .netrc
```

where `&lt;ArtifactoryUsername&gt;` and `&lt;ArtifactoryPassword&gt;` are your MobiledgeX Console credentials.

```
$ pod repo-art add cocoapods-releases https://artifactory.mobiledgex.net/artifactory/api/pods/cocoapods-releases
```

These commands will pull in the Podspecs from the MobiledgeX Artifactory repo into your computer. You can see them by navigating to

`~/.cocoapods/repos-art/cocoapods-releases/Specs/MobiledgeXiOSLibrary/3.0.5/MobiledgeXiOSLibrary.podspec`

Navigate to the folder that contains the completed [ARShooterGame](https://github.com/mobiledgex/edge-cloud-sampleapps/tree/master/iOS/ARShooterExample/ARShooterGame) Example and then run `pod install`

This will look at the podspecs specified in the Podfile: `source https://github.com/CocoaPods/Specs.git` for Open Source dependencies we are using, and our local cocoapods-releases directory for the MobiledgeXiOSLibrary podspec. The podspec will inform Cocoapods where the source code is and CocoaPods will automatically integrate the dependencies into our project.

## iOS MatchingEngine SDK

The iOS MatchingEngine SDK uses the Promises framework to easily work with asynchronous code. We will be using the MobiledgeX Distributed Matching Engine APIs to register the user and find the optimal edge data center (cloudlet) running the app. To learn more about the workflow, you may refer to the [SDK Technical Overview Documentation](/sdks/tech-overview).

We will be showing the implementation for the following:

**RegisterClient()** - Identifies the user (Organization Name) and application details (appName and appVersion), and allows the usage of MobiledgeX integration.

**FindCloudlet()** - Returns the edge application server to communicate with, in the form of an AppPort list that needs to be parsed to retrieve your particular application’s server details. Either TCP or UDP transport. A cloudlet is a small-scale cloud datacenter.

**Edge Events()** - Listen for events and send updates about the client to the MobiledgeX Distributed Matching Engine in order to determine the optimal time in your application workflow to switch to a better cloudlet for your end users.

## Setup Matching Engine Parameters

In the [LoginViewController](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/master/iOS/ARShooterExample/ARShooterGame/ARShooter/LoginViewController/LoginViewController.swift), first we have to import the MobiledgeXiOSLibrary in our Client code and define variables that will be used in our APIs.

```
import MobiledgeXiOSLibrary
```

```
var matchingEngine: MobiledgeXiOSLibrary.MatchingEngine!
```

Once the matchingEngine variable has been created, we next need to define which application we want to find on the MobiledgeX platform. This is defined by the `appName`, `appVers`, and `orgName`, which you can look up in the MobiledgeX Console for your application. In this case, we have already created a sample application that you can use below and here are the configurations we recommend to use, which are defined in the [setupMatchingEngineFunction](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/0c4ed18ea8ff17c3e73e6cece0584a3e8aebbc52/iOS/ARShooterExample/ARShooterGame/ARShooter/LoginViewController/LoginViewController.swift#L82)  :

```
matchingEngine = MobiledgeXiOSLibrary.MatchingEngine()
dmeHost = "wifi.dme.mobiledgex.net"
dmePort = 38001
appName = "ARShooter"
appVers = "1.0"
orgName = "MobiledgeX-Samples"
carrierName = ""
location = MobiledgeXiOSLibrary.MatchingEngine.Loc(latitude: 37.459609, longitude: -122.149349) // Get actual location and ask user for permission
```

## Register Client

With the parameters specified above, we can make the first API call with the Matching Engine : RegisterClient. As the name implies, this registers the client iOS device with the MobiledgeX Matching Engine and confirms if that specified application, **ARShooter** in this case, has been deployed to the edge. The request returns a Session Cookie in the RegisterClientReply that must be used for following API calls. This is the [specific example code](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/0c4ed18ea8ff17c3e73e6cece0584a3e8aebbc52/iOS/ARShooterExample/ARShooterGame/ARShooter/LoginViewController/LoginViewController.swift#L126-L135) for making a Register Client Call.

```
// Register user to begin using edge cloudlet

let registerClientRequest = matchingEngine.createRegisterClientRequest(
  orgName: orgName,
  appName: appName,
  appVers: appVers)
     

matchingEngine.registerClient(request: registerClientRequest).then { registerClientReply in
            SKToast.show(withMessage: "RegisterClientReply is \(registerClientReply)")
            print("RegisterClientReply is \(registerClientReply)")

}
```

## Find Cloudlet

After Registering the Client Device, we can now call the Find Cloudlet API, which is responsible for determining the best cloudlet that your application is deployed onto for the client, based on the GPS location and operator cellular connection. This is the [specific example code](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/0c4ed18ea8ff17c3e73e6cece0584a3e8aebbc52/iOS/ARShooterExample/ARShooterGame/ARShooter/LoginViewController/LoginViewController.swift#L141-L142) for making a Find Cloudlet call.

```
// FindCloudlet
let findCloudletRequest = try self.matchingEngine.createFindCloudletRequest(
  gpsLocation: self.location!,
  carrierName: self.carrierName!

)

self.findCloudletPromise = self.matchingEngine.findCloudlet(request: findCloudletRequest)

all(self.findCloudletPromise!).then { value in
  // Handle findCloudlet reply
  let findCloudletReply = value.0
  SKToast.show(withMessage: "FindCloudletReply is \(findCloudletReply)")
  print("FindCloudletReply is \(findCloudletReply)")
  SKToast.show(withMessage: "Need to handle verifyLocation reply")

}.catch { error in
  // Handle Errors
  SKToast.show(withMessage: "Error occured in callMatchingEngineAPIs. Error is \(error.localizedDescription")
  print("Error occured in callMatchingEngineAPIs. Error is \(error.localizedDescription)")

}
```

## GetConnection workflow:

The GetConnection workflow is the suggested workflow to register the user using an application, find the nearest cloudlet with the application backend deployed, and get a “connection” object to send and receive data.

The full workflow is:

- **RegisterAndFindCloudlet**(): Wrapper function for registerClient() and findCloudlet(). Returns a dictionary with findCloudletReply fields.
- **Get[Protocol]AppPorts**(): Returns a dictionary (key: String, value: [String: Any]), where keys are the internal port specified on app deployment and values are the AppPort “object” returned in the ports field of findCloudletReply. (This object may contain a range of ports and an fqdn prefix that is specific to the application backend)


```
let replyPromise = matchingEngine.registerAndFindCloudlet(
  orgName: orgName,
  gpsLocation: location!,
  appName: appName,
  appVers: appVers,
  carrierName: carrierName).then { findCloudletReply -&gt; Promise&lt;SocketManager&gt; in
    // Get Dictionary: key -&gt; internal port, value -&gt; AppPort Dictionary
    guard let appPortsDict = try self.matchingEngine.getTCPAppPorts(findCloudletReply: findCloudletReply) else {
        throw LoginViewControllerError.runtimeError("GetTCPPorts returned nil")
    }

```

- For your app, you should know what internal port is required and get the **AppPort** “object” from the dictionary that corresponds to that internal port. This returned AppPort object will then be used in the GetConnection call.


- **Get[Protocol]Connection():** Depending on the protocol (TCP, UDP, HTTP, Websockets), this will return a different Swift object to be used to send and receive data.


```
  // Select AppPort Dictionary corresponding to internal port 3838
    guard let appPort = appPortsDict[self.internalPort] else {
        throw LoginViewControllerError.runtimeError("No app ports with specified internal port")
    }
    return self.matchingEngine.getWebsocketConnection(findCloudletReply: findCloudletReply, appPort: appPort, desiredPort: Int(self.internalPort), timeout: 5000)

}.then { manager in
    self.manager = manager

}.catch { error in
    print("Error is \(error)")

}
```

For ARShooter, the app expects a Websocket connection. The [getWebSocketConnection](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/0c4ed18ea8ff17c3e73e6cece0584a3e8aebbc52/iOS/ARShooterExample/ARShooterGame/ARShooter/LoginViewController/LoginViewController.swift#L172-L204) method demonstrates how you can implement this workflow for a WebSocketConnection.

## iOS GPS Location

The MobiledgeXiOSLibrary requires user location to find the nearest cloudlet.

The code above hardcoded the user location for ease of use. An actual application would request location permissions from the user and grab the gps location whenever needed. This section will show how to request location permissions and convert GPS locations to a MobiledgeX.Loc object that can be used in FindCloudlet.

### Request Permissions

First let us [request location permissions](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/0c4ed18ea8ff17c3e73e6cece0584a3e8aebbc52/iOS/ARShooterExample/ARShooterGame/ARShooter/LoginViewController/LoginViewController.swift#L73-L75) from the user.

```
self.locationManager = CLLocationManager()
locationManager!.delegate = self
locationManager!.requestWhenInUseAuthorization()
```

Note, [LoginViewController](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/master/iOS/ARShooterExample/ARShooterGame/ARShooter/LoginViewController/LoginViewController.swift#L73-L75) implements the CLLocationManagerDelegate interface. We will implement a delegate function in this file, so we must assign LoginViewController to be the locationManager’s delegate.

### Implement CLLocationManagerDelegate

Finally, the client needs to listen for location updates from the manager, which is implemented in the [locationManager function](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/0c4ed18ea8ff17c3e73e6cece0584a3e8aebbc52/iOS/ARShooterExample/ARShooterGame/ARShooter/LoginViewController/LoginViewController.swift#L105-L116).

Once the user allows location permissions, we will grab the user’s gps location and then convert it to a MobiledgeX.Loc object to be used for the [FindCloudlet MobiledgeX](#find-cloudlet) API calls.

```
var currLocation: CLLocation!
if (status == .authorizedAlways || status == .authorizedWhenInUse) {
  currLocation = manager.location
  location = MobiledgeXiOSLibrary.MatchingEngine.Loc(latitude: currLocation.coordinate.latitude, longitude: currLocation.coordinate.longitude)

}
```

```
if location != nil {
  mobiledgeXIntegration()

}
```

## ARShooter Socket.IO Server

Originally, this app used iOS’s MultipeerConnectivity Framework, which uses peer to peer communication. This framework breaks down with more than 7 or 8 players connected to the same game. So, we have to use a server to handle communication between devices and synchronize the game state (so everyone sees the same thing, or at least close to the same thing).

To see the server code, go to [edge-cloud-sampleapps/iOS/ARShooterExample/ARShooterServer/shooter-server.js](https://github.com/mobiledgex/edge-cloud-sampleapps/tree/master/iOS/ARShooterExample/ARShooterServer). This a bare-bones Node.js server that directs communication between devices and can keep track of different games. It uses the socket.io library, which is mirrored in client side with the Socket.IO-Client-Swift library (which we imported using Cocoapods).

