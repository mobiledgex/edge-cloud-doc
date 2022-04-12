# Cloudlet Processes

## PlatformVM

- Deployed when cloudlet is created via MobiledgeX UI/API.
    
- Based on the current MobiledgeX Image which must be available in the Artifactory linked to the Installation.
    

### Logging in to the PlatformVM

Via accesscloudlet command of mcctl

Example:

```
# mcctl accesscloudlet region=EU cloudlet-org=myoperator cloudlet=mycloudlet1 node-type=platformvm
ubuntu@mycloudlet1-myoperator-pf:~$
```

PlatformVM runs docker containers for the 3 cloudlet processes

```
$ docker ps
CONTAINER ID   IMAGE                                                                        COMMAND                  CREATED        STATUS      PORTS     NAMES
14af5d9a147b   docker.mobiledgex.net/mobiledgex/mobiledgex_public/prom/prometheus:v2.19.2   "/bin/prometheus --c…"   4 days ago     Up 4 days             cloudletPrometheus
0fb0e6c1604a   registry.mobiledgex.net:5000/mobiledgex/edge-cloud:2021-08-14-13             "edge-cloud-entrypoi…"   4 days ago     Up 3 days             shepherd
138eac03ea15   registry.mobiledgex.net:5000/mobiledgex/edge-cloud:2021-08-14-13             "edge-cloud-entrypoi…"   3 months ago   Up 9 days             crmserver
```

### CRM

Cloudlet Resource Manager Plugin.

- The interface between the IaaS and the regional controller.
    
- All communication is outbound from the CRM to the regional controller
    
- Standard docker commands (log, exec etc) can be used to monitor CRM activity
    
- CRM will self upgrade when the regional controller is upgraded.
    

### Shepherd

Metrics handler for MobiledgeX. Interfaces with the regional controller to deliver metrics gathered by Prometheus to the Master Controller.

### Prometheus

Metrics gatherer from clusters and App Insts using standard Prometheus software.

## Shared Root Load Balancer

Shared LB allows VM resources for Load Balancing to be shared across multiple clusters. This is useful in the following scenarios

- Low bandwidth services
    
- Testing / Development
    
- Restricted number of external IP’s available to the cloudlet
    

There are limitations with the shared LB in port mapping. As the Shared LB can only use each port once it may be necessary for MobiledgeX to remap ports if there is a clash. The remapping is implemented in the envoy configuration for each cluster.

### Logging in to the Shared LB

Via accesscloudlet command of mcctl

Example:

```
# mcctl accesscloudlet region=EU cloudlet-org=myoperator cloudlet=mycloudlet1 node-type=sharedrootlb
ubuntu@mycloudlet1:~$
```

Shared Root LB runs each clusters Load Balancer as a docker container using envoy

```
$ docker ps
CONTAINER ID   IMAGE                                                                COMMAND                  CREATED         STATUS        PORTS     NAMES
ede8d8bc992e   docker.mobiledgex.net/mobiledgex/mobiledgex_public/envoy-with-curl   "/docker-entrypoint.…"   5 months ago    Up 5 months             envoymobiledgexsdkdemo20gputestvcd
a05fbc93c61a   docker.mobiledgex.net/mobiledgex/mobiledgex_public/envoy-with-curl   "/docker-entrypoint.…"   6 months ago    Up 6 months             envoytestssh-container20210917
9e780bc811e0   docker.mobiledgex.net/mobiledgex/mobiledgex_public/envoy-with-curl   "/docker-entrypoint.…"   7 months ago    Up 7 months             envoymwgame11
3b9b823c3dc8   docker.mobiledgex.net/mobiledgex/mobiledgex_public/envoy-with-curl   "/docker-entrypoint.…"   10 months ago   Up 7 months             envoytelefonicamexsmokepingvcd20210528
```

Envoy Configuration files are found in ~ubuntu/envoy

```
$ ls -l ~ubuntu/envoy
total 20
drwxrwxr-x 3 ubuntu ubuntu 4096 Apr  3 09:05 certs
drwxrwxr-x 2 ubuntu ubuntu 4096 Oct 26 05:38 mobiledgexsdkdemo20gputestvcd
drwxrwxr-x 2 ubuntu ubuntu 4096 Sep  3  2021 mwgame11
drwxrwxr-x 2 ubuntu ubuntu 4096 May 27  2021 telefonicamexsmokepingvcd20210528
drwxrwxr-x 2 ubuntu ubuntu 4096 Sep 22  2021 testssh-container20210917
```
