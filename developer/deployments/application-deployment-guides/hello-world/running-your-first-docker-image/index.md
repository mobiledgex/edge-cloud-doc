---
title: Running a Docker Image as an Application Instance
long_title:
overview_description:
description:
Create and deploy a dockerized webserver on the MobiledgeX platform

---

**Last Modified:** 11/16/2021

In this guide, we will show how to run a Docker Image as a Container Application Instance on MobiledgeX. For this guide, we will be assuming that you have already uploaded your Docker image to the MobiledgeX Docker Repository as was done in the [Uploading Your First Docker Image Guide](https://dev-publish.mobiledgex.com/deployments/application-deployment-guides/hello-world/running-your-first-docker-image).

**We will also be using the [Hello World NGINX Docker Image](https://dev-publish.mobiledgex.com/deployments/application-deployment-guides/hello-world/running-your-first-docker-image#step-3-uploading-your-docker-image-to-mobiledgex) uploaded at the end of that guide as our example image we want to deploy.**

To get started, login to the [MobiledgeX Console](https://console.mobiledgex.net/). If you do not have an account, please head over to our [Getting Started page](https://dev-publish.mobiledgex.com/deployments/application-deployment-guides/hello-world/(/getting-started)).
<div class="embed-responsive embed-responsive-16by9">
<!-- Youtube and Video -->
<iframe class="embed-responsive-item" src="https://www.youtube-nocookie.com/embed/Kz-BjfnTxU8" ...>
</iframe>
</div>

## Step 0: Create a Cluster Instance (Optional)

MobiledgeX offers an auto-cluster feature when creating an Application Instance in [Step 2](https://dev-publish.mobiledgex.com/deployments/application-deployment-guides/hello-world/running-your-first-docker-image#step-2-deploy-your-application-as-an-application-instance), which will setup the Cluster resources needed before running your application. If you choose to use the auto-cluster feature as opposed to defining the cluster parameters like below, you can skip this step.

To get started, select **Cluster Instances** in the left navigation. The Cluster Instances page opens. A Cluster Instance represents the compute resources that are needed to run your Docker image. You can learn more about Cluster Instances in our [Cluster Instances](https://dev-publish.mobiledgex.com/deployments/deployment-workflow/clusters) guide.

In the top right of the Cluster Instances page, select the plus sign icon to start defining a new Cluster Instance. This will open up a form that needs to be filled out. For our Hello World application, fill out the information with the following :

- Region : **EU**
- Name : **hwcluster**
- Operator: **TDG**
- [Cloudlet](https://dev-publish.mobiledgex.com/deployments/deployment-workflow/cloudlets) : Pick any one. For example, **Hamburg-Main**
- [Deployment Type](https://dev-publish.mobiledgex.com/deployments/deployment-workflow/supported-apps-types) : **Docker**
- IP Access: **Dedicated**
- [Flavor](https://dev-publish.mobiledgex.com/deployments/deployment-workflow/flavors): **m4.small**

![](/assets/developer-ui-guide/create-cluster.png "")

Then select **Create**, which will begin the process allocating the necessary resources for your Application on the Cloudlet you selected.

## Step 1: Define your Application

Select **Apps** from the left navigation. The Apps page opens. Here, you will define the parameters needed for your Docker Image to run successfully. For more information on Application Definition, you can refer to [this guide](https://dev-publish.mobiledgex.com/deployments/deployment-workflow/app-definition). Then, just like on the Cluster Instances page, select the plus sign icon to start filling out the Application Form.

For our Hello World image, input the following:

- App Name: **HelloWorld**
- App Version: **1.0**
- [Deployment](https://dev-publish.mobiledgex.com/deployments/deployment-workflow/supported-apps-types): **Docker**
- Access Type: **Direct**
- Image Path: **docker.mobiledgex.net/helloworld/images/helloworld:1.0** (this should pre-populate based on the name and version provided)
- [Default Flavor](https://dev-publish.mobiledgex.com/deployments/deployment-workflow/flavors): **m4.small**
- Ports: Select the plus sign icon to add one port and then add the following:

- Port Number: **80**
- Protocol: **TCP**

</li>

![](/assets/create_app.png "")

### Notices

- The App Name and Version provided in the form do NOT have to match the App Name and Version of your Docker Image, but it is recommended to keep them the same
- The **Default Flavor** is only used if we do not create a Cluster and use it in the next step. If you created a Cluster above in [Step 0](https://dev-publish.mobiledgex.com/deployments/application-deployment-guides/hello-world/running-your-first-docker-image#step-0-create-a-cluster-instance-optional) and plan to use it, this field will NOT be used.

Select **Create**, which will Validate and Save our Application information.

## Step 2: Deploy your Application as an Application Instance

Lastly, now that we have set up the resources needed to run our application (Cluster) and defined the parameters of our server (Application Definition), we can now run our Application as an [Application Instance](https://dev-publish.mobiledgex.com/deployments/deployment-workflow/app-instances). You can think of this as running `docker container run` on a [MobiledgeX Cloudet](https://dev-publish.mobiledgex.com/deployments/deployment-workflow/cloudlets).

On the Apps Page, click on the menu button for the **HelloWorld** Application we just defined and select **Create Instance**.

This opens up the Application Instance creation form. Input the following:

- Operator: **TDG**
- [Cloudlet](https://dev-publish.mobiledgex.com/deployments/deployment-workflow/cloudlets): **Hamburg-Main** (the same one you selected for your cluster)
- [Flavor](https://dev-publish.mobiledgex.com/deployments/deployment-workflow/flavors): **m4.small**

If you DID create a Cluster Instance in Step 0,

- Auto-Cluster: **Keep Off**
- [Cluster](https://dev-publish.mobiledgex.com/deployments/deployment-workflow/clusters): **hwcluster**

If you DID NOT create a Cluster Instance in Step 0,

- Auto-Cluster: **Turn On**
- IP Access: **Dedicated**

![](/assets/create_app_inst.png "")

Select **Create**, which will start the process of running your image on our cloudlet, in this case **Hamburg-Main**. Give the process a couple minutes and then if it is all successful, head over to the **Application Instances** tab to see your newly created Application Instance.

## Step 3: Test Your Application

On the App Instances page, select the **HelloWorld** Application Instance you just created, which will provide a status of the Application. You should see a field called URI, which is the publicly accessible domain unique to your instance. For HelloWorld, copy and paste that into a web browser and you should now see our beautiful Hello World webpage.

![](/assets/exampleinstance.png "")

