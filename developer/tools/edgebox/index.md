---
title: "Local Edge Testing : EdgeBox"
long_title: "Tutorial : Local Edge Testing using MobiledgeX EdgeBox"
overview_description:
description:
A How-To Guide for Developers to set up MobiledgeX EdgeBox for local edge computing testing.

---

MobiledgeX makes it easy for Developers who want to experience the power of Edge Computing. With just 3 lines of code and their laptop, Developers can immediately take advantage of the MobiledgeX Platform and Services to create and deploy their applications onto a cloudlet, thereby simulating the deployment onto a cloudlet. MobiledgeX developed **EdgeBox** to demonstrate how easy it is to use our Platform for edge computing applications, where after you deployed, you can ensure the highest performance of your applications through continuous testing and end-to-end validation, all done locally and with zero impact on any existing networking infrastructure. Try out EdgeBox today and see how easy it is to bring your edge applications closer to your users.

Watch the Video: <div class="col-xs-12 col-md-10 offset-md-1 col-lg-8 offset-lg-2">
  <div class='embed-container'>
    <iframe src='https://www.youtube.com/embed/UtEAqdv6kRE' frameborder='0' allowfullscreen>

</iframe>
  </div>

</div>

With EdgeBox, you can:

- Experience the power of edge computing
- Quickly spin up edge sites
- Perform things like functional testing on your edge applications through our easy-to-use MobiledgeX Console.
- Build a CI/CD pipeline (coming soon)

### Prerequisites

