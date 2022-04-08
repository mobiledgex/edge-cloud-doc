---
title: How to use the mcctl utility for Developers
long_title: 
overview_description: 
description: 
Provides steps and examples on how to use the mcctl utility for developers.

---

**Version:** 1.0<br />
**Last Modified:** 7/1/2020

The MobiledgeX [Edge-Cloud Console](https://console.mobiledgex.net) is designed to enable developers to perform all of the necessary steps to deploy applications to the Edge. However, there are use cases where a web-based console is not the best option--for example, adding deployment logic to a make/build process, setting up a CI/CD pipeline, or enforcing change management policies for application updates.

To provide for these use cases, MobiledgeX exposes a RESTful API that provides the Edge-Cloud Console functionality. Although it is possible to access the API directly (via tools such as cUrl, resty, or postmate), MobiledgeX provides the `mcctl` utility program to interact with the API.

The `mcctl` utility provides the following:

- Stable interface to the API.
- Ability to obtain and store a JWT for authorization.
- Output formatting options (json, compact json, yaml).
- Online help/usage information.

The `mcctl` utility is available for Linux x86_64 and macOS, and can be downloaded from the MobiledgeX Artifactory repository. To download the `mcctl` utility, visit the [mcctl Installation and Setup Guide](/developer/tools/mcctl-guides/mcctl-reference/mcctl-installation-and-setup-guide).

## Exercise Parameters

The following parameters are used throughout this exercise.

- Source Repository: [Docker_NodeJS_Hello_World](https://github.com/skydvr01/Docker_NodeJS_Hello_World)
- Username: `demo`
- Organization: `demoorg`
- Image Name: `helloworld`
- Image Version: `2.0`
- Image Path: `docker.mobiledgex.net/demoorg/images`
- Deployment Type: `docker`
- Flavor: `m4.small`
- Cloudlet Org: `TDG`
- Cloudlet: `hamburg-main`
- Cluster: `hellocluster`

## Log In

To use `mcctl`, you must first log into the API to retrieve an authorization token.

```
$ mcctl login --addr  https://console.mobiledgex.net  name=jschmidt                   
password:
login successful
token saved to /home/jschmidt/.mctoken
$  

```

## Clone the Source Repository

```
$ git clone https://github.com/skydvr01/Docker_NodeJS_Hello_World.git
Cloning into 'Docker_NodeJS_Hello_World'...
remote: Enumerating objects: 22, done.
remote: Counting objects: 100% (22/22), done.
remote: Compressing objects: 100% (21/21), done.
remote: Total 22 (delta 8), reused 8 (delta 0), pack-reused 0
Unpacking objects: 100% (22/22), 6.30 KiB | 379.00 KiB/s, done.
$  

```

## Build and Upload the Docker Image

### Build the Docker Image

```

$ cd Docker_NodeJS_Hello_World
$ docker build -t helloworld:2.0 .
Sending build context to Docker daemon  106.5kB
Step 1/4 : FROM node:7-onbuild
7-onbuild: Pulling from library/node
ad74af05f5a2: Pull complete
2b032b8bbe8b: Pull complete
a9a5b35f6ead: Pull complete
3245b5a1c52c: Pull complete
afa075743392: Pull complete
9fb9f21641cd: Pull complete
3f40ad2666bc: Pull complete
49c0ed396b49: Pull complete
7af304825012: Pull complete
Digest: sha256:e506d4de7f21fc0cf51e2d2f922eb0349bd2c07f39dd6335e4338f92c9408994
Status: Downloaded newer image for node:7-onbuild

# Executing 5 build triggers
 ---&gt; Running in 9607e4ba380f

Removing intermediate container 9607e4ba380f
 ---&gt; Running in 8a411e89d05e

Removing intermediate container 8a411e89d05e
 ---&gt; Running in 677a952c4669

npm info it worked if it ends with ok
npm info ok
Removing intermediate container 677a952c4669
 ---&gt; 43f574a297b2

Step 2/4 : LABEL maintainer "alexander.donn@mobiledgex.com"
 ---&gt; Running in 7326130e2b9b

Removing intermediate container 7326130e2b9b
 ---&gt; eca3888c059a

Step 3/4 : HEALTHCHECK --interval=5s             --timeout=5s             CMD curl -f http://127.0.0.1:8000 || exit 1
 ---&gt; Running in c23ac72b1395

Removing intermediate container c23ac72b1395
 ---&gt; 078d3d91e71b

Step 4/4 : EXPOSE 8000
 ---&gt; Running in 68df598f66ca

Removing intermediate container 68df598f66ca
 ---&gt; 3c320a9cd114

Successfully built 3c320a9cd114
Successfully tagged helloworld:2.0
$  

```

### Log into the MobiledgeX Repository

```
$ docker login -u demo docker.mobiledgex.net
Password:
WARNING! Your password will be stored unencrypted in /home/jschmidt/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store
Login Succeeded
$   

```

### Tag the Docker Image

```
$ docker tag helloworld:2.0 docker.mobiledgex.net/demoorg/images/helloworld:2.0
$   

```

### Push the Docker Image to the Registry

```
$ docker push docker.mobiledgex.net/demoorg/images/helloworld:2.0               
The push refers to repository [docker.mobiledgex.net/demoorg/images/helloworld]
7dc5eba82ecd: Pushed
0bb28eb62de6: Pushed
6647b5cd7702: Pushed
2895be281ac1: Pushed
ab90d83fa34a: Pushed
8ee318e54723: Pushed
e6695624484e: Pushed
da59b99bbd3b: Pushed
5616a6292c16: Pushed
f3ed6cb59ab0: Pushed
654f45ecb7e3: Pushed
2c40c66f7667: Pushed
2.0: digest: sha256:99c172c4225ffde587c88bc8898dbf7ab963bf14ce9089c8acc8fd7343f8a273 size: 2841
$  

```

## Logout From the MobiledgeX Registry

```
$ docker logout docker.mobiledgex.net
Removing login credentials for docker.mobiledgex.net
$  

```

## Creating an Application

Use the `mcctl` utility with the correct parameters for your application.

```
$ mcctl --addr https://console.mobiledgex.net \
app create region=EU app-org=demoorg appname=helloworld appvers=2.0 \
imagetype=ImageTypeDocker \
imagepath=docker.mobiledgex.net/demoorg/images/helloworld:2.0 \
defaultflavor=m4.small accesstype=AccessTypeDefaultForDeployment \
accessports=tcp:8000 deployment=docker
$   

```

Check the application using `mcctl`.

```
$ mcctl --addr https://console.mobiledgex.net --output-format json \
 app show region=EU app-org=demoorg appname=helloworld appvers=2.0

[
  {
    "key": {
      "organization": "demoorg",
      "name": "helloworld",
      "version": "2.0"
    },
    "image_path": "docker.mobiledgex.net/demoorg/images/helloworld:2.0",
    "image_type": 1,
    "access_ports": "tcp:8000",
    "default_flavor": {
      "name": "m4.small"
    },
    "deployment": "docker",
    "access_type": 2
  }

]
$  

```

### Delete an Application

Use mcctl to delete an application.

```
$ mcctl --addr https://console.mobiledgex.net --output-format json \
app delete region=EU app-org=demoorg appname=helloworld appvers=2.0
{}
$  

```

Check that the application has been deleted.

```
$ mcctl --addr https://console.mobiledgex.net --output-format json \
app show region=EU app-org=demoorg appname=helloworld appvers=2.0
$

```

## Create a Cluster

Use the `mcctl` utility to create a cluster instance; this is used to run the application instance generated from the application definition we just added.

**Note:** The MobiledgeX API will automatically create a cluster (autocluster) for you if you pass through a cluster name beginning with autocluster to the AppInst creation payload.

```
$ mcctl --addr https://console.mobiledgex.net \  
clusterinst create region=EU cluster=hellocluster cloudlet-org=TDG cloudlet=hamburg-main \
cluster-org=demoorg flavor=m4.small ipaccess=IpAccessDedicated \
deployment=docker
message: Creating
message: Creating Dedicated VM for Docker
message: Creating Heat Stack for hamburg-main-hellocluster-demoorg
message: 'Creating Heat Stack for hamburg-main-hellocluster-demoorg, Heat Stack Status:
  CREATE_IN_PROGRESS'

message: 'Creating Heat Stack for hamburg-main-hellocluster-demoorg, Heat Stack Status:
  CREATE_COMPLETE'

message: Ready
message: Created ClusterInst successfully
$

```

Check the status of the cluster.

```
$ mcctl –addr https://console.mobiledgex.net –output-format json region \
clusterinst show region=EU cluster=hellocluster cloudlet-org=TDG \
cloudlet=hamburg-main cluster-org=demoorg [ { “key”: { “cluster_key”: \ { “name”:\
“hellocluster” }, “cloudlet_key”: { “organization”: “TDG”, “name”: “hamburg-main” },\
“organization”: “demoorg” }, “flavor”: { “name”: “m4.small” }, “liveness”: 1,\
“state”: 5, “ip_access”: 1, “allocated_ip”: “dynamic”, “node_flavor”: “m4.small”,\
“deployment”: “docker”, “status”: {} } $  

```

### Delete a Cluster Instance

```
$ mcctl --addr https://console.mobiledgex.net --output-format json \  
clusterinst delete region=EU cluster=hellocluster cloudlet-org=TDG cloudlet=hamburg-main cluster-org=demoorg
{
  "message": "Deleting"

}
{
  "message": "NotPresent"

}
{
  "message": "Deleted ClusterInst successfully"

}
$

```

Check that the cluster has been deleted.

```
$ mcctl --addr https://console.mobiledgex.net --output-format json \  
clusterinst show region=EU cluster=hellocluster cloudlet-org=TDG cloudlet=hamburg-main cluster-org=demoorg
$

```

## Create an Application Instance

Use the  `mcctl` utility to create an application instance; this will run an instance of the application that we defined on the cluster we just created (alternatively, the *autocluster* logic can be used here).

**Note:** The MobiledgeX API will automatically create a cluster (autocluster) for you if you pass through a cluster name beginning with *autocluster* to the AppInst creation payload.

```
$ mcctl --addr https://console.mobiledgex.net \  
appinst create region=EU app-org=demoorg appname=helloworld appvers=2.0 cloudlet-org=TDG \
 cloudlet=hamburg-main cluster=hellocluster cluster-org=demoorg

message: Seeding docker secret
message: Deploying Docker App
message: Configuring Firewall Rules and DNS
message: Creating
message: Ready
message: Created AppInst successfully
$

```

Check the Application Instance.

```
$ mcctl --addr https://console.mobiledgex.net --output-format json region \
 appinst show region=EU app-org=demoorg appname=helloworld appvers=2.0

[
  {
    "key": {
      "app_key": {
        "organization": "demoorg",
        "name": "helloworld",
        "version": "2.0"
      },
      "cluster_inst_key": {
        "cluster_key": {
          "name": "hellocluster"
        },
        "cloudlet_key": {
          "organization": "TDG",
          "name": "hamburg-main"
        },
        "organization": "demoorg"
      }
    },
    "cloudlet_loc": {
      "latitude": 53.5511,
      "longitude": 9.9937
    },
    "uri": "hellocluster.hamburg-main.tdg.mobiledgex.net",
    "liveness": 1,
    "mapped_ports": [
      {
        "proto": 1,
        "internal_port": 8000,
        "public_port": 8000
      }
    ],
    "flavor": {
      "name": "m4.small"
    },
    "state": 5,
    "runtime_info": {
      "container_ids": [
        "envoyhelloworld20",
        "helloworld20"
      ]
    },
    "created_at": {
      "seconds": 1592493852,
      "nanos": 519023900
    },
    "status": {},
    "power_state": 3,
    "vm_flavor": "m4.small"
  }

]
$

```

## Test the Application Instance

Retrieve the URI for the application; this example uses the [json](https://github.com/trentm/json) tool to parse the output:

```
$ mcctl --addr https://console.mobiledgex.net --output-format json /  
appinst show region=EU app-org=demoorg appname=helloworld appvers=2.0  |  json -ag uri
hellocluster.hamburg-main.tdg.mobiledgex.net
$  

```

### Use cUrl to test the application instance

```
$ curl http://hellocluster.hamburg-main.tdg.mobiledgex.net:8000 &lt;!DOCTYPE html&gt;  

```

<figure class="half">
  <img src="/assets/developer-ui-guide/hello-world.png" class="img-fluid slb" alt="">
  <figcaption>

</figcaption>
</figure>

```
$  

```

### Delete an Application Instance

```
$ mcctl --addr https://console.mobiledgex.net --output-format json \
 appinst delete region=EU app-org=demoorg appname=helloworld appvers=2.0 \

cluster=hellocluster cloudlet-org=TDG cloudlet=hamburg-main
{
  "message": "Setting ClusterInst developer to match App developer"

}
{
  "message": "Deleting"

}
{
  "message": "NotPresent"

}
{
  "message": "Deleted AppInst successfully"

}
$

```

Check that the application instance has been deleted.

```
$ mcctl --addr https://console.mobiledgex.net --output-format json \  
appinst show region=EU app-org=demoorg appname=helloworld appvers=2.0 \
  cluster=hellocluster

$

```

## Create and manage auto-provision policies

Use the `mcctl` utility to create and manage auto-provision policies.

For the example below, we will use an application named `hello-actions`  running in the `demorg` organization within the `EU` region. Additionally, we will set the `deployclientcount` to 2, and set the `deployintervcalcount` to 10 intervals.

- Create the policy.


```
$ mcctl --addr https://console.mobiledgex.net \  
autoprovpolicy create region=EU app-org=demoorg name=TestAutoScale deployclientcount=2 \
 deployintervalcount=10

{}

```

- Verify your policy.


```
$ mcctl --output-format=json --addr https://console.mobiledgex.net \  
autoprovpolicy show region=EU app-org=demoorg name=TestAutoScale
[
  {
    "key": {
      "organization": "demoorg",
      "name": "TestAutoScale"
    },
    "deploy_client_count": 2,
    "deploy_interval_count": 10
  }

]

```

- Add cloudlets to the policy.  For this example, we are going to add two cloudlets to the policy: `hamburg-main` and `berlin-main`.


```
$ mcctl --output-format=json --addr https://console.mobiledgex.net \  
autoprovpolicy addcloudlet region=EU app-org=demoorg name=TestAutoScale \
 cloudlet-org=TDG cloudlet=berlin-main

{}
$ mcctl --output-format=json --addr https://console.mobiledgex.ne  \  
autoprovpolicy addcloudlet region=EU app-org=demoorg name=TestAutoScale \
 cloudlet-org=TDG cloudlet=hamburg-main

{}

```

- Verify that the cloudlets are associated to the policy.


```
$ mcctl --output-format=json --addr https://console.mobiledgex.net \  
autoprovpolicy show region=EU app-org=demoorg name=TestAutoScale
[
  {
    "key": {
      "organization": "demoorg",
      "name": "TestAutoScale"
    },
    "deploy_client_count": 2,
    "deploy_interval_count": 10,
    "cloudlets": [
      {
        "key": {
          "organization": "TDG",
          "name": "berlin-main"
        },
        "loc": {
          "latitude": 52.52,
          "longitude": 13.405
        }
      },
      {
        "key": {
          "organization": "TDG",
          "name": "hamburg-main"
        },
        "loc": {
          "latitude": 53.5511,
          "longitude": 9.9937
        }
      }
    ]
  }

]   

```

- Add the policy to the application.


```
$ mcctl --output-format=json --addr https://console.mobiledgex.net \  
app addautoprovpolicy region=EU appkey.organization=demoorg \
 appkey.name=hello-actions appkey.version=1.0 autoprovpolicy=TestAutoScale

{}  

```

- Validate the policy on the application.


```
$ mcctl --output-format=json --addr https://console.mobiledgex.net \  
app show region=EU app-org=demoorg appname=hello-actions appvers=1.0
[
  {
    "key": {
      "organization": "demoorg",
      "name": "hello-actions",
      "version": "1.0"
    },
    "image_path": "docker.mobiledgex.net/demoorg/images/hello-actions:1.4",
    "image_type": 1,
    "access_ports": "tcp:8000",
    "default_flavor": {
      "name": "m4.small"
    },
    "deployment": "kubernetes",
    "deployment_manifest": "apiVersion: v1\nkind: Service\nmetadata:\n  name: hello-actions-tcp\n  labels:\n    run: hello-actions\nspec:\n  type: \  
    LoadBalancer\n  ports:\n  - name: tcp8000\n    protocol: TCP\n    port: 8000\n    targetPort: 8000\n  selector:\n run: hello-actions \  
    \n---\napiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: hello-actions-deployment\nspec:\n  replicas: 1\n  selector:\n \  
    matchLabels:\n      run: hello-actions\n  template:\n    metadata:\n      labels:\n        run: hello-actions\n \  
    spec:\n      volumes:\n imagePullSecrets:\n - name: docker.mobiledgex.net\n containers:\n \  
    - name: hello-actions\n image: docker.mobiledgex.net/demoorg/images/hello-actions:1.4\n \  
     imagePullPolicy: Always\n ports:\n  - containerPort: 8000\n  protocol: TCP\n", \  
    "deployment_generator": "kubernetes-basic",  
    "access_type": 2,  
    "auto_prov_policies": [  
      "TestAutoScale"
    ]
  }

]

```

## View Metrics

It is possible to retrieve metrics running clusters, applications, and application instances from the MobiledgeX API. It is recommended that you use the `mcctl` utility. Examples are shown below for both cluster instances and applications.

Note that several of the `mcctl` subcommands accept a start/end time to filter output. Time should be passed through in the format as outlined in [RFC 3339](https://tools.ietf.org/html/rfc3339). For example, to specify *10:35 PM UTC on August 7, 2019*, you would code the time as `2019-08-07T20:35Z`. The entire date/time string, including the time zone indicator, must be passed to the command.

```
$ mcctl --addr https://console.mobiledgex.net --output-format json metrics \
  app region=EU app-org=demoorg appname=helloworld appvers=2.0 \
  selector=cpu,mem,disk,network

{
  "data": [
    {
      "Series": [
        {
          "columns": [
            "time",
            "app",
            "ver",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "apporg",
            "pod",
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "appinst-network",
          "values": [
            [
              "2020-06-18T15:50:09.271640054Z",
              "helloworld",
              "20",
              "hellocluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              "demoorg",
              "helloworld",
              null,
              null,
              null,
              130047,
              133836
            ],
            [
              "2020-06-18T15:50:02.230659657Z",
              "helloworld",
              "20",
              "hellocluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              "demoorg",
              "helloworld",
              null,
              null,
              null,
              129228,
              133017
            ],
            [
              "2020-06-18T15:49:55.188034584Z",
              "helloworld",
              "20",
              "hellocluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              "demoorg",
              "helloworld",
              null,
              null,
              null,
              128716,
              132608
            ],
            [
              "2020-06-18T15:49:48.143705282Z",
              "helloworld",
              "20",
              "hellocluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              "demoorg",
              "helloworld",
              null,
              null,
              null,
              128306,
              132095
            ]
          ]
        }
      ]
    }
  ]

}
$

```

### View Cluster Metrics

```
$ mcctl --addr https://console.mobiledgex.net --output-format json metrics \
  cluster  region=EU cluster-org=demoorg cluster=hellocluster \
  selector=cpu,mem,disk,network last=1

{
  "data": [
    {
      "Series": [
        {
          "columns": [
            "time",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "cluster-network",
          "values": [
            [
              "2020-06-18T15:48:35.941672094Z",
              "hellocluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              null,
              null,
              null,
              4087394,
              407099742
            ]
          ]
        },
        {
          "columns": [
            "time",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "cluster-mem",
          "values": [
            [
              "2020-06-18T15:48:35.941672094Z",
              "hellocluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              null,
              10.46972236220657,
              null,
              null,
              null
            ]
          ]
        },
        {
          "columns": [
            "time",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "cluster-disk",
          "values": [
            [
              "2020-06-18T15:48:35.941672094Z",
              "hellocluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              null,
              null,
              20.06319508568715,
              null,
              null
            ]
          ]
        },
        {
          "columns": [
            "time",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "cpu",
            "mem",
            "disk",
            "sendBytes",
            "recvBytes"
          ],
          "name": "cluster-cpu",
          "values": [
            [
              "2020-06-18T15:48:35.941672094Z",
              "hellocluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              0,
              null,
              null,
              null,
              null
            ]
          ]
        }
      ]
    }
  ]

}
$

```

## Viewing Events

### View Application Events

```
$ mcctl --addr https://console.mobiledgex.net --output-format json \
  usage app region=EU apporg=demoorg appname=helloworld appvers=2.0  

{
  "data": [
    {
      "Series": [
        {
          "columns": [
            "time",
            "app",
            "ver",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "apporg",
            "event",
            "status"
          ],
          "name": "appinst",
          "values": [
            [
              "2020-06-18T15:24:48.160858343Z",
              "helloworld",
              "2.0",
              "hellocluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              "demoorg",
              "CREATED",
              "UP"
            ]
          ]
        }
      ]
    }
  ]

}
$

```

### View Cluster Events

```
$ mcctl --addr https://console.mobiledgex.net --output-format json \
  usage cluster  region=EU clusterorg=demoorg cluster=hellocluster        

{
  "data": [
    {
      "Series": [
        {
          "columns": [
            "time",
            "cluster",
            "clusterorg",
            "cloudlet",
            "cloudletorg",
            "flavor",
            "vcpu",
            "ram",
            "disk",
            "other",
            "event",
            "status"
          ],
          "name": "clusterinst",
          "values": [
            [
              "2020-06-18T15:16:34.947555381Z",
              "hellocluster",
              "demoorg",
              "hamburg-main",
              "TDG",
              "m4.small",
              2,
              2048,
              20,
              "map[]",
              "CREATED",
              "UP"
            ]
          ]
        }
      ]
    }
  ]

}
$

```

### View or Find Events

The View and Find Events provide three available commands:

- `show`
- `find`
- `terms`

```
~ mcctl --addr https://console.mobiledgex.net:443 events
view or find events
Usage:
  mcctl events [command]

Available Commands:
  show
  find
  terms

Flags:
  -h, --help   help for events

Global Flags:
      --addr string            MC address (default "http://127.0.0.1:9900")
      --data string            json formatted input data, alternative to name=val args list
      --datafile string        file containing json/yaml formatted input data, alternative to name=val args list
      --debug                  debug
      --output-format string   output format: yaml, json, or json-compact (default "yaml")
      --output-stream          stream output incrementally if supported by command (default true)
      --parsable               generate parsable output
      --silence-usage          silence-usage
      --skipverify             don't verify cert for TLS connections
      --token string           JWT token

```

#### Show Event

The Show Event command retrieves the latest audit and events for all organizations for which the user is a member. The search is based on an **AND** filter criteria, and is sorted by time (most recent first).

```
~ mcctl --addr https://console.mobiledgex.net:443 events show
- name: /api/v1/auth/ctrl/DeleteApp
  org: MobiledgeX
  type: audit
  timestamp: 2020-10-20T19:45:21.283990637Z
  error: Auto-deleted 0 AppInsts but failed to delete 1 AppInsts for App
  mtags:
    app: app1603221850-7233021
    apporg: MobiledgeX
    appver: "1.0"
    duration: 209.664659ms
    email: mexadmin@mobiledgex.net
    hostname: c9b0f45f5c8b
    lineno: orm/auditlog.go:222
    method: POST
    org: MobiledgeX
    region: EU
    remote-ip: 172.17.0.1
    request: '{"app": {"key": {"name": "app1603221850-7233021", "version": "1.0",
      "organization": "MobiledgeX"}}, "region": "EU"}'
    response: '{"message":"Auto-deleted 0 AppInsts but failed to delete 1 AppInsts
      for App"}'
    spanid: 59a6227ca825bb68
    status: "400"
    traceid: 59a6227ca825bb68
    username: mexadmin

- name: /api/v1/auth/ctrl/UpdateCloudlet
  org: TDG
  type: audit
  timestamp: 2020-10-20T19:45:20.244831952Z
  mtags:
    cloudlet: automationHamburgCloudlet
    cloudletorg: TDG
    duration: 259.226706ms
    email: mexadmin@mobiledgex.net
    hostname: c9b0f45f5c8b
    lineno: orm/auditlog.go:222
    method: POST
    org: TDG
    region: EU
    remote-ip: 172.17.0.1
    request: '{"Region":"EU","Cloudlet":{"fields":["2.1","2.2","5.1","5.2","8","30"],"key":{"organization":"TDG","name":"automationHamburgCloudlet"},"location":{"latitude":10,"longitude":10},"ip_support":2,"num_dynamic_ips":254,"time_limits":{},"status":{},"flavor":{},"config":{},"infra_config":{}}}'
    response: |
      {"data":{"message":"Cloudlet updated successfully"}}
    spanid: 2d50f097ff13221c
    status: "200"
    traceid: 2d50f097ff13221c
    username: mexadmin

- name: cluster-svc create AppInst
  org: MobiledgeX
  type: event
  region: EU
  timestamp: 2020-10-20T19:32:01.607923142Z
  mtags:
    app: MEXPrometheusAppName
    apporg: MobiledgeX
    appver: "1.0"
    cloudlet: automationHamburgCloudlet
    cloudletorg: TDG
    cluster: cluster1603221850-72330212
    clusterorg: MobiledgeX
    duration: 1m38.672686617s
    hostname: cluster-svc-68b4d86fb6-rbzfl
    lineno: cluster-svc/cluster-svc-main.go:358
    spanid: 6d8ebb4ce83a9ed1
    traceid: 1b6da9d0cdb43b19

```

**Event Show using optional arguments for filtering events**

The following example uses the Event Show optional arguments to filter the event by specifying `type=event`, using a wildcard for the `name` (* shephard start*), and a time range value to search for events occurring within the last 48 hours for `startage` and `endage`.

```
➜  mcctl --addr https://console.mobiledgex.net:443 --skipverify events show type=event name="*shepherd start*" limit=3 timerange.startage=48h timerange.endage=46h --debug
argsmap: map[limit:3 match:map[names:[*shepherd start*] types:[event]] timerange:map[endage:46h startage:48h]]
jsonmap: map[endage:46h0m0s limit:3 match:map[names:[*shepherd start*] types:[event]] startage:48h0m0s]
curl -X POST "https://console.mobiledgex.net:443/api/v1/auth/events/show" -H "Content-Type: application/json" -H "Authorization: Bearer ${TOKEN}" -k --data-raw '{"endage":165600000000000,"limit":3,"match":{"names":["*shepherd start*"],"types":["event"]},"startage":172800000000000}'
- name: shepherd start
  type: event
  region: US
  timestamp: 2020-10-19T19:13:59.100152864Z
  mtags:
    cloudlet: automationAzureCentralCloudlet
    cloudletorg: azure
    hostname: gitlab-qa
    lineno: node/events.go:238
    node: gitlab-qa
    noderegion: US
    nodetype: shepherd
    spanid: 57189c531bc4ff2b
    traceid: 57189c531bc4ff2b

- name: shepherd start
  type: event
  region: US
  timestamp: 2020-10-19T19:13:54.369748058Z
  mtags:
    cloudlet: automationGcpCentralCloudlet
    cloudletorg: gcp
    hostname: gitlab-qa
    lineno: node/events.go:238
    node: gitlab-qa
    noderegion: US
    nodetype: shepherd
    spanid: 7d683b305685e16c
    traceid: 7d683b305685e16c

- name: shepherd start
  type: event
  region: US
  timestamp: 2020-10-19T19:13:32.319256376Z
  mtags:
    cloudlet: automationAzureCentralCloudlet
    cloudletorg: azure
    hostname: gitlab-qa
    lineno: node/events.go:238
    node: gitlab-qa
    noderegion: US
    nodetype: shepherd
    spanid: 3eb26d2cdcc6507
    traceid: 3eb26d2cdcc6507

```

**Event Show using optional arguments to filtering audits**

The following example uses the Event Show optional arguments to filter the audit by specifying `type=audits`, using a wildcard for the `name` (* create*), and a time range value to search for audits occurring within the last 48 hours for `startage` and `endage`.

#### Terms Event

Terms Event command shows the available events for users, and organizations in which the user is a member, the types of events (audit and event), and regions and tag keys (filtering in a more granular way).

```
~ mcctl --addr https://console.mobiledgex.net:443 events terms
names:
- /api/v1/auth/ctrl/AddAutoProvPolicyCloudlet
- /api/v1/auth/ctrl/AddCloudletPoolMember
- /api/v1/auth/ctrl/AddCloudletResMapping
- /api/v1/auth/ctrl/AddResTag
- /api/v1/auth/ctrl/AddVMPoolMember
- /api/v1/auth/ctrl/CreateApp
- /api/v1/auth/ctrl/CreateAppInst
- /api/v1/auth/ctrl/CreateAutoProvPolicy
- /api/v1/auth/ctrl/CreateAutoScalePolicy
- /api/v1/auth/ctrl/CreateCloudlet
- /api/v1/auth/ctrl/CreateCloudletPool
- /api/v1/auth/ctrl/CreateClusterInst
- /api/v1/auth/ctrl/CreatePrivacyPolicy
- /api/v1/auth/ctrl/CreateVMPool
- /api/v1/auth/ctrl/DeleteApp
- /api/v1/auth/ctrl/DeleteAppInst
- /api/v1/auth/ctrl/DeleteAutoProvPolicy
- /api/v1/auth/ctrl/DeleteAutoScalePolicy
- /api/v1/auth/ctrl/DeleteCloudlet
- /api/v1/auth/ctrl/DeleteCloudletPool
- /api/v1/auth/ctrl/DeleteClusterInst
- /api/v1/auth/ctrl/DeletePrivacyPolicy
- /api/v1/auth/ctrl/DeleteVMPool
- /api/v1/auth/ctrl/GetCloudletManifest
- /api/v1/auth/ctrl/RefreshAppInst
- /api/v1/auth/ctrl/RemoveAutoProvPolicyCloudlet
- /api/v1/auth/ctrl/RemoveCloudletPoolMember
- /api/v1/auth/ctrl/RemoveVMPoolMember
- /api/v1/auth/ctrl/RunCommand
- /api/v1/auth/ctrl/RunConsole
- /api/v1/auth/ctrl/ShowAppInstClient
- /api/v1/auth/ctrl/ShowLogs
- /api/v1/auth/ctrl/UpdateApp
- /api/v1/auth/ctrl/UpdateAppInst
- /api/v1/auth/ctrl/UpdateCloudlet
- /api/v1/auth/ctrl/UpdateCloudletPool
- /api/v1/auth/ctrl/UpdateClusterInst
- /api/v1/auth/ctrl/UpdatePrivacyPolicy
- /api/v1/auth/ctrl/UpdateVMPool
- /api/v1/auth/org/create
- /api/v1/auth/orgcloudletpool/create
- /api/v1/auth/role/adduser
- /api/v1/auth/role/removeuser
- /ws/api/v1/auth/ctrl/CreateCloudlet
- /ws/api/v1/auth/ctrl/CreateClusterInst
- /ws/api/v1/auth/ctrl/DeleteAppInst
- /ws/api/v1/auth/ctrl/DeleteCloudlet
- /ws/api/v1/auth/ctrl/DeleteClusterInst
- AppInst offline
- AppInst online
- Cloudlet online
- cluster-svc create App
- cluster-svc create AppInst
- cluster-svc refresh AppInsts
orgs:
- MobiledgeX
- TDG
- packet
- testmonitor
types:
- audit
- event
regions:
- EU
- US
tagkeys:
- app
- apporg
- appver
- cloudlet
- cloudletorg
- cloudletpool
- cloudletpoolorg
- cluster
- clusterorg
- duration
- email
- hostname
- lineno
- method
- org
- policy
- policyorg
- region
- remote-ip
- request
- response
- restagtable
- restagtableorg
- spanid
- state
- status
- traceid
- username
- vmpool
- vmpoolorg

```

#### Find Event

In place of using the Show Event command, the Find Event command can be used to search events based on using the **OR** filter criteria, where it will return the best match possible.

```
mcctl --addr https://console.mobiledgex.net:443 --skipverify events find type=event name="cluster-svc create AppInst" tags=traceid=1016ab314a549b44 tags=cloudlet=DFWVMW2 limit=4 timerange.startage=4000h time  

```

### Filter events by optional arguments

```
~ mcctl --addr https://console.mobiledgex.net:443 --skipverify events show --help
Usage: mcctl events show [flags] [args]
Required Args:
Optional Args:
  name       name of the event, may be specified multiple times
  org        organization associated with the event, may be specified multiple times
  type       type of event, either "event" or "audit", may be specified multiple times
  region     Region name
  error      any words in an error message
  tags       key=value tag, may be specified multiple times, key may include app, apporg, appver, cloudlet, cloudletorg, cloudletpool, cloudletpoolorg, cluster, clusterorg, controlleraddr, deviceid, deviceidtype, flavor, node, noderegion, nodetype, policy, policyorg, restagtable, restagtableorg, vmpool, vmpoolorg
  starttime  absolute time of search range start (RFC3339)
  endtime    absolute time of search range end (RFC3339)
  startage   relative age from now of search range start (default 48h)
  endage     relative age from now of search range end (default 0)
  failed     specify true to find events with an error
  from       start offset if paging through results
  limit      number of results to return, either to limit or for paging results

```

**Example: Filter events by org and region**

```
~ mcctl --addr https://console.mobiledgex.net:443 --skipverify events show org=testmonitor region=EU
- name: AppInst online
  org: testmonitor
  type: event
  region: EU
  timestamp: 2020-10-20T05:52:55.867301065Z
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    cloudlet: automationDusseldorfCloudlet
    cloudletorg: TDG
    cluster: reservable1
    clusterorg: MobiledgeX
    hostname: controller-596686755c-n4twp
    lineno: node/events.go:238
    spanid: 708549c65533717a
    state: HEALTH_CHECK_OK
    traceid: 670c690cb41a37a1

```

#### Filter events by tags

**Example: Filtering events by tagging cluster**

```
~ mcctl --addr https://console.mobiledgex.net:443 --skipverify events show org=testmonitor tags=cluster=k8smonitoring
- name: AppInst online
  org: testmonitor
  type: event
  region: US
  timestamp: 2020-10-20T05:53:41.736820944Z
  mtags:
    app: app-us-k8s
    apporg: testmonitor
    appver: v1
    cloudlet: packetcloudlet
    cloudletorg: packet
    cluster: k8smonitoring
    clusterorg: testmonitor
    hostname: controller-76bb4d85d-k94bq
    lineno: node/events.go:238
    spanid: 4c23336544dbdc91
    state: HEALTH_CHECK_OK
    traceid: 4a8d2ab24327f280

- name: AppInst offline
  org: testmonitor
  type: event
  region: US
  timestamp: 2020-10-20T05:53:26.67005195Z
  mtags:
    app: app-us-k8s
    apporg: testmonitor
    appver: v1
    cloudlet: packetcloudlet
    cloudletorg: packet
    cluster: k8smonitoring
    clusterorg: testmonitor
    hostname: controller-76bb4d85d-k94bq
    lineno: node/events.go:238
    spanid: 33d6aaf91081ddad
    state: HEALTH_CHECK_FAIL_ROOTLB_OFFLINE
    traceid: 7d3489efc086ff97

```

**Example: Filter events by multiple tags and name**

```
~ mcctl --addr https://console.mobiledgex.net:443 --skipverify events show name="AppInst offline" org=testmonitor tags=cluster=k8smonitoring tags=cloudlet=packetcloudlet tags=app=app-us-k8s tags=traceid=1107711e5ef63582
- name: AppInst offline
  org: testmonitor
  type: event
  region: US
  timestamp: 2020-10-19T06:07:43.704227297Z
  mtags:
    app: app-us-k8s
    apporg: testmonitor
    appver: v1
    cloudlet: packetcloudlet
    cloudletorg: packet
    cluster: k8smonitoring
    clusterorg: testmonitor
    hostname: controller-8455bdc9c5-jjlz2
    lineno: node/events.go:238
    spanid: 5c01b687a2424150
    state: HEALTH_CHECK_FAIL_ROOTLB_OFFLINE
    traceid: 1107711e5ef63582

```

**Example: Email tags**

Email tag displayed within the audit log is associated with the user who ran the API.

```
- name: /ws/api/v1/auth/ctrl/ShowAppInstClient
  org: testmonitor
  type: audit
  timestamp: 2020-10-13T16:19:20.856737869Z
  mtags:
    app: app-us
    apporg: testmonitor
    appver: v1
    cloudlet: packetcloudlet
    cloudletorg: packet
    cluster: dockermonitoring
    clusterorg: testmonitor
    duration: 11h14m13.61263625s
    email: rahul.jain@mobiledgex.com
    hostname: 67d1b00d0a67
    lineno: orm/auditlog.go:222
    method: GET
    org: testmonitor
    region: US
    remote-ip: 172.17.0.1

```

**Example: Region tag**

Region field indicates the location of where the audit/event occurred. However, for APIs that are designated to the Regional Controller, the region field, in this case, is part of the `mtags`. Therefore, to properly set up the region field,  you would specify the tag as `region=EU`.

```
edge-cloud-infra git:(master) mcctl --addr https://console.mobiledgex.net:443 --skipverify events show org=testmonitor region=EU
- name: AppInst online
  org: testmonitor
  type: event
  region: EU
  timestamp: 2020-10-14T03:53:11.195913854Z
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    cloudlet: automationDusseldorfCloudlet
    cloudletorg: TDG
    cluster: reservable1
    clusterorg: MobiledgeX
    hostname: controller-7d86c7b7b9-8hz8v
    lineno: node/events.go:238
    spanid: 64959ea220457b
    state: HEALTH_CHECK_OK
    traceid: 5b9fcb0906f48b92

- name: AppInst offline
  org: testmonitor
  type: event
  region: EU
  timestamp: 2020-10-14T03:53:08.541837956Z
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    cloudlet: automationDusseldorfCloudlet
    cloudletorg: TDG
    cluster: reservable1
    clusterorg: MobiledgeX
    hostname: controller-7d86c7b7b9-8hz8v
    lineno: node/events.go:238
    spanid: 7f5db2d4cb3e7ac2
    state: HEALTH_CHECK_FAIL_ROOTLB_OFFLINE
    traceid: 6f304d6458e3cb11

```

**Output:**

```
edge-cloud-infra git:(master) mcctl --addr https://console.mobiledgex.net:443 --skipverify events show org=testmonitor tags=region=EU
- name: /ws/api/v1/auth/ctrl/DeleteAppInst
  org: testmonitor
  type: audit
  timestamp: 2020-10-14T17:13:54.487773605Z
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    cloudlet: automationDusseldorfCloudlet
    cloudletorg: TDG
    cluster: reservable1
    clusterorg: MobiledgeX
    duration: 47.268602316s
    email: ashutosh.bhatt+testuser@mobiledgex.com
    hostname: 6e285816512c
    lineno: orm/auditlog.go:222
    method: GET
    org: testmonitor
    region: EU
    remote-ip: 172.17.0.1
    request: '{"Region":"EU","AppInst":{"key":{"app_key":{"organization":"testmonitor","name":"dockerRLB","version":"v1"},"cluster_inst_key":{"cluster_key":{"name":"reservable1"},"cloudlet_key":{"organization":"TDG","name":"automationDusseldorfCloudlet"},"organization":"MobiledgeX"}},"cloudlet_loc":{},"mapped_ports":null,"flavor":{},"runtime_info":{},"created_at":{},"status":{}}}'
    response: |-
      {"code":200,"data":{"message":"Deleting"}}
      {"code":200,"data":{"message":"NotPresent"}}
      {"code":200,"data":{"message":"Deleted AppInst successfully"}}
    spanid: 47790f9bd874e21e
    status: "200"
    traceid: 47790f9bd874e21e
    username: testuser

- name: /api/v1/auth/ctrl/UpdateApp
  org: testmonitor
  type: audit
  timestamp: 2020-10-14T14:34:47.949796019Z
  error: Changing access ports on docker apps not allowed unless manifest is specified
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    duration: 173.937581ms
    email: ashutosh.bhatt+testuser@mobiledgex.com
    hostname: 6e285816512c
    lineno: orm/auditlog.go:222
    method: POST
    org: testmonitor
    region: EU
    remote-ip: 172.17.0.1
    request: '{"region":"EU","app":{"key":{"organization":"testmonitor","name":"dockerRLB","version":"v1"},"scale_with_cluster":false,"deployment":"docker","image_type":1,"image_path":"docker-qa.mobiledgex.net/testmonitor/images/myfirst-app:v1","access_ports":"tcp:8080","delete_ports":[],"default_flavor":{"name":"automation_api_flavor"},"default_privacy_policy":"VMPoolPrivacy","access_type":2,"fields":["30"]}}'
    response: '{"message":"Changing access ports on docker apps not allowed unless
      manifest is specified"}'
    spanid: 67cf8dd99a772a3a
    status: "400"
    traceid: 67cf8dd99a772a3a
    username: testuser

- name: /api/v1/auth/ctrl/UpdateApp
  org: testmonitor
  type: audit
  timestamp: 2020-10-14T03:04:07.830889031Z
  error: Policy key {"organization":"testmonitor"} not found
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    duration: 164.708427ms
    email: mexadmin@mobiledgex.net
    hostname: 67d1b00d0a67
    lineno: orm/auditlog.go:222
    method: POST
    org: testmonitor
    region: EU
    remote-ip: 172.17.0.1
    request: '{"app":{"auto_prov_policies":[""],"fields":["32","2.2","2.3","2.1"],"key":{"name":"dockerRLB","organization":"testmonitor","version":"v1"}},"region":"EU"}'
    response: '{"message":"Policy key {\"organization\":\"testmonitor\"} not found"}'
    spanid: 2ec94f173fcbcdf1
    status: "400"
    traceid: 2ec94f173fcbcdf1
    username: mexadmin

- name: /ws/api/v1/auth/ctrl/DeleteAppInst
  org: testmonitor
  type: audit
  timestamp: 2020-10-14T03:00:25.662532661Z
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    cloudlet: automationDusseldorfCloudlet
    cloudletorg: TDG
    cluster: reservable1
    clusterorg: MobiledgeX
    duration: 48.254253781s
    email: mexadmin@mobiledgex.net
    hostname: 67d1b00d0a67
    lineno: orm/auditlog.go:222
    method: GET
    org: testmonitor
    region: EU
    remote-ip: 172.17.0.1
    request: '{"Region":"EU","AppInst":{"key":{"app_key":{"organization":"testmonitor","name":"dockerRLB","version":"v1"},"cluster_inst_key":{"cluster_key":{"name":"reservable1"},"cloudlet_key":{"organization":"TDG","name":"automationDusseldorfCloudlet"},"organization":"MobiledgeX"}},"cloudlet_loc":{},"mapped_ports":null,"flavor":{},"runtime_info":{},"created_at":{},"status":{}}}'
    response: |-
      {"code":200,"data":{"message":"Deleting"}}
      {"code":200,"data":{"message":"NotPresent"}}
      {"code":200,"data":{"message":"Deleted AppInst successfully"}}
    spanid: 4137c67021083c30
    status: "200"
    traceid: 4137c67021083c30
    username: mexadmin

- name: /api/v1/auth/ctrl/UpdateApp
  org: testmonitor
  type: audit
  timestamp: 2020-10-13T22:55:36.905886185Z
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    duration: 3.755661241s
    email: ashutosh.bhatt+testuser@mobiledgex.com
    hostname: 67d1b00d0a67
    lineno: orm/auditlog.go:222
    method: POST
    org: testmonitor
    region: EU
    remote-ip: 172.17.0.1
    request: '{"app":{"auto_prov_policies":["EventHA"],"fields":["2.2","2.3","2.1","32"],"key":{"name":"dockerRLB","organization":"testmonitor","version":"v1"}},"region":"EU"}'
    response: '{}'
    spanid: 2c6206c108d4ecb9
    status: "200"
    traceid: 2c6206c108d4ecb9
    username: testuser

- name: /api/v1/auth/ctrl/UpdateApp
  org: testmonitor
  type: audit
  timestamp: 2020-10-13T22:50:43.940798235Z
  error: Changing access ports on docker apps not allowed unless manifest is specified
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    duration: 313.432676ms
    email: ashutosh.bhatt+testuser@mobiledgex.com
    hostname: 67d1b00d0a67
    lineno: orm/auditlog.go:222
    method: POST
    org: testmonitor
    region: EU
    remote-ip: 172.17.0.1
    request: '{"region":"EU","app":{"key":{"organization":"testmonitor","name":"dockerRLB","version":"v1"},"scale_with_cluster":false,"deployment":"docker","image_type":1,"image_path":"docker-qa.mobiledgex.net/testmonitor/images/myfirst-app:v1","access_ports":"tcp:8080","delete_ports":[],"default_flavor":{"name":"automation_api_flavor"},"auto_prov_policy":"EventHA","access_type":2,"fields":["28"]}}'
    response: '{"message":"Changing access ports on docker apps not allowed unless
      manifest is specified"}'
    spanid: 6a8bc93ce4345127
    status: "400"
    traceid: 6a8bc93ce4345127
    username: testuser

- name: /api/v1/auth/ctrl/UpdateApp
  org: testmonitor
  type: audit
  timestamp: 2020-10-13T22:50:34.29011749Z
  error: Changing access ports on docker apps not allowed unless manifest is specified
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    duration: 172.404218ms
    email: ashutosh.bhatt+testuser@mobiledgex.com
    hostname: 67d1b00d0a67
    lineno: orm/auditlog.go:222
    method: POST
    org: testmonitor
    region: EU
    remote-ip: 172.17.0.1
    request: '{"region":"EU","app":{"key":{"organization":"testmonitor","name":"dockerRLB","version":"v1"},"scale_with_cluster":false,"deployment":"docker","image_type":1,"image_path":"docker-qa.mobiledgex.net/testmonitor/images/myfirst-app:v1","access_ports":"tcp:8080","delete_ports":[],"default_flavor":{"name":"automation_api_flavor"},"default_privacy_policy":"VMPoolPrivacy","access_type":2,"fields":["30"]}}'
    response: '{"message":"Changing access ports on docker apps not allowed unless
      manifest is specified"}'
    spanid: 92f66e6a5287d
    status: "400"
    traceid: 92f66e6a5287d
    username: testuser

- name: /api/v1/auth/ctrl/UpdateApp
  org: testmonitor
  type: audit
  timestamp: 2020-10-13T22:43:16.836473348Z
  error: Changing access ports on docker apps not allowed unless manifest is specified
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    duration: 193.855191ms
    email: ashutosh.bhatt+testuser@mobiledgex.com
    hostname: 67d1b00d0a67
    lineno: orm/auditlog.go:222
    method: POST
    org: testmonitor
    region: EU
    remote-ip: 172.17.0.1
    request: '{"region":"EU","app":{"key":{"organization":"testmonitor","name":"dockerRLB","version":"v1"},"scale_with_cluster":false,"deployment":"docker","image_type":1,"image_path":"docker-qa.mobiledgex.net/testmonitor/images/myfirst-app:v1","access_ports":"tcp:8080","delete_ports":[],"default_flavor":{"name":"automation_api_flavor"},"default_privacy_policy":"VMPoolPrivacy","access_type":2,"fields":["30"]}}'
    response: '{"message":"Changing access ports on docker apps not allowed unless
      manifest is specified"}'
    spanid: 45d4350b1da3e1ed
    status: "400"
    traceid: 45d4350b1da3e1ed
    username: testuser

- name: /api/v1/auth/ctrl/UpdateApp
  org: testmonitor
  type: audit
  timestamp: 2020-10-13T22:31:47.883665005Z
  error: Changing access ports on docker apps not allowed unless manifest is specified
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    duration: 161.536711ms
    email: ashutosh.bhatt+testuser@mobiledgex.com
    hostname: 67d1b00d0a67
    lineno: orm/auditlog.go:222
    method: POST
    org: testmonitor
    region: EU
    remote-ip: 172.17.0.1
    request: '{"region":"EU","app":{"key":{"organization":"testmonitor","name":"dockerRLB","version":"v1"},"scale_with_cluster":false,"deployment":"docker","image_type":1,"image_path":"docker-qa.mobiledgex.net/testmonitor/images/myfirst-app:v1","access_ports":"tcp:8080","delete_ports":[],"default_flavor":{"name":"automation_api_flavor"},"default_privacy_policy":"VMPoolPrivacy","access_type":2,"fields":["30"]}}'
    response: '{"message":"Changing access ports on docker apps not allowed unless
      manifest is specified"}'
    spanid: 2b936c3033a47968
    status: "400"
    traceid: 2b936c3033a47968
    username: testuser

- name: /api/v1/auth/ctrl/UpdateApp
  org: testmonitor
  type: audit
  timestamp: 2020-10-13T22:29:20.736297773Z
  error: Changing access ports on docker apps not allowed unless manifest is specified
  mtags:
    app: dockerRLB
    apporg: testmonitor
    appver: v1
    duration: 158.447615ms
    email: ashutosh.bhatt+testuser@mobiledgex.com
    hostname: 67d1b00d0a67
    lineno: orm/auditlog.go:222
    method: POST
    org: testmonitor
    region: EU
    remote-ip: 172.17.0.1
    request: '{"region":"EU","app":{"key":{"organization":"testmonitor","name":"dockerRLB","version":"v1"},"scale_with_cluster":false,"deployment":"docker","image_type":1,"image_path":"docker-qa.mobiledgex.net/testmonitor/images/myfirst-app:v1","access_ports":"tcp:8080","delete_ports":[],"default_flavor":{"name":"automation_api_flavor"},"auto_prov_policy":"EventHA","access_type":2,"fields":["28"]}}'
    response: '{"message":"Changing access ports on docker apps not allowed unless
      manifest is specified"}'
    spanid: 170bc3d792b48fa5
    status: "400"
    traceid: 170bc3d792b48fa5
    username: testuser   

```

## View Audit Log

```
$ mcctl --addr https://console.mobiledgex.net --output-format json \
  audit showorg org=demoorg

[
  {
    "operationname": "/api/v1/auth/ctrl/CreateAppInst",
    "username": "demo",
    "clientip": "172.17.0.1",
    "status": 200,
    "starttime": 1592493850935462,
    "duration": 37294028,
    "request": "{\"appinst\":{\"key\":{\"app_key\":{\"name\":\"helloworld\",\"organization\":\
    "demoorg\",\"version\":\"2.0\"},\"cluster_inst_key\":{\"cloudlet_key\
    ":{\"name\":\"hamburg-main\",\"organization\":\"TDG\"},\"cluster_key\":{\"name\":\"hellocluster\"},\
    "organization\":\"demoorg\"}}},\"region\":\"EU\"}",\
    "response": "{\"data\":{\"message\":\"Seeding docker\
     secret\"}}\n{\"data\":{\"message\":\"Deploying Docker\
      App\"}}\n{\"data\":{\"message\":\"Configuring Firewall Rules and\
       DNS\"}}\n{\"data\":{\"message\":\"Creating\"}}\n{\"data\
    ":{\"message\":\"Ready\"}}\n{\"data\":{\"message\":\
    "Created AppInst successfully\"}}\n",\
    "error": "",
    "traceid": "5034d1ced12bb5cf"
  },
  {
    "operationname": "/api/v1/auth/ctrl/CreateApp",
    "username": "demo",
    "clientip": "172.17.0.1",
    "status": 200,
    "starttime": 1592493739016000,
    "duration": 3922894,
    "request": "{\"app\":{\"access_ports\":\"tcp:8000\",\"access_type\":0,\"default_flavor\
    ":{\"name\":\"m4.small\"},\"deployment\":\"docker\",\"image_path\":
    \"docker.mobiledgex.net/demoorg/images/helloworld:2.0\",\"image_type\":1,\"key\":{\"name\":\"helloworld\",\
    "organization\":\"demoorg\",\"version\":\"2.0\"}},\"region\":\"EU\"}",
    "response": "{}",
    "error": "",
    "traceid": "34a8ce6da7bac7b8"
  },
  {
    "operationname": "/api/v1/auth/ctrl/DeleteApp",
    "username": "demo",
    "clientip": "172.17.0.1",
    "status": 200,
    "starttime": 1592493647899812,
    "duration": 796033,
    "request": "{\"region\":\"EU\",\"app\":{\"key\":{\"organization\":\"demoorg\",\"name\":\
    "helloworld\",\"version\":\"2.0\"}}}",\
    "response": "{}",
    "error": "",
    "traceid": "5604e0f62e32400f"
  },
  {
    "operationname": "/api/v1/auth/ctrl/CreateAppInst",
    "username": "demo",
    "clientip": "172.17.0.1",
    "status": 400,
    "starttime": 1592493592155579,
    "duration": 1604621,
    "request": "{\"appinst\":{\"key\":{\"app_key\":{\"name\":\"helloworld\",\"organization\":\
    "demoorg\",\"version\":\"2.0\"},\"cluster_inst_key\":{\"cloudlet_key\":{\"name\":
    \"hamburg-main\",\"organization\":\"TDG\"},\"cluster_key\":{\"name\":\"hellocluster\"},\
    "organization\":\"demoorg\"}}},\"region\":\"EU\"}",\

"response": "{\"message\":\"Cannot deploy kubernetes App into docker ClusterInst\"}",\
"error": "",
  "raceid": "066ff271f942e895"
  },
  {
    "operationname": "/api/v1/auth/ctrl/CreateClusterInst",
    "username": "demo",
    "clientip": "172.17.0.1",
    "status": 200,
    "starttime": 1592493298925277,
    "duration": 96092555,
    "request": "{\"clusterinst\":{\"deployment\":\"docker\",\"flavor\":{\"name\":\"m4.small\"},\
    "ip_access\":1,\"key\":{\"cloudlet_key\":{\"name\":\"hamburg-\
    main\",\"organization\":\"TDG\"},\"cluster_key\":{\"name\":\"hellocluster\"},\
    "organization\":\"demoorg\"}},\"region\":\"EU\"}",\
    "response": "{\"data\":{\"message\":\"Creating\"}}\n{\"data\":{\"message\":\
    "Creating Dedicated VM for Docker\"}}\n{\"data\":{\"message\":\"Creating Heat Stack for\
    hamburg-main-hellocluster-demoorg\"}}\n{\"data\":{\"message\":\"Creating Heat Stack for\
    hamburg-main-hellocluster-demoorg, Heat Stack Status:\
    CREATE_IN_PROGRESS\"}}\n{\"data\":{\"message\":\"Creating Heat Stack for hamburg-main\
    hellocluster-demoorg, Heat Stack Status:\
    CREATE_COMPLETE\"}}\n{\"data\":{\"message\":\"Setting Up Root\
    LB\"}}\n{\"data\":{\"message\":\"Ready\"}}\n{\"data\":{\"message\":\"Created\
    ClusterInst successfully\"}}\n",
    "error": "",
    "traceid": "4b13b6bb61928581"
  },
  {
    "operationname": "/api/v1/auth/ctrl/CreateAppInst",
    "username": "demo",
    "clientip": "172.17.0.1",
    "status": 400,
    "starttime": 1592493129120337,
    "duration": 1535173,
    "request": "{\"appinst\":{\"key\":{\"app_key\":{\"name\":\"helloworld\",\"organization\":\
    "demoorg\",\"version\":\"2.0\"},\"cluster_inst_key\":{\"cloudlet_key\":{\"name\":\
    "hamburg-main\",\"organization\":\"TDG\"},\"cluster_key\":{\"name\":\"hellocluster\"},\
    "organization\":\"demoorg\"}}},\"region\":\"EU\"}",\
    "response": "{\"message\":\"Specified ClusterInst not found\"}",\
    "error": "",
    "traceid": "7f07a2e9f29d5a64"
  },
  {
    "operationname": "/api/v1/auth/ctrl/CreateAppInst",
    "username": "demo",
    "clientip": "172.17.0.1",
    "status": 200,
    "starttime": 1592493022343860,
    "duration": 1531702,
    "request": "{\"appinst\":{\"key\":{\"app_key\":{\"name\":\"helloworld\",\"organization\":\
    "demoorg\",\"version\":\"2.0\"},\"cluster_inst_key\":{\"cloudlet_key\
    ":{\"name\":\"hamburg-main\",\"organization\":\"TDG\"}}}},\"region\":\"EU\"}",\
    "response": "{\"data\":{\"message\":\"Setting ClusterInst developer to match App\
     developer\"}}\n{\"result\":{\"message\":\"Invalid cluster name\",\"code\":400}}\n",\
     "error": "",
    "traceid": "076ea2b797cf3fd8"
  },
  {
    "operationname": "/api/v1/auth/ctrl/CreateApp",
    "username": "demo",
    "clientip": "172.17.0.1",
    "status": 400,
    "starttime": 1592492110389860,
    "duration": 3912500,
    "request": "{\"app\":{\"access_ports\":\"tcp:8000\",\"access_type\":0,\"default_flavor\
    ":{\"name\":\"m4.small\"},\"image_path\":\"docker.mobiledgex.net/demoorg/images\
    helloworld:2.0\",\
    "image_type\":1,\"key\":{\"name\":\"helloworld\",\"organization\":\"demoorg\",\
    "version\":\"2.0\"}},\"region\":\"EU\"}",\
    "response": "{\"message\":\"App key\
     {\\\"organization\\\":\\\"demoorg\\\",\\\"name\\\":\\\"helloworld\\\",\\\
     "version\\\":\\\"2.0\\\"} already exists\"}",\
     "error": "",
    "traceid": "40190a8d5f99c6e6"
  },
  {
    "operationname": "/api/v1/auth/ctrl/CreateApp",
    "username": "demo",
    "clientip": "172.17.0.1",
    "status": 200,
    "starttime": 1592492083400526,
    "duration": 3590830,
    "request": "{\"app\":{\"access_ports\":\"tcp:8000\",\"access_type\":0,\"default_flavor\
  ":{\"name\":\"m4.small\"},\"image_path\":\"docker.mobiledgex.net/demoorg/images
  helloworld:2.0\",\"image_type\":1,\"key\":{\"name\":\"helloworld\",\
  "organization\":\"demoorg\",\"version\":\"2.0\"}},\"region\":\"EU\"}",\
  "response": "{}",
    "error": "",
    "traceid": "60b78153f95413e9"
  },
  {
    "operationname": "/api/v1/auth/ctrl/CreateApp",
    "username": "demo",
    "clientip": "172.17.0.1",
    "status": 400,
    "starttime": 1592492017266333,
    "duration": 3840846,
    "request": "{\"app\":{\"access_ports\":\"tcp:8000\",\"access_type\":0,\"default_flavor\
    ":{\"name\":\"m4.small\"},\"image_path\":\"docker.mobiledgex.net/demoorg/helloworld:2.0\",\"image_type\":1,\"key\":{\"name\":
    \"helloworld\",\
    "organization\":\"demoorg\",\"version\":\"2.0\"}},\"region\":\"EU\"}",\
    "response": "{\"message\":\"failed to validate docker registry image, path\
     docker.mobiledgex.net/demoorg/helloworld:2.0, Access denied to registry path\"}",\
     "error": "",
    "traceid": "77d8f3c0fd0d69f8"
  },
  {
    "operationname": "/api/v1/auth/ctrl/CreateApp",
    "username": "demo",
    "clientip": "172.17.0.1",
    "status": 400,
    "starttime": 1592491977561889,
    "duration": 869118,
    "request": "{\"app\":{\"access_ports\":\"tcp:8000\",\"access_type\":1,\"default_flavor\
    ":{\"name\":\"m4.small\"},\"image_path\":\"docker.mobiledgex.net/demoorg/
    helloworld:2.0\",\"image_type\":1,\"key\":{\"name\":\"helloworld\",\
    "organization\":\"demoorg\",\"version\":\"2.0\"}},\"region\":\"EU\"}",\
    "response": "{\"message\":\"Invalid access type for deployment\"}",\
    "error": "",
    "traceid": "327bc1c726a7a822"
  }

]
$

```

### Where to go from here

For reference information about the `mcctl` utility, refer to the [mcctl utility Reference](/developer/tools/mcctl-guides/mcctl-reference) guide.

