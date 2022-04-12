# Global and Regional Components

### Accessing VMs

1.  Using teleport
    
    ```
    $ tsh ls
    console-dev   34.94.213.200:3022 env=dev
    gitlab-dev    34.102.61.0:3022   env=dev
    
    $ tsh ssh ansible@console-dev
    ```
    

2\. Log in using gcloud

```
gcloud compute ssh --tunnel-through-iap --zone="$ZONE" "$VM"
```

### Accessing Region Kubernetes Clusters

1.  Using teleport
    
    ```
    $ tsh kube ls
    Kube Cluster Name Selected
    ----------------- --------
    dev-eu
    
    $ tsh kube login dev-eu
    
    $ kubectl get pods
    ```
    

2\. Download credentials using Azure cli

```
$ az aks get-credentials -n "$NAME" -g "$RESGRP"
$ kubectl get pods
```

### Global Components

- Console
    
    - Runs as a docker container in the VM: console-&lt;setup&gt;.mobiledgex.net
        
    - ```
        $ docker inspect console-${SETUP}
        $ docker logs -f console-${SETUP}
        ```
        
- Master Controller
    
    - Runs as a docker container in the same VM as the console
        
    - ```
        $ docker inspect mc-${SETUP}
        $ docker logs -f mc-${SETUP}
        ```
        
- Rest of the global components run as docker containers on the same VM as the console and MC.
    
    - alertmanager
        
    - alertmgr-sidecar
        
    - notifyroot
        

### Regional Components

```
$ kubectl get pods
NAME                                   READY   STATUS      RESTARTS   AGE
autoprov-5d7559cbc-g98sn               1/1     Running     0          12d
cluster-svc-5cd6d48d7b-xgwxd           1/1     Running     0          12d
controller-865cb9b8d-4kr7d             1/1     Running     5          12d
dme-69d67b8c85-77vsh                   1/1     Running     0          12d
edgeturn-5dcdb79785-jgn5c              1/1     Running     0          12d
mex-etcd-0                             1/1     Running     0          213d
mex-etcd-1                             1/1     Running     0          213d
mex-etcd-2                             1/1     Running     0          213d
monitoring-influxdb-5cdc4b5c95-l55xb   1/1     Running     74         12d
telegraf-7dcc664b98-lqbsl              1/1     Running     0          213d
```

#### Service details

- autoprov
    
    - Handles automatic provisioning
        
- cluster-svc
    
    - Watches for ClusterInst notifications, and when a cluster is created, add MobiledgeX-specific applications (for instance, Prometheus) to the cluster.
        
- controller
    
    - The primary service which manages the region; uses etcd as the backing store
        
- dme
    
    - Service which provides look up of cloudlets and app instances
        
- edgeturn
    
    - Service that manages console access to the app instances and cloudlets. Commands like RunCommand and AccessCloudlet use this service.
        
- mex-etcd
    
    - Primary data store for the controller/region
        
- monitoring-influxdb
    
    - App/cluster/cloudlet metrics monitor
        
- telegraf
    
    - Monitoring of internal services running in the region kubernetes cluster