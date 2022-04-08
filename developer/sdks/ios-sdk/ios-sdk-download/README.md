---
title: Download Instructions
long_title: Apple iOS SDK
overview_description: 
description: 
Learn how to use the MobiledgeX Matching Engine iOS SDK to create applications for iOS devices

---

**Last Modified:** 1/19/2022

The MobiledgeX Client Library enables an application to register and then locate the nearest edge cloudlet backend server for use. Because these APIs involve networking, most functions will run asynchronously, and in a background thread, utilizing the Google Promises framework and iOS DispatchQueue.

The Matching Engine iOS SDK provides everything required to create edge-enabled applications for iOS devices. The GRPC version, starting with version 3.0.5, will include EdgeEvents support for server pushed AppInst updates that react to network, server, and location conditions.

## Prerequisites  

- A MobiledgeX [Console Account](/developer/getting-started) to access our SDKs on the MobiledgeX [Artifactory](https://artifactory.mobiledgex.net)
- MacOS Big Sur and an iOS Device 
- Xcode 13.2.1 (From the Apple store, search for [Xcode](https://developer.apple.com/xcode/))
- An Apple ID. Create an ID from the developer site on [Apple](https://developer.apple.com)
- [Cocoapods](https://cocoapods.org) installation

## Download the iOS SDK and libraries  

**Step 1:** In terminal, run these commands to install Cocoapods: `gem install cocoapods` and `gem install cocoapods-art`.  

**Step 2:** Go to your root directory `cd ~`.

**Step 3:** Create a .netrc file and enter the following credentials: `echo machine artifactory.mobiledgex.net login &lt;username&gt; password &lt;password&gt; .netrc`. Use the same credentials that you use for MobiledgeX Console Account

**Step 4:** Add the repository with the .netrc credentials:

`pod repo add cocoapods-releases https://artifactory.mobiledgex.net/artifactory/api/pods/cocoapods-releases`

**Step 5:** Navigate to your XCode project directory and add the following lines to your podfile:  

- `plugin ’cocoapods-art’, :sources =&gt;; [’cocoapods-releases’]`
- `pod ’MobiledgeXiOSGrpcLibrary’, ’= 3.0.5’`

Example podfile:

```
use_frameworks!
platform :ios, ’13.0’

# Default Specs.git:

source ’https://github.com/CocoaPods/Specs.git’
plugin ’cocoapods-art’, :sources =&gt; [’cocoapods-releases’]
target ’ARShooter’ do  
  pod ’MobiledgeXiOSLibrary’,’= 3.0.5’

end
```

**Step 6:** Save your podfile, and then run the following command to install the MobiledgeXLibarary dependency to your workspace: `pod install`. If you already have a xcworkspace, you may need to go to your Pods in XCode, and adjust the `BUILD_LIBRARY_FOR_DISTRIBUTION = ’NO’` for the dependencies above to match.

**Step 7:** Open your xcworkspace.

**Step 8:** Copy and paste `import MobiledgeXiOSGrpcLibrary` in any file(s) where you will utilize the MobiledgeX library / SDK.

## Example Usage

### Workflow to find the closest cloudlet

```
let promise = MobiledgeXiOSLibraryGrpc.MobiledgeXLocation.startLocationServices().then { success -&gt;
    if !success {
        // handle unable to start location service
    }
    let regRequest = matchingEngine.createRegisterClientRequest(orgName: orgName, appName: appName, appVers: appVers)
    return self.matchingEngine.registerClient(request: regRequest)

}.then { registerReply -&gt; Promise&lt;DistributedMatchEngine_FindCloudletReply&gt; in
    if registerReply == nil || registerReply.status != .rsSuccess {
        print("Bad registerclient. Status is \(registerReply.status)")
        // handle bad registerclient
    }
    let req = try self.matchingEngine.createFindCloudletRequest(gpsLocation: loc, carrierName: self.carrierName)
    return self.matchingEngine.findCloudlet(request: req)

}.then { fcReply -&gt; Promise&lt;MobiledgeXiOSLibraryGrpc.EdgeEvents.EdgeEventsStatus&gt; in
    if fcReply.status != .findFound {
        print("Bad findcloudlet. Status is \(fcReply.status)")
        // handle bad findcloudlet
    }

}
```

### Workflow to utilize Edge Events

```
let promise = MobiledgeXiOSLibraryGrpc.MobiledgeXLocation.startLocationServices().then { success -&gt;
    if !success {
        // handle unable to start location service
    }
    let regRequest = matchingEngine.createRegisterClientRequest(orgName: orgName, appName: appName, appVers: appVers)
    return self.matchingEngine.registerClient(request: regRequest)

}.then { registerReply -&gt; Promise&lt;DistributedMatchEngine_FindCloudletReply&gt; in
    if registerReply == nil || registerReply.status != .rsSuccess {
        print("Bad registerclient. Status is \(registerReply.status)")
        // handle bad registerclient
    }

    let req = try self.matchingEngine.createFindCloudletRequest(gpsLocation: loc, carrierName: self.carrierName)
    return self.matchingEngine.findCloudlet(request: req)

}.then { fcReply -&gt; Promise&lt;MobiledgeXiOSLibraryGrpc.EdgeEvents.EdgeEventsStatus&gt; in
    if fcReply.status != .findFound {
        print("Bad findcloudlet. Status is \(fcReply.status)")
        // handle bad findcloudlet
    }

}

    let config = self.matchingEngine.createDefaultEdgeEventsConfig(latencyUpdateIntervalSeconds: 30, locationUpdateIntervalSeconds: 30, latencyThresholdTriggerMs: 50)
    return self.matchingEngine.startEdgeEvents(newFindCloudletHandler: self.handleNewFindCloudlet, config: config)

}.catch { error in
    print("EdgeEventsConnection encountered error: \(error)")
    // handle error

}
```

For more information on how to use the Android SDK and best practices, please refer to the [iOS SDK Manual](https://mobiledgex.github.io/MatchingEngineSDK/rest/index.html).

