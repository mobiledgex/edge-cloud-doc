---
title: Integrate Face Detection
long_title: Add Face Detection to the Android Sample App
overview_description: 
description: 
Add Face Detection to an Android workshop application

---

**Last Modified:** 11/23/21

Through this application, you will see the benefits of Edge computing for latency sensitive applications. We will also take a look at GPU-accelerated body pose detection as an example of offloading a heavy workload to an Edge cloudlet. Before starting this workshop, make sure you have worked through the How-To: Android Workshop: Add Edge Support to Workshop App which shows you how to call several of MobiledgeX’s Distributed Matching Engine APIs.

We will be making use of a MobiledgeX library:

- The **MobiledgeX ComputerVision** library provides classes and interfaces to work with the Android device’s camera, and to send images to a Face Detection server and receive and process the server’s responses.

This library has been published to a Maven repository and we will be adding itfd to our workshop project. To interface with the library, we must update the workshop code to instantiate several classes and implement several interfaces. This document will walk you through how to do this.

## Workshop Goals


- Add a face detection activity using the MobiledgeX Computer Vision library.
- Add Edge support to the face detection activity, to get best possible latency for on-screen face tracking.
- Experiment with face recognition and pose detection.
- Hack on the app with your own ideas.


## Prerequisites


- Android app development experience.
- Android Studio installed and up to date. This installation can be a lengthy process, so please have your
- development environment in good shape before the start of the workshop.
- Access to the **Workshop Skeleton** app code.
- Worked through [Add Edge Support to an Android Application](/developer/sdks/android-sdk/android-sdk-sample/index.md)


## Instructions

### Add the MobiledgeX ComputerVision Library


- Open Gradle Scripts/build.gradle
- Add the following to the dependencies section:


```
// MobiledgeX Computer Vision library
implementation ’com.mobiledgex:computervision:1.1.3’
implementation ’com.android.volley:volley:1.1.1’

```

### Face Processor Fragment Layout

#### Add Face Box Renderer to Layout

![Face Box Rendered to Layout](/developer/assets/how-to-android-workshop-add-face-detection-to-workshop-app/1.png "Face Box Rendered to Layout")

In the WorkshopSkeleton project, there is an **edgeFaceBoxRender** placeholder that is defined as a generic View. Let’s update it to a FaceBoxRenderer. Open **app/res/layout/fragment*face*processor.xml**. If the editor comes up in "Design" mode, change to the "Code" view (see pink oval below).

![Fragment_Face_Processor.xml](/developer/assets/how-to-android-workshop-add-face-detection-to-workshop-app/2.png "Fragment_Face_Processor.xml")

Now search for **edgeFaceBoxRender**. Change its definition from "View" to "com.mobiledgex.computervision.FaceBoxRenderer".

It will now look like this:

```
&lt;com.mobiledgex.computervision.FaceBoxRenderer
    android:id="@+id/edgeFaceBoxRender"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:layout_gravity="center" /&gt;

```

## Modify FaceProcessorFragment

Now let’s edit the main class we will be using for Face Detection. Open **app/java/com.mobiledgex.workshopskeleton/FaceProcessorFragment.java**.

![FaceProcessorFragment.java](/developer/assets/how-to-android-workshop-add-face-detection-to-workshop-app/3.png "FaceProcessorFragment.java")

### Imports

In **FaceProcessorFragment.java**, add the following imports:

```
import com.mobiledgex.computervision.Camera2BasicFragment;
import com.mobiledgex.computervision.FaceBoxRenderer;
import com.mobiledgex.computervision.ImageProviderInterface;
import com.mobiledgex.computervision.ImageSender;
import com.mobiledgex.computervision.ImageServerInterface;
import com.mobiledgex.computervision.RollingAverage;

```

### Class Definition

Update the definition of the FaceProcessorFragment class to extend [ImageProcessorFragment](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/master/android/MobiledgeXSDKDemo/computervision/src/main/java/com/mobiledgex/computervision/ImageProcessorFragment.java), implement the library methods, and then add a [FaceBoxRenderer](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/master/android/MobiledgeXSDKDemo/computervision/src/main/java/com/mobiledgex/computervision/FaceBoxRenderer.java) variable. The class definition should now look like this:

```
public class FaceProcessorFragment extends com.mobiledgex.computervision.ImageProcessorFragment implements ImageServerInterface,
        ImageProviderInterface {
    private FaceBoxRenderer mFaceBoxRenderer;

```

