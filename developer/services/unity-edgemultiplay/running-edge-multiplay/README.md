---
title: Running the EdgeMultiplay Server Locally
long_title: 
overview_description: 
description: 
How To Setup the MobiledgeX Edge Multiplay Server Locally and Connect To It With the SDK

---

**Version:** 1.1
**Last Modified:** 04/02/2021

The Edge Multiplay Back-End Server is written in NodeJS and is avaliable as an Open Source project on [Github](https://github.com/mobiledgex/edge-mutiplay-node-server). Before running this server on the MobiledgeX Edge-Cloud platform or any cloud service, we recommend that you try running the server locally on your laptop and make sure your Unity client can successfully connect to it.

If you would like to test multiple devices on the same WiFi network, please make sure the following ports are open on your internal firewall for incomming connections.

- **TCP** : Port **3000**
- **UDP** : Port **5000**

Below, we will provide two approaches that you can take to run the server.

- Using [Docker](#option-1)
- Using [NodeJS](#option-2)


Have questions or suggestions to make this solution even better? [Join the MobiledgeX Community Discord!](https://discord.gg/VZPu6AvSp5)

## Option 1 : Using Docker to Run Edge Multiplay

### Prerequisites

- Install Docker Desktop : [https://www.docker.com/get-started](https://www.docker.com/get-started)
- Install Git : [https://git-scm.com/download](https://git-scm.com/download)

### 1. Download the EdgeMultiplay Server Source Code

<pre>
<code class="language-bash">git clone https://github.com/mobiledgex/edge-multiplay-node-server
cd edge-multiplay-node-server

```

### 2. Build the Edge Multiplay Image

`docker image build -t edgemultiplay:1.0 .`

If you are interested in learning more about what this command does, please refer to our [Hello World guide](/developer/deployments/application-deployment-guides/hello-world/uploading-your-first-docker-image#step-2-creating-your-first-docker-image).

### 3. Run the Edge Multiplay Container

`docker container run -p 3000:3000 -p 5000:5000/udp --name multiplay edgemultiplay:1.0`

You should now have a sucessfully running Docker container for Edge Multiplay.

![Edge Multiplay Running on docker container hosted locally](/developer/assets/edgemultiplay/EdgeMultiplay-Docker.png "Edge Multiplay Running on docker container hosted locally")

With that running, head to the **Unity section below** on how to use the SDK to connect to your local server.
## Option 2 : Using NodeJS to Run Edge Multiplay

### Prerequisites

- Install NodeJS : [https://nodejs.org/en/download](https://nodejs.org/en/download/)
- Install Git : [https://git-scm.com/download](https://git-scm.com/download)

### 1. Download the EdgeMultiplay Server Source Code

<pre>
<code class="language-bash">git clone https://github.com/mobiledgex/edge-multiplay-node-server
cd edge-multiplay-node-server

```

### 2. Run npm install to install all the dependencies needed for the server

`npm install`

### 3. Run npm start to start running the server

`npm start`

Now the server is running on your local host

![Edge Multiplay Running locally using node](/developer/assets/edgemultiplay/localhost_server_running.png "Edge Multiplay Running locally using node")

With that running, head to the **Unity section below** on how to use the SDK to connect to your local server.

## LocalHost Override in the MobiledgeX Unity SDK

In Unity, on the EdgeManager component. Check useLocalHostServer and add your local host address (127.0.0.1)

![Edge Manager Local Host Settings](/developer/assets/edgemultiplay/localhost.png "Edge Manager Local Host Settings")

## Where to Go From Here

If you are interested in deploying this server on MobiledgeX, please contact us either on [Discord](https://discord.gg/VZPu6AvSp5) or set a time to chat on our [Getting Started page](/developer/getting-started).

