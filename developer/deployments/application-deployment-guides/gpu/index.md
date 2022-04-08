---
title: Deploy GPU Applications
long_title: Deploy GPU Applications using the MobiledgeX Edge-Cloud Console
overview_description: 
description: 
How to deploy a GPU Application to the operator edge using the MobiledgeX Edge-Cloud Console

---

GPUs are an important enabler for many Edge Computing Applications, especially to reduce compute latency for many use cases. For a broader overview on how to deploy GPU applications, you can watch our session at [Nvidia GTC](https://www.nvidia.com/en-us/gtc/%C3%9F), where we show how to deploy a GPU docker compose deployment on MobiledgeX.

[Deploying Edge Computing GPU Applications onto the Telco Edge using MobiledgeX](https://www.nvidia.com/en-us/on-demand/session/gtcspring21-s31533/)

Some important considerations when deploying GPU Applications :

- Not all cloudlets support GPU applications. You can verify whether a cloudlet has GPU resources from the Cloudlets page in the MobiledgeX Edge-Cloud Console.
- GPUs are a very limited resource for most cloudlets. If you are run into a resource error with a GPU flavor, it is likely that all GPUs are being used for that cloudlet. Please contact [MobiledgeX Support](mailto:support@mobiledgex.com) if you run into such limitations.

In regions where GPUs are deployed, a set of GPU-specific flavors are available. These flavors contain the string `GPU`, for example, `m4.medium-gpu`.

## GPU-enabled Docker Deployment

**Note:** GPU support for Docker and Docker Compose is still actively under development. Please check back periodically for updates to GPU support.

You can deploy Docker containers to GPU-enabled hardware in the following ways:

- As a Docker image
- As Docker Compose file

### Deploy a GPU-enabled Docker image

If you would like to use a Docker image for your GPU deployment, select a GPU-enabled Flavor for the application if you are using auto-clustering, or choose a Flavor for manually created clusters. Then, follow the steps as described within [Upload images to MobiledgeX registries](https://dev-stage.mobiledgex.com/deployments/deployment-workflow/supported-apps-types#registry-commands) to upload your Docker image.

### Deploy a GPU-enabled Docker Compose file

While the easiest way to deploy a GPU-enabled container is to use a Docker image, as described above, you can also use Docker Compose. Simply follow the steps in [How to use a Docker Compose file as input](https://dev-stage.mobiledgex.com/deployments/deployment-workflow/supported-apps-types#option-1-docker-compose-file-as-input), and remember to identify the following in your Docker Compose file:

- Specify the Compose version as **2.3**
- Specify the option `runtime-nvidia` in your service definition
- Add `NVIDIAVISIBLEDEVICES=all` to your environment section

### Sample Docker Compose File

This sample compose file illustrates the correct use of arguments to enable GPU support, by using the [MobiledgeX ComputerVision Application](https://github.com/mobiledgex/edge-cloud-sampleapps/tree/master/android/MobiledgeXSDKDemo/computervision) as an example.

```
version: ’2.3’
services:
  compvision:
    image: docker.mobiledgex.net/mobiledgex/images/computervision-gpu:2020-09-15
    network_mode: "host"
    restart: unless-stopped
    runtime: nvidia
    environment:
     - NVIDIA_VISIBLE_DEVICES=all  

```

### Deploy a GPU-config for Kubernetes application

For Kuberenetes (K8s) based applications requiring access to GPU, you must specify the GPU config as part of the custom deployment manifest for each container requiring GPU access. However, if you’re using the auto-generated deployment manifest method where you are only required to specify the image path for the K8s manifest, there are no manual configuration steps required; we will automatically add the required configuration for you so long as the application instance flavor is a GPU flavor.<br>

The following example shows the required configuration that you must manually specify in your custom deployment manifest. The following lines: `resource: limits: nvidia.com/gpu:&lt;value&gt;`, are required as input.

**Note:** GPU count (value) cannot be more than what is specified in the flavor.

```
apiVersion: v1
kind: Pod
metadata:
  name: test-gpu-app

spec:
  containers:
  - name: test-gpu-app
    .
    .
    resources:
      limits:
         nvidia.com/gpu: 1

```

## vGPU Drivers Installation

The MobiledgeX platform supports [Nvidia vGPU](https://www.nvidia.com/en-us/data-center/virtual-solutions/) technology in order to maximize the performance of GPU workloads and help scale applications. vGPUs can be used in two cases:

- When using a vGPU sliced [flavor](/developer/deployments/deployment-workflow/flavors/index.md) on the MobiledgeX platform

- When virtualization a GPU to perform a task the GPU is not capable of i.e. Graphics Rendering on AI GPU like the Tesla T4

For [Virtual Machine](/developer/deployments/application-deployment-guides/virtual-machine/index.md) deployments, for the above use cases, you will be required to install vGPU drivers in your [application instance](/developer/deployments/deployment-workflow/app-instances/index.md). These drivers will vary from cloudlet to cloudlet and as such, you will need to download &amp; install these drivers into your application instance based on the cloudlet you have deployed your application. Drivers can be downloaded via the [MobiledgeX Controller APIs](https://api.mobiledgex.net/mc). Below are some examples using the MobiledgeX [mcctl CLI](/developer/tools/mcctl-guides/index.md) to find the relevant drivers for your application instance and get the download URL for the drivers. 

For Docker and Kubernetes applications, the correct vGPU driver for the cloudlet is automatically installed during [cluster](/developer/deployments/deployment-workflow/clusters/index.md) creation and such you will only need to need to define the GPU requirements in your Deployment Manifest as outlined above. 
### Show List of Drivers

```
❯ mcctl gpudriver show region=EU

key:
  name: nvidia-450
  organization: TDG

type: GpuTypePassthrough
builds:
- name: Linux-4.15.0-135-generic
  driverpath: https://example-url-to-download-gpu-driver-1
  kernelversion: 4.15.0-135-generic

- name: Windows10-amd64
  driverpath: https://example-url-to-download-gpu-driver-2
  operatingsystem: Windows

properties:
  FPS: "10"

```

### Get vGPU Driver URL

```
&gt; mcctl gpudriver getbuildurl region=EU gpudrivername=nvidia-450v gpudriver-org=TDG build.name=Linux-4.15.0-147-generic

buildurlpath: https://example-url-to-download-gpu-driver
validity: 20m0s
```

## GPU-enabled Docker Deployment Troubleshooting

- Ensure you correctly specify your arguments in the .yaml file, as shown in the example above.
- Make sure you select the appropriate GPU-enabled flavor.
- If you received errors indicating that "no host is available," the cloudlet you are attempting to use may not have any free GPU resources available. If that is the case, try deploying to a different cloudlet.

If problems continue to persist and you cannot deploy your Docker container to a GPU-enabled hardware, contact the [Support Team](mailto:support@mobiledgex.com) for further assistance.

<br>