## Define Variables

In this section we will instantiate our camera fragment, image sender, and face box renderer.

### Preferences

Before we instantiate our classes, we’ll need access to some preferences and default values. Those are defined in the library’s base [ImageProcessorFragment](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/master/android/MobiledgeXSDKDemo/computervision/src/main/java/com/mobiledgex/computervision/ImageProcessorFragment.java) class, but we need to add some code to populate the values.

Search for the following comment:

```
// TODO: Copy/paste the code to access preferences.

```

Directly after that (or in place of it), copy and paste the following code:

```
SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(getContext());
prefs.registerOnSharedPreferenceChangeListener(this);
onSharedPreferenceChanged(prefs, "ALL");

```

### Camera Fragment

The [Camera2BasicFragment](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/master/android/MobiledgeXSDKDemo/computervision/src/main/java/com/mobiledgex/computervision/Camera2BasicFragment.java) class provides the image frames that we will be sending to the Face Detection server for processing. Let’s instantiate ours now.

Search for the TODO that refers to "Camera2BasicFragment" and paste the following code:

```
mCamera2BasicFragment = new Camera2BasicFragment();
mCamera2BasicFragment.setImageProviderInterface(this);
String prefKeyFrontCamera = getResources().getString(R.string.preference_fd_front_camera);
mCamera2BasicFragment.setCameraLensFacingDirection(prefs.getInt(prefKeyFrontCamera, CameraCharacteristics.LENS_FACING_FRONT));
FragmentTransaction transaction = getChildFragmentManager().beginTransaction();
transaction.replace(com.mobiledgex.computervision.R.id.child_camera_fragment_container, mCamera2BasicFragment).commit();

```

### Image Sender

The [ImageSender](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/master/android/MobiledgeXSDKDemo/computervision/src/main/java/com/mobiledgex/computervision/ImageSender.java) class sends images to Face Detection server and receives results specifying rectangular coordinates for any detected faces. Let’s instantiate our [ImageSender](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/master/android/MobiledgeXSDKDemo/computervision/src/main/java/com/mobiledgex/computervision/ImageSender.java) now.

Search for the TODO that refers to "ImageSender" and paste the following code:

```
mImageSenderEdge = new ImageSender.Builder()
        .setActivity(getActivity())
        .setImageServerInterface(this)
        .setCloudLetType(CloudletType.EDGE)
        .setHost(mHost)
        .setPort(mPort)
        .setPersistentTcpPort(PERSISTENT_TCP_PORT)
        .build();

mImageSenderEdge.setCameraMode(ImageSender.CameraMode.FACE_DETECTION);
mCameraMode = ImageSender.CameraMode.FACE_DETECTION;
mCameraToolbar.setTitle("Face Detection");

```

Here, we are using the mHost and mPort variables that were set in the GetConnection Workflow in the [How To: Add Edge Support to the Android Workshop App](/developer/guides-and-tutorials/how-to-add-edge-support-to-an-android-app/index.md) document.

### Face Box Renderer

The [FaceBoxRenderer](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/master/android/MobiledgeXSDKDemo/computervision/src/main/java/com/mobiledgex/computervision/FaceBoxRenderer.java) draws the coordinates received from the Face Detection server. It is defined in **fragment*face*processor.xml**, but we need to assign a variable to it. We can also customize the look by changing the shape type (RECT or OVAL) and the color.

Search for the TODO referring to "FaceBoxRenderer" and paste the following into the class:

```
mFaceBoxRenderer = view.findViewById(R.id.edgeFaceBoxRender);
mFaceBoxRenderer.setShapeType(FaceBoxRenderer.ShapeType.OVAL);
mFaceBoxRenderer.setColor(Color.CYAN);

```

## Implement MobiledgeX Computer Vision Library Interfaces

In this section, we will implement custom versions of the methods defined by the library’s interfaces.

### ImageProcessorInterface

The [ImageProcessorInterface](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/master/android/MobiledgeXSDKDemo/computervision/src/main/java/com/mobiledgex/computervision/ImageProviderInterface.java) defines methods that must be implemented by classes that process images from the camera. Because our FaceProcessorFragment extends [com.mobiledgex.computervision.ImageProcessorFragment](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/master/android/MobiledgeXSDKDemo/computervision/src/main/java/com/mobiledgex/computervision/ImageProcessorFragment.java), these methods are already implemented. However, we want to perform custom processing every time an image is available, so we will be overriding onBitmapAvailable().

