---
title: Deploy Docker Compose using Multiple Files
long_title: How to Create a Docker-Compose Deployment Using Multiple Files
overview_description: 
description: 
Provides steps and examples on how to create a docker-compose deployment.

---

This guide walks you through how to create a docker-compose deployment using multiple files. We start by creating a simple compose file where it uses the nginx image that will serve a page in a directory that is passed into the container via a mount.

**Note:** The volume mount is relative to the root directory of where you will be building your .zip file. In our case, we will have a data directory that will be mounted into the container. This directory will be named *data* and will be mounted read-only, although it is possible to make this mount read/write.

**docker-compose.yml**

```
version: ’3’  
services:
web:
  image: nginx
  volumes:
      - ./data:/usr/share/nginx/html:ro
  ports:
    - "80:80"
  command: [nginx-debug, ’-g’, ’daemon off;’]  

```

Our page is a very simple HTML page that tells us that things worked.

**data/index.html**

```
&lt;!DOCTYPE html&gt;
&lt;html&gt;
    &lt;head&gt;
        &lt;title&gt;Included File Test&lt;/title&gt;
    &lt;/head&gt;
    &lt;body&gt;
        &lt;p&gt;If you’re seeing this, the included file worked...&lt;/p&gt;
    &lt;/body&gt;

&lt;/html&gt;  

```

We now create a manifest file that provides a path to our compose file (in this case, we are only using one file but this method allows you to use multiple files if necessary).

**manifest.yml**

```
dockercomposefiles:
- docker-compose.yml  

```

Our directory structure looks like this:

```
├── data
│   └── index.html
├── docker-compose.yml
└── manifest.yml  

```

We now create our .zip file:

```
$ zip -r compose-test.zip *
updating: data/ (stored 0%)
updating: docker-compose.yml (deflated 18%)
updating: data/index.html (deflated 32%)
  adding: manifest.yml (deflated 17%)  

```

Now, the file can either be uploaded to Artifactory (preferred method, since it uses the Artifactory security settings) or via a web server. Note that if you use a web server, MobiledgeX will need to be able to access it, which does not allow for the use of authentication.

```
$ curl -q -u demo -T ./compose-test.zip [https://artifactory.mobiledgex.net/artifactory/repo-demoorg/compose-test.zip](https://artifactory.mobiledgex.net/artifactory/repo-demoorg/compose-test.zip)
Enter host password for user ’demo’:
{
  "repo" : "repo-demoorg",
  "path" : "/compose-test.zip",
  "created" : "2020-05-21T15:42:12.759Z",
  "createdBy" : "demo",
  "downloadUri" : "[https://artifactory.mobiledgex.net/artifactory/repo-demoorg/compose-test.zip](https://artifactory.mobiledgex.net/artifactory/repo-demoorg/compose-test.zip)",
  "mimeType" : "application/zip",
  "size" : "909",
  "checksums" : {
    "sha1" : "696ca6354935c0fabc2b4e9853b77d1d259412f3",
    "md5" : "6075b505ca0e7417a213ccb8fe5c91d7",
    "sha256" : "666eac3c030ba5a58e738e4b79f7f326c14fcecb38a3284fb3c1d5510fcddcc1"
  },
  "originalChecksums" : {
    "sha256" : "666eac3c030ba5a58e738e4b79f7f326c14fcecb38a3284fb3c1d5510fcddcc1"
  },
  "uri" : "[https://artifactory.mobiledgex.net/artifactory/repo-demoorg/compose-test.zip](https://artifactory.mobiledgex.net/artifactory/repo-demoorg/compose-test.zip)"

}  

```

Once you have received confirmation in the form of the json format returned above, you can move on to the steps for deploying a docker instance through the MobiledgeX Edge-Cloud Console. There are two important things to keep in mind:

- You should leave the Image Path field blank in the console.
- You should provide the full URL for the .zip file in the Deployment Manifest text box. For example, the above .zip file should be referenced as `https://artifactory.mobiledgex.net/artifactory/repo-demoorg/compose-test.zip`.

