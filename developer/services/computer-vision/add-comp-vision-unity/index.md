---
title: Unity Computer Vision SDK
long_title: Add Computer Vision to your Unity Project
overview_description: 
description: 
Learn how to add the MobiledgeX OpenCV Computer Vision library to your Unity Project

---

**Last Modified:** 11/24/21

This guide describes how to add the MobiledgeX OpenCV Computer Vision library to your Unity Project. For the latest application credentials to use the Computer Vision library deployed to MobiledgeX, please refer to [Step 3](/developer/services/computer-vision/add-comp-vision-unity/index.md) below.
<div class="embed-responsive embed-responsive-16by9">
<!-- Youtube and Video -->
<iframe class="embed-responsive-item" src="https://www.youtube-nocookie.com/embed/WdcnHoE9B0k" ...>
</iframe>
</div>

## Step 1: Add the MobiledgeX Unity SDK Package


- In your Unity Project, select **Window &gt; Package Manager**.<br>


![](/developer/assets/add-comp-vision-unity/package-manager.png "")


- In the Unity Package Manager, select **Add package from git URL...**


![](/developer/assets/add-comp-vision-unity/add-package-git.png "")


- Copy and paste this URL: `https://github.com/mobiledgex/edge-cloud-sdk-unity.git` Now, your MobiledgeX SDK is added to your Project packages.


If you have a Unity version older than **2019.3**, please check [our Unity SDK doc](/developer/sdks/unity-sdk/unity-sdk-download#20192x/index.md) for installation steps. We also recommended that you upgrade your Unity version.

## Step 2: Import **ComputerVision** to your Unity Project


- From the menu bar, select **MobiledgeX &gt; Examples &gt; ComputerVision**.


![](/developer/assets/add-comp-vision-unity/example-compvision.png "")


- Select **Import**.


![](/developer/assets/add-comp-vision-unity/import.png "")

## Step 3: Add Applications credentials


- Select **MobiledgeX &gt; Setup**.


![](/developer/assets/add-comp-vision-unity/setup.png "")


- Enter Application Credentials to connect your Unity Project to the ComputerVision server.


- **Org Name:** MobiledgeX-Samples
- **App Name:** ComputerVision-GPU
- **App Version:** 2.2
- **Region:** EU<br>

![Setup screen fields](/developer/assets/add-comp-vision-unity/samples.png "Setup screen fields")


- Select **Setup**. Your Unity Project is ready for **ComputerVision**.


## Step 4: Play the Computer Vision Scene


- In the Assets folder, go to the **ComputerVision** folder and select the ComputerVision scene and press **Play**.


**That’s it! You’re done.**

## Understanding the ComputerVision Component

The ComputerVision Component is provided to make integration with the Computer Vision server simple without needing to code any interactions. The ComputerVision Component uses the MobiledgeX Location Service component to connect you to the nearest cloudlet (data center) where the computer vision back-end is deployed. Below are all the configurable parameters provided by the component that developers can leverage to customize the service as well as visuals displayed from data processed by the Computer Vision server.

![Computer Vision Component for Unity](/developer/assets/add-comp-vision-unity/location-service.png "Computer Vision Component for Unity")

- **Connection Mode** Select the desired connection, either WebSocket or REST. WebSocket is a stateful protocol; however, REST relies on stateless protocol instead. WebSocket connections can scale vertically on a single server, whereas REST, which is HTTP based, can scale horizontally.
- **Service Mode** Face Detection, Object Detection.
- **Image Shrinking Ratio** The image will be resized before sending it to the server respecting the image aspect ratio. Image Shrinking Ratio is proportional to Detection Quality &amp; inversely proportional to the Full Detection Process Latency. Image Shrinking Ratio value is between (0.1 to 0.4).
- **Face Rect Texture** For FaceDetection, the texture that is to be added on top of detected faces.
- **Confidence Threshold** The confidence threshold (0-100) differentiates between a high confidence level and a low confidence level.
- **High Confidence Texture** For Object Detection, Texture that is to be added on top of detected objects with a Confidence level higher than the confidence Threshold.
- **Low Confidence Texture** For Object Detection, Texture that is to be added on top of detected objects with a Confidence level lower than the confidence Threshold.
- **Object Class Font**
- **Show Confidence Level** Whether to show the confidence level next to the detected object or not, ex. (car 100%).
- **Object Class Font Size** For object detection, the font of the object class font.
- **High Confidence Font Color** For object detection, the color of the object class font if the confidence level is above or equal the confidence threshold.
- **Low Confidence Font Color** For object detection, the color of the object class font if the confidence level is below the confidence threshold.

