---
title: Download Instructions
long_title: Android SDK
overview_description: 
description: 
Download the Matching Engine Android SDK to create applications for your device

---

**Last Modified:** 7/10/2021

The MobiledgeX Android Client Library enables an app to locate the most optimal server backend. Because these APIs involve networking, most functions will run asynchronously, and in a background thread.

The Matching Engine Android SDK provides everything required to create applications for Android devices.  

**Note:** Devices without a supporting cellular network may use Wifi for development.

## Prerequisites

- Android Studio 3.6.x installed  
- A device with API v.23 or higher (Android 6.0)

## Download the Android SDK Libraries

**Step 1:** Create a login on to the [MobiledgeX Console](https://console.mobiledgex.net). The creation of a login will automatically generate a user account and allows for access to [MobiledgeX Artifactory](https://artifactory.mobiledgex.net).  

**Step 2:** In your top level Android Studio gradle project file, add the following artifactory plugin to the buildscript section.  

```
buildscript {
  repositories {
    google()
    jcenter()
  }
  dependencies {
    classpath ’com.android.tools.build:gradle:3.4.0’
    classpath "com.google.protobuf:protobuf-gradle-plugin:0.8.8"
    // JFrog Artifactory:
    classpath "org.jfrog.buildinfo:build-info-extractor-gradle:latest.release"
    // NOTE: Do not place your application dependencies here; they belong
    // in the individual module build.gradle files
  }

}
```

**Step 3:** Append the following two properties to the  `local.properties` file. Additionally, you must include these two properties within your gradle file. Once the properties are added, specify a project level GRPC version, and the MobiledgeX SDK matchingEngine version.  

```
Properties properties = new Properties()
properties.load(project.rootProject.file(’local.properties’).newDataInputStream())
def artifactoryuser = properties.getProperty("artifactoryuser")
def artifactorypassword = properties.getProperty("artifactorypassword")
project.ext.grpcVersion = ’1.32.1’
project.ext.matchingengineVersion = ’3.0’
project.ext.melVersion = ’1.0.11’
```

**Step 4:** Add the MobiledgeX repository.  

```
allprojects {
   apply plugin: ’com.jfrog.artifactory’
   apply plugin: ’maven-publish’
   repositories {
       google()
       jcenter()
       mavenLocal()
       maven {
           credentials {
               // Create these variables in local.properties if you don’t have them.
               username artifactory_user
               password artifactory_password
           }
           url "[https://artifactory.mobiledgex.net/artifactory/maven-releases/](https://artifactory.mobiledgex.net/artifactory/maven-releases/)"
       }
   }

}
```

**Step 5:** In the application `build.gradle` project file, add the following to the dependencies section so that the MobiledgeX related libraries can be downloaded. Click **sync gradle file** if prompted by the Android Studio IDE.  

```
dependencies {
   // ...
   implementation "com.mobiledgex:matchingengine:${matchingengineVersion}"
   implementation ’com.mobiledgex:mel:${melVersion}’
   implementation "io.grpc:grpc-okhttp:${grpcVersion}"
   implementation "io.grpc:grpc-stub:${grpcVersion}"
   implementation "io.grpc:grpc-protobuf-lite:${grpcVersion}"

}
```

## Example SDK Usage

### Workflow to Find the Closest Cloudlet

```
MatchingEngine me = new MatchingEngine(context); 
//For privacy reasons, there is a flag the application should ask the user for permission before enabling, concerning location usage. 
MatchingEngine.setMatchingEngineLocationAllowed(matchingEngineLocationAllowed);

//Register Client
AppClient.RegisterClientRequest registerClientRequest = me.createDefaultRegisterClientRequest(context, organizationName).setAppName(appName).setAppVers(appVersion).build();      
registerReply = me.registerClient(registerClientRequest, GRPC_TIMEOUT_MS);

//Find Cloudlet 
AppClient.FindCloudletRequest findCloudlet= matchingEngine.createDefaultFindCloudletRequest(ctx, location).build();
findCloudletReply = me.findCloudlet(findCloudletRequest, GRPC_TIMEOUT_MS);
```

### Workflow to Utilize Edge Events

```
mEdgeEventsSubscriber = new EdgeEventsSubscriber(); me.getEdgeEventsBus().register(mEdgeEventsSubscriber);
// set a default config.
// There is also a parameterized version to further customize.
EdgeEventsConfig backgroundEdgeEventsConfig = me.createDefaultEdgeEventsConfig();
backgroundEdgeEventsConfig.latencyTestType = NetTest.TestType.CONNECT;
// This is the internal port, that has not been remapped to a public port for a particular appInst.
backgroundEdgeEventsConfig.latencyInternalPort = 3765; // 0 will grab first UDP port but will favor the first TCP port if found.
// Latency config. There is also a very similar location update config.
backgroundEdgeEventsConfig.latencyUpdateConfig.maxNumberOfUpdates = 0; // Default is 0, which means test forever.
backgroundEdgeEventsConfig.latencyUpdateConfig.updateIntervalSeconds = 7; // The default is 30.
backgroundEdgeEventsConfig.latencyThresholdTrigger = 186;
```

For more information on how to use the Android SDK and best practices, please refer to the [Android SDK Manual](https://mobiledgex.github.io/edge-cloud-sdk-android/).  