Search for the TODO referring to "ImageProcessorInterface" and paste the following into the class:

```
/**
 * Perform any processing of the given bitmap.
 *
 * @param bitmap  The bitmap from the camera or video.
 * @param imageRect  The coordinates of the image on the screen. Needed for scaling/offsetting
 *                   resulting pose skeleton coordinates.
 */

@Override
public void onBitmapAvailable(Bitmap bitmap, Rect imageRect) {
    if(bitmap == null) {
        return;
    }

mImageRect = imageRect;
mServerToDisplayRatioX = (float) mImageRect.width() / bitmap.getWidth();
mServerToDisplayRatioY = (float) mImageRect.height() / bitmap.getHeight();

Log.d(TAG, &amp;quot;mImageRect=&amp;quot;+mImageRect.toShortString()+&amp;quot; mImageRect.height()=&amp;quot;+mImageRect.height()+&amp;quot; bitmap.getWidth()=&amp;quot;+bitmap.getWidth()+&amp;quot; bitmap.getHeight()=&amp;quot;+bitmap.getHeight()+&amp;quot; mServerToDisplayRatioX=&amp;quot; + mServerToDisplayRatioX +&amp;quot; mServerToDisplayRatioY=&amp;quot; + mServerToDisplayRatioY);

mImageSenderEdge.sendImage(bitmap);

}

```

### ImageServerInterface