- Linux: Ubuntu 18.04 or MacOS: 10.14 (Mojave) or later
- [MobiledgeX](https://console.mobiledgex.net/#/) account with login credentials
- Docker installed. The MobiledgeX Docker registry is used to connect EdgeBox to the MobiledgeX Console. You will use the   same MobiledgeX login credentials to log into the Docker registry for MobilegeX
- Python3 installed

## Step 1 Install EdgeBox locally on your laptop


At the terminal prompt, type `pip3 install edgebox`. If you’ve already installed EdgeBox and need to upgrade, simply type `pip3 install --upgrade edgebox`.<br />
2, Log into your MobiledgeX Docker registry by typing in `docker login -u &lt;username&gt; docker.mobiledgex.net` and the **Password** prompt will appear.
- Once you enter your password, you should see a **Login Succeeded** message. If you were unsuccessful, try entering your credentials again.


## Step 2 Create an EdgeBox


- At the terminal prompt, type `edgebox create testedge`. You can give your EdgeBox any name. For this tutorial, we will name it *testedge*.
A series of questions will appear in the terminal to complete the EdgeBox configuration process.<br />
a. **Console Host:** Use the same *username* you used to login to your Docker login.<br />
b. **Console username for console.mobilegex.com ("name"):** The username used to login to the MobiledgeX Console.<br />
c. **Console password for console.mobiledgex.net:** The password used to login to the MobilegeX Console.<br />
d. **Region:** Select your desired region closest to you.
e. **Cloudlet Org:** Type in a Cloudlet Org from the list.
f. **Cloudlet:** Use the default or rename it.<br />
g. **Latitude and Longitude:** Provide one for your cloudlet, or use the default. MobiledgeX will then map the geolocation of that cloudlet to applications that want to connect to it.


**Note:** If you reached this point and the download fails, go back and run the `edgebox create` command again.

- Review your configuration, and if everything looks good, Type **Y** at the *Continue?* prompt. The process to create your cloudlet will begin.


Once you see **Cloudlet is up** at the Terminal prompt, the cloudlet is now running on your laptop.

![Cloudlet status in Terminal](/developer/assets/developer-ui-guide/cloudlet-up.png "Cloudlet status in Terminal")

### EdgeBox Commands

For a list of available EdgeBox commands, simply type `edgebox --help`.

The following commands are available:

```
$ edgebox --help
usage: edgebox [-h] [--debug] [--confdir CONFDIR] {create,delete,list,show,startall,version} ...
positional arguments:
 {create,delete,list,show,github,startall,version}
                       sub-command help
   create              create edgeboxes
   delete              delete edgeboxes
   list                list edgeboxes
   show                show edgebox details
   startall            start all active edgeboxes
   version             display version

```

## Step 3 Verifying the Cloudlet


- Log in to your [MobiledgeX Console](https://console.mobiledgex.net/#/).
- Navigate to the Organizations page. You should see an **Operator Organization** already created, named edgebox-**cloudlet-name**.
- Click **Manage** for that **Operator Organization** and navigate to the Cloudlets menu on the left-navigation.
- In the map view, scroll over to the region where you created your cloudlet and verify that it exists.


![Verifying Cloudlet](/developer/assets/developer-ui-guide/verify-cloudlet-edgebox.png "Verifying Cloudlet")

## Step 4 Create an Application to Deploy onto the Cloudlet


- On the [MobiledgeX Console](https://console.mobiledgex.net/#/), return to the Organizations page where you will create a **Developers Organization**.
- Click the right arrow for Developers, as shown below.


![Create Developer Organization](/developer/assets/developer-ui-guide/create-devorg-edgebox.png "Create Developer Organization")

The Create Organization screen opens.

![Create Organization screen](/developer/assets/developer-ui-guide/create-org-edgebox.png "Create Organization screen")


- Populate all required fields, name your **Developer Organization**, and click **Create**.
- Optionally, you can add users to your Organization. Otherwise, skip this step.
- Click **Return to Organizations**.


You are now ready to add your **Developer Organization** to the cloudlet.

## Step 5 Add Developer Organization to Cloudlet

Follow the steps below to add your **Developer Organization** to your cloudlet.

On the MobiledgeX Console, with the **Operator Organization** selected, navigate to the Cloudlet Pools menu on the left navigation.<br />
From the Cloudlet Pools page, you can see that a cloudlet pool has already been created for your cloudlet, named *edgebox-**cloudlet-name**-pool*.
Click the Actions menu, and scroll down to **Invite Organization**.<br />
The Organizations page opens.
- For Organization, type in the name of the **Developer Organization** that you previously created.
- Click **Create Invitation**. The invite will be sent out, and received by your **Developer Organization**.
- Return to the Organizations page and switch to the **Developer Organization** by clicking **Manage**.
- Navigate to the Cloudlet Pools menu, where under the Status column, you will see the **Pending** state. This is the pending invite sent from the cloudlet pool created previously for the **Operator Organization**.
- Under the Actions menu, click **Accept**, and then click **Yes** to confirm. After accepting the invite, the status within the Cloudlet Pools page will change to **Accepted**.


The **Developer Organization** can now create applications on **EdgeBox**.

## Step 6 Create and Deploy Applications on EdgeBox


- Return to the MobiledgeX Console and navigate to the Apps menu on the left navigation. The Create Apps page opens.
Populate all the required fields.<br />
a. **Region:** Select the same region you specified in **Step 2 Create an EdgeBox**.<br />
b. **App Name:** Type in the app name as *facedetection*, which is the name of the sample app we provided in https://hub.docker.com/r/mobiledgexsamples/edge-face-detection.<br />
c. **App Version:** Type in **2.2**.<br />
d. **Deployment Type:** Select docker from the drop-down list.<br />
e. **Image Path:** Provide the image path as registry.hub.docker.com/mobiledgexsamples/edge-face-detection:2.2.<br />
f. **Default Flavor:** Select **US&gt;m4.small** as the default size.<br />
g. **Ports:** Define the ports you wish to open. For the face detection sample app used, specify the first TCP port as **8008**, and the second TCP port as **8011**.
- Click **Create**.
- Navigate to the Apps page and verify the App definition was created successfully.
- Once verified, under the Actions menu, scroll down and select **Create Instance** to spin up an application instance. The Create App Instances page opens.
Populate all required fields.<br />
a. **Operator:** Select *edgebox-**cloudlet-name**-org*.<br />
b. **Cloudlet:** Select <em>edgebox-**cloudlet-name**
</em>.<br />
c. **Auto Cluster Instance:** Enable this option.
- Click **Create**.  You will see **Progress** status appear showing the process of spinning up the application instance while it runs through the process of setting up a cluster as well as the docker container.


![Progress Bar](/developer/assets/developer-ui-guide/progress-edgebox.png "Progress Bar")


- Navigate to the App Instances menu on the left navigation to open the  Apps Instance page. You should see the application instance being monitored by the MobiledgeX Platform.
- Click on the App Instance and the following page appears.


![App Instances URI](/developer/assets/developer-ui-guide/app-inst-uri-edgebox.png "App Instances URI")


- Scroll down the page until you see **URI**, then copy and paste the URI address into a browser using port `8008`.
- You should see the **Computer Vision Face Detection** application working.


![Computer Vision Face Detection](/developer/assets/developer-ui-guide/comp-vision-app-edgebox.png "Computer Vision Face Detection")

Since this Docker instance is running locally, you can switch to a `localhost:8008`, where you can set up a pseudo HTTPS connection and use the webcam to run face detection.

That’s it! You have successfully set up **EdgeBox**.

