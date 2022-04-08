---
title: Create and Upload Your First Docker Image
long_title: Create and Upload Your First Docker Image to MobiledgeX
overview_description: 
description: 
Create a Hello World Docker Image using a NGINX Webserver and Upload that Docker Image to MobiledgeX

---

**Last Modified:** 11/15/21

In this tutorial, we will be creating a very simple web server using Docker and NGINX, run it locally and then upload that Docker image of the server to MobiledgeX.

By the end of this guide, you should be able to run the Docker Image locally and see a Hello World web page that looks exactly like this: [https://reservable10.hamburg-main.tdg.mobiledgex.net:80/](https://reservable10.hamburg-main.tdg.mobiledgex.net:80/)

<div class="embed-responsive embed-responsive-16by9">
<!-- Youtube and Video -->
<iframe class="embed-responsive-item" src="https://www.youtube-nocookie.com/embed/9pIZ8y6rklA" ...>
</iframe>
</div>

## What Is Docker?

Briefly, [Docker](https://www.docker.com/) is a set of tools that was released in 2013. Docker allows you to easily leverage other applications as images (like we will be doing here with [NGINX](https://hub.docker.com/_/nginx)) and build off them to create your own server-side applications. Your applications can then be built into Docker images by defining instructions needed to setup your applications in a [Dockerfile](https://docs.docker.com/engine/reference/builder/). You can then use the Docker Engine to run any Docker image as a [Docker Container](https://www.docker.com/resources/what-container) of your application.

Another way to frame this is that a Docker Image is the compiled version of your application and a Docker Container is a running instance of the Image.

### This provides two key advantages:


- Applications can be moved from one Docker environment to another and consistently work.
- Applications can easily be scaled up and scaled down to meet real time user demands.


In the context of MobiledgeX, this is extremely valuable as it allows your application to easily run and scale across various mobile operator edge infrastructure around the world.

While not the only way to deploy server applications on MobiledgeX, Docker is a straightforward way to work with MobiledgeX and the recommended approach for developers if possible in production use cases.

## Step 0: Install Docker Desktop

If you have not already done so, please install [Docker Desktop](https://www.docker.com/products/docker-desktop) from the [Docker Getting Started](https://www.docker.com/get-started) page. This will install a suite of tools such as Docker, Docker-Compose, a dashboard to monitor the images and containers on your computer, as well as other advanced tools.

For developers using Windows, MobiledgeX at this time **only supports Linux based Docker images**. Please refer to this documentation that describes how to setup Windows to run Linux based containers: [https://docs.docker.com/docker-for-windows/](https://docs.docker.com/docker-for-windows/)

Once that has been installed, you should be able to open up a terminal and run `docker -v`, which will print out the version of Docker you just installed.

## Step 1: Running Your First Docker Web Server

Let’s start by getting the base version of [NGINX](https://hub.docker.com/_/nginx) up and running. In a command line terminal, type the command:

`docker container run --name nginx -p 8080:80 nginx:latest`

This command will be running a few different tasks, which might take a minute to complete. Once you see “ready for start up” printed in the terminal, head over to a web browser and type the address “localhost:8080”

![Docker Run NGINX](/developer/assets/hello-world/dockerrun.png "Docker Run NGINX")

You should now see the message **Welcome to nginx!** Congratulations, in one line you just spun up your first docker web server locally!

![Welcome to nginx!](/developer/assets/hello-world/nginx.png "Welcome to nginx!")

Let’s break down the command in a little more detail:

- `docker container run` is the syntax that is used to run a docker image as a container.
- `--name nginx` is an optional parameter used to to name our container nginx. If none is provided, a random name will be generated.
- `-p 8080:80` is another optional parameter that forwards requests from port 8080 to 80, which is the port NGINX uses. This is convenient for testing in case you have other applications on our computer that may be using port 80. This is the reason why we access NGINX with localhost:8080.
- `nginx:latest` is a required parameter that specifies which Docker image to run. This is broken down into the name of the image “nginx”, followed by a colon and then “version number”. “latest” specifies the latest version number that has been published by nginx.

To stop the server, you can do Ctl-C in the Terminal. Alternatively, you can use the [Docker Dashboard](https://docs.docker.com/desktop/dashboard/) to stop the container.

![](/developer/assets/hello-world/dockerdashboard.png "")

## Step 2: Creating your First Docker Image

Now that we used the [NGINX Docker Image](https://hub.docker.com/_/nginx) and confirmed it works, we can build a custom web server leveraging it.

Create an empty [Dockerfile](https://docs.docker.com/engine/reference/builder/) (no extension) and then add the following :

```

# use the nginx base image

FROM nginx:latest

# Download a static HTML page and install that as the index.html into our image at the nginx root directory of the server

RUN curl [https://reservable10.hamburg-main.tdg.mobiledgex.net:80/](https://reservable10.hamburg-main.tdg.mobiledgex.net:80/) &gt; /usr/share/nginx/html/index.html

# expose Port 80 for nginx to serve our web page

EXPOSE 80

# optional: start command needed for all docker images to be run when starting a container. in this case, if not included, the nginx base image will call this command

CMD ["nginx", "-g", "daemon off;"]
```

With these instructions, we have leveraged the base image of NGINX and customized it with a simple Hello World HTML page. To see this new HTML page, we need to build these instructions into our own Docker Image.

We can do so by running the following command in the directory that contains our Dockerfile:

`docker image build -t helloworld:1.0 .`

This will run each instruction step by step from our [Dockerfile](https://docs.docker.com/engine/reference/builder/) and build that into an image that we can run just like we did with [NGINX](https://hub.docker.com/_/nginx).

- The `-t` parameters allows us to tag ( in others words, name ) the image with an application image name and version number.
- The `.` tells the command which directory to search for the Dockerfile.

Then just like we did with [NGINX](https://hub.docker.com/_/nginx) we can run the image as a container with this command.

`docker container run --name helloworld -p 8080:80 helloworld:1.0`

To test this, head over to `localhost:8080` again in your browser and you should now see this page (if you don’t see this, your browser may have cached the old page, so refresh the page).

![Hello World!](/developer/assets/hello-world/helloworld.png "Hello World!")

## Step 3: Uploading Your Docker Image To MobiledgeX

For this, you will need an account and organization setup on MobiledgeX. If you do not have an account, head over to our [Getting Started page](https://dev-publish.mobiledgex.com/getting-started). If you have not setup an organization, you can refer to this [guide on organizations](https://dev-publish.mobiledgex.com/deployments/accounts/org-users) for how to do so.

- Login to the MobiledgeX Docker repository using our account username and password. **Replace with your MobiledgeX account username.**


`docker login -u &lt;your username&gt; docker.mobiledgex.net`


- Tag your image for use on MobiledgeX. For the hello world image we just created, you can use the following. **Make sure to replace **
`&lt;your organization&gt;` with your actual organization name you created on MobiledgeX.


`docker tag helloworld:1.0 docker.mobiledgex.net/&lt;your organization&gt;/images/helloworld:1.0`

More generically for any Docker image the command is:

`docker tag &lt;your application&gt; docker.mobiledgex.net/&lt;your organization&gt;/images/&lt;application name&gt;:&lt;version&gt;`


- Upload this newly tagged image to the MobiledgeX repository. **Replace **
`&lt;your organization&gt;` the MobiledgeX organization name.


`docker push docker.mobiledgex.net/&lt;your organization&gt;/images/helloworld:1.0`


- Lastly, we recommend logging out.


`docker logout docker.mobiledgex.net`

## Where to Go From Here

Congratulations on uploading your first Docker Image to MobiledgeX! Next, we will look at how you can run this uploaded Docker Image as an Application Instance on the MobiledgeX Mobile Operator Edge.

- [Deploy Your Docker Image on MobiledgeX](https://dev-publish.mobiledgex.com/deployments/application-deployment-guides/hello-world/running-your-first-docker-image)

If you are interested in deploying our Computer Vision Sample application, you can take a look at our Computer Vision Sample Apps guides.

- [Deploying the MobiledgeX Computer Vision Sample Docker Image](https://dev-publish.mobiledgex.com/services/computer-vision/how-to-deploy-a-backend-application-to-mobiledgex)