The [ImageServerInterface](https://github.com/mobiledgex/edge-cloud-sampleapps/blob/master/android/MobiledgeXSDKDemo/computervision/src/main/java/com/mobiledgex/computervision/ImageServerInterface.java) defines methods that must be implemented by classes that send images to the MobiledgeX Face Detection server and receive results back. These methods do things like draw rectangles around identified faces, or update the network latency stats. We will be implementing custom versions of many methods in the interface.

Search for the TODO referring to "ImageServerInterface" and paste the following into the class:

```
/**
 * Update the face rectangle coordinates.
 *
 * @param cloudletType  The cloudlet type determines which FaceBoxRender to use.
 * @param rectJsonArray  An array of rectangular coordinates for each face detected.
 * @param subject  The Recognized subject name. Null or empty for Face Detection.
 */

@Override
public void updateOverlay(final CloudletType cloudletType, final JSONArray rectJsonArray, final String subject) {
    Log.i(TAG, "updateOverlay Rectangles("+cloudletType+","+rectJsonArray.toString()+","+subject+")");
    new Handler(Looper.getMainLooper()).post(new Runnable() {
        @Override
        public void run() {
            if (getActivity() == null) {
                //Happens during screen rotation
                Log.e(TAG, "updateOverlay abort - null activity");
                return;
            }
        boolean mirrored = mCamera2BasicFragment.getCameraLensFacingDirection() ==
                CameraCharacteristics.LENS_FACING_FRONT
                &amp;amp;&amp;amp; !mCamera2BasicFragment.isLegacyCamera()
                &amp;amp;&amp;amp; !mCamera2BasicFragment.isVideoMode();

        Log.d(TAG, &amp;quot;mirrored=&amp;quot; + mirrored + &amp;quot; mImageRect=&amp;quot; + mImageRect.toShortString() + &amp;quot; mServerToDisplayRatioX=&amp;quot; + mServerToDisplayRatioX +&amp;quot; mServerToDisplayRatioY=&amp;quot; + mServerToDisplayRatioY);

        mFaceBoxRenderer.setDisplayParms(mImageRect, mServerToDisplayRatioX, mServerToDisplayRatioY, mirrored, prefMultiFace);
        mFaceBoxRenderer.setRectangles(rectJsonArray, subject);
        mFaceBoxRenderer.invalidate();
        mFaceBoxRenderer.restartAnimation();
    }

});

}
public void updateFullProcessStats(final CloudletType cloudletType, RollingAverage rollingAverage) {
final long stdDev = rollingAverage.getStdDev();
final long latency = rollingAverage.getAverage();
if(getActivity() == null) {
Log.w(TAG, "Activity has gone away. Abort UI update");
return;
}
getActivity().runOnUiThread(new Runnable() {
@Override
public void run() {
mLatencyFull.setText("Full Process Latency: " + String.valueOf(latency/1000000) + " ms");
mStdFull.setText("Stddev: " + new DecimalFormat("#.##").format(stdDev/1000000) + " ms");
}
});
}
@Override
public void updateNetworkStats(final CloudletType cloudletType, RollingAverage rollingAverage) {
final long stdDev = rollingAverage.getStdDev();
final long latency;
latency = rollingAverage.getAverage();
if(getActivity() == null) {
    Log.w(TAG, &amp;quot;Activity has gone away. Abort UI update&amp;quot;);
    return;

}
getActivity().runOnUiThread(new Runnable() {
    @Override
    public void run() {
       mLatencyNet.setText(&amp;quot;Network Only Latency: &amp;quot; + String.valueOf(latency/1000000) + &amp;quot; ms&amp;quot;);
       mStdNet.setText(&amp;quot;Stddev: &amp;quot; + new DecimalFormat(&amp;quot;#.##&amp;quot;).format(stdDev/1000000) + &amp;quot; ms&amp;quot;);            }

});

}

```

## Almost There

![Example 1: Face Detection](/developer/assets/how-to-android-workshop-add-face-detection-to-workshop-app/4.jpg "Example 1: Face Detection")

## Miscellaneous

### Remove "Not implemented" message

Search for the TODO referring to the "Not implemented" message. Paste the following:

```
mStatusText.setText("");

```

### Add getStatsText method

Search for the TODO referring to "getStatsText". Update the method to look like this:

```
public String getStatsText() {
    return mImageSenderEdge.getStatsText();

}

```

## Define Menu Item Actions

Our Face Detector has an options menu with a few items available, but they currently do nothing. Let’s define the actions for each menu item.

Search for the TODO referring to "onOptionsItemSelected". Paste the following:

```
@Override
public boolean onOptionsItemSelected(MenuItem item) {
    int id = item.getItemId();
    if (id == R.id.action_camera_swap) {
        mCamera2BasicFragment.switchCamera();
        SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(getContext());
        String prefKeyFrontCamera = getResources().getString(R.string.preference_fd_front_camera);
        prefs.edit().putInt(prefKeyFrontCamera, mCamera2BasicFragment.getCameraLensFacingDirection()).apply();
        return true;
    } else if (id == R.id.action_camera_video) {
        mCameraToolbar.setVisibility(View.GONE);
        mCamera2BasicFragment.startVideo();
        return true;
    } else if (id == R.id.action_camera_debug) {
        mCamera2BasicFragment.showDebugInfo();
        return true;
    }
    return false;

}

```

## Success!

If you start the Face Detection activity now and point the camera at your face, you should see a cyan oval drawn around it. Move the camera around a bit and notice how the shape tracks your face. Depending on your connection to the Face Detection Server, this tracking may be smooth or laggy.

### Face recognition uses:

- Functions with both front-facing and rear-facing cameras.
- Can recognize multiple faces in the same image.

- Supports both portrait and landscape mode.

![Example 2: Multiple Faces Recognized in Landscape Mode](/developer/assets/how-to-android-workshop-add-face-detection-to-workshop-app/5.jpg "Example 2: Multiple Faces Recognized in Landscape Mode")

## Going Farther

### Use closest cloudlet as Face Detection host

In this section we will use the results of the findCloudlet SDK call to determine what Face Detection server to connect to.

In **MainActivity.java**, in onNavigationItemSelected(), right before "startActivity(intent);", add the following:

```
if(mClosestCloudlet != null) {
    intent.putExtra("EXTRA_EDGE_CLOUDLET_HOSTNAME", mClosestCloudletHostName);

}

```

This will pass the hostname found by the MatchingEngine’s findCloudlet call. Now in **FaceProcessorFragment.java**, find this code:

```
String host = mHostDetectionEdge;

```

Right after that line, paste the following:

```
Intent intent = getActivity().getIntent();
String cloudletHostname = intent.getStringExtra("EXTRA_EDGE_CLOUDLET_HOSTNAME");
if(cloudletHostname != null) {
    host = cloudletHostname;

}

```

Now build and run the app again. After clicking the button to find the closest cloudlet, start the Face Detection activity. You are now connecting to the closest possible Edge host that is running the face detection server. At this point, you should now see much lower latency and smoother face tracking.

### Cloud/Edge comparison app

If you would like to see a more fully featured face detection app that compares a cloud server to an edge server and demonstrates the latency differences, you can replace your FaceProcessorFragment with one provided by the com.mobiledgex.computervision library. Follow these steps:

- Open **AndroidManifest.xml**.
- Add the ImageProcessorActivity activity that is included in the com.mobiledgex.computervision library. We will also include the Settings activity so we can tweak the behavior.


```
&lt;activity
    android:name="com.mobiledgex.computervision.ImageProcessorActivity"
    android:label="Face Detector"
    android:theme="@style/AppTheme.NoActionBar" /&gt;

&lt;activity
    android:name="com.mobiledgex.computervision.SettingsActivity"
    android:label="Settings" /&gt;

```

- Open **MainActivity.java**.
- Add the following import:


```
import com.mobiledgex.computervision.ImageProcessorActivity;

```

- In **MainActivity.java**, in onNavigationItemSelected(), change the intent to start with ImageProcessorActivity instead of FaceProcessorActivity. Your change should look like this:


```
Intent intent = new Intent(this, ImageProcessorActivity.class);

```

- Now when you start Face Detection, you will see 2 sets of latency numbers: Cloud in red, and Edge in green.
- You can tap the Settings icon to access the preferences for this activity where you can change several things:
- Change host names for both Cloud and Edge.
- Toggle extra latency statistics fields.
- Toggle latency test method.


## Face Recognition and Pose Detection

The com.mobiledgex.computervision library is capable of more than just Face Detection. You can access additional features by starting different included activities.

### Face Recognition


- Open **MainActivity.java**.
- In the onNavigationItemSelected method, replace FaceProcessorActivity with ImageProcessorActivity and add a boolean extra named "extra*face*recognition". That section will now look like this:


```
Intent intent = new Intent(this, ImageProcessorActivity.class);
intent.putExtra("EXTRA_FACE_RECOGNITION", true);

```

- Now the Face Detection activity will start in Recognition mode. If you are a new user who has never submitted face training data, the faces will most likely be identified as "Unknown".
- If you would like to submit face training data, choose "Sign In with Google" from the main menu and enter your Gmail account credentials.
- At that point, you can choose "Training Mode" from the options menu in the Face Detection activity.
- After several images are accepted by the Face Training Server and processed, your face should start to be recognized correctly.


## Pose Detection


- Open **AndroidManifest.xml**.
- Add the PoseProcessorActivity that is included in the com.mobiledgex.computervision library.


```
&lt;activity
    android:name="com.mobiledgex.computervision.PoseProcessorActivity"
    android:label="Pose Detector"
    android:theme="@style/AppTheme.NoActionBar" /&gt;

```

- Open **MainActivity.java**.
- Add the following import:


```
import com.mobiledgex.computervision.PoseProcessorActivity;

```

- In the onNavigationItemSelected method, redefine the Intent to be launched with the PoseProcessorActivity class. Replace ImageProcessorActivity with PoseProcessorActivity:


```
Intent intent = new Intent(this, PoseProcessorActivity.class);

```

- Now the Face Detection activity will start in Pose Detection mode.
- Select the rear camera and point at someone’s full body (or a group of people) to create a colored wireframe of their pose.


![Example 3: Pose Detection](/developer/assets/how-to-android-workshop-add-face-detection-to-workshop-app/6.jpg "Example 3: Pose Detection")

## Multi-Purpose App

You can add a new menu entry for each of these different detection modes, and demonstrate any of them without needing code changes in between. Hint: Additional menu items are added in **app/res/menu/activity*main*drawer.xml** and the different ways you launched the intent above, can be added as separate "if else" blocks in onNavigationItemSelected().

## Video Playback

In any of the modes, the camera class is capable of playing a canned video, one of which is included in the library. This is useful for running a demo where the Android phone may be unattended at times. Try it out by tapping the options menu, and selecting "Play Video".

## Another Speed-Up: Persistent TCP Connection

By default, the MobiledgeX Computer Vision library communicates to the server running on the Edge cloudlet via a REST interface. Both our server and our library support a persistent TCP connection mode, which can achieve significant speed improvements. To use the persistent TCP connection mode, we just need to turn on that option. See Computer Vision Persistent TCP Connection for more background and details.

In **FaceProcessorFragment.java**, right after "mImageSenderEdge = new ImageSender", add the following:

```
ImageSender.setPreferencesConnectionMode(ImageSender.ConnectionMode.PERSISTENT_TCP, mImageSenderEdge);
```

