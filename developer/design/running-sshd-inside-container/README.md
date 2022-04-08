---
title: Running SSHD Inside a Container
long_title: 
overview_description: 
description: 
Best Practices on How to Run SSH Inside a Container

---

MobiledgeX provides terminal access to your containers from the [Edge-Cloud Console](https://console.mobiledgex.net/), but there are times when it is desirable to connect to containers from the network. To do this, you will need to add an SSH server to your container. This guide provides you with the steps to successfully add an SSH server and run SSH inside your container. There are two ways of performing this. The first and simplest method is a basic terminal command shown in the Terminal Debugging Example. The second method is a more thorough and manual process shown in the SSHD Example.

**Important Notes:**

- Allowing SSH access to your container has security implications, which should be taken into account before you open access.
- Port 22 is blocked by default for MobiledgeX containers, as it is used internally for management. You will need to use a different port for your SSH daemon.
- If you are using a shared load balancer, you need to check the allocated port for your provisioned Application Instance. The MobiledgeX platform will first try to allocate the requested port from the shared load balancer, and if that port is not available, you will be assigned a random, free port.

## Terminal Debugging Example

Open the terminal. Input `sh`, which will start an interactive terminal for you to start debugging the container. Your console will now should appear like this:

```
johndoe@JDOE-MAC ~ % sh
sh-3.2$ 
```

The header for your terminal window should read sh as well now. More info about using the terminal can be found in the <a href="https://developers.mobiledgex.com/deployments/deployment-workflow/app-instances/#using-terminal">
**Application Instances</a>** article.

## SSHD Example

For this example, we will be showing how to provide access to a container that is created by a `docker-compose.yaml` file. This same approach can be taken for a Kubernetes-based deployment using a Kubernetes manifest or a Helm chart.

### Base image

We will be using the [linuxserver/openssh-server](https://hub.docker.com/r/linuxserver/openssh-server) container. If you need to add an SSH server to an existing container definition, it is recommended that you review the code for this image at [github](https://github.com/linuxserver/docker-openssh-server) and use that as a guide for your work.

### Sample compose file

This file is provided as an example only. At the very minimum, you will need to set the following:

- The timezone (TZ)
- The public ssh key (PUBLIC_KEY); this is preferred over password authentication
- The port to use; for this example, we are using port 2222

Optionally, you can enable password access.

```
---
version: "2.1"
services:
  openssh-server:
    image: linuxserver/openssh-server
    container_name: openssh-server
    hostname: openssh-server #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/Denver
      - PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDh6ROxdnUrSAmjyqzlpvcSFlXcSwD7VMp7PvCTzAtDePSluBiQq3njWW88Pcxgmhsqhsm/ZjRKTdFO5RWRt2YM3BsZQqIMlsulIKK426RavgtnMYpJuUhTkyVm1QQAaoOH4NvkBOk35VOWylzxSZFa2v+LExjOQzQM5CfXB2GX7KerNNvEMNuTnFQ5upuV8YOEeeeomfLmt/I8VMxFJiSQWlELkS2NBVbhWKHcRaE2T2X2eASaruqlDhSMgeE0K/8bRuLquvv5j0F3rQ6slbVi0zjdIMRUlwD4gsZOQaSiFrQceItR+slp3/2FT/o6uxW/lJu3sW5RkHNHMxubSFpl jschmidt@jack.virington.com"
        ##- PUBLIC_KEY_FILE=/path/to/file #optional
      - SUDO_ACCESS=false #optional
      - PASSWORD_ACCESS=true #optional
      - USER_PASSWORD=SshUserPassword #optional
        ##- USER_PASSWORD_FILE=/path/to/file #optional
      - USER_NAME=sshuser #optional
    ports:
      - 2222:2222
    restart: unless-stopped   

```

### Deploy to MobiledgeX

The steps to create and deploy an application to the MobiledgeX platform are out of scope for this document, but can be reviewed at the [MobiledgeX Developer Portal] ([https://developers.mobiledgex.com/](/developer)). The application and application instance definitions for this exercise are provided here as a reference.

#### Application definition

```
$ mcctl  --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) region ShowApp region=EU app-org=demoorg appname=sshtest appvers=1.0
- key:
    organization: demoorg
    name: sshtest
    version: "1.0"
  imagetype: ImageTypeDocker
  accessports: tcp:2222
  defaultflavor:
    name: m4.small
  deployment: docker
  deploymentmanifest: |-
    ---
    version: "2.1"
    services:
      openssh-server:
        image: linuxserver/openssh-server
        container_name: openssh-server
        hostname: openssh-server #optional
        environment:
          - PUID=1000
          - PGID=1000
          - TZ=America/Denver
          - PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDh6ROxdnUrSAmjyqzlpvcSFlXcSwD7VMp7PvCTzAtDePSluBiQq3njWW88Pcxgmhsqhsm/ZjRKTdFO5RWRt2YM3BsZQqIMlsulIKK426RavgtnMYpJuUhTkyVm1QQAaoOH4NvkBOk35VOWylzxSZFa2v+LExjOQzQM5CfXB2GX7KerNNvEMNuTnFQ5upuV8YOEeeeomfLmt/I8VMxFJiSQWlELkS2NBVbhWKHcRaE2T2X2eASaruqlDhSMgeE0K/8bRuLquvv5j0F3rQ6slbVi0zjdIMRUlwD4gsZOQaSiFrQceItR+slp3/2FT/o6uxW/lJu3sW5RkHNHMxubSFpl jschmidt@jack.virington.com"
            ##- PUBLIC_KEY_FILE=/path/to/file #optional
          - SUDO_ACCESS=false #optional
          - PASSWORD_ACCESS=true #optional
          - USER_PASSWORD=SshUserPassword #optional
            ##- USER_PASSWORD_FILE=/path/to/file #optional
          - USER_NAME=sshuser #optional
        ports:
          - 2222:2222
        restart: unless-stopped
  accesstype: AccessTypeLoadBalancer  

```

### Application instance definition

```
$ mcctl  --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) region ShowAppInst region=EU app-org=demoorg appname=sshtest appvers=1.0
- key:
    appkey:
      organization: demoorg
      name: sshtest
      version: "1.0"
    clusterinstkey:
      clusterkey:
        name: autoclustersshtest
      cloudletkey:
        organization: TDG
        name: munich-main
      organization: demoorg
  cloudletloc:
    latitude: 48.1351
    longitude: 11.582
  uri: munich-main.tdg.mobiledgex.net
  liveness: LivenessStatic
  mappedports:
  - proto: LProtoTcp
    internalport: 2222
    publicport: 10000
  flavor:
    name: m4.small
  state: Ready
  runtimeinfo:
    containerids:
    - openssh-server
  createdat:
    seconds: 1603899652
    nanos: 742336385
  autoclusteripaccess: IpAccessShared
  healthcheck: HealthCheckOk
  powerstate: PowerOn
  vmflavor: m4.small  

```

#### Testing

To test, we will use a standard SSH client. You can retrieve the assigned port and URI from either the console or by using the `mcctl` utility.

##### Retrieve connection information

```
$ mcctl  --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) region ShowAppInst region=EU app-org=demoorg appname=sshtest appvers=1.0  | egrep "uri|publicport"
  uri: munich-main.tdg.mobiledgex.net
    publicport: 10000  

```

##### Test

```
$ ssh munich-main.tdg.mobiledgex.net -p 10000 -l sshuser
sshuser@munich-main.tdg.mobiledgex.net’s password:
Welcome to OpenSSH Server
openssh-server:~$ df
Filesystem     1K-blocks    Used Available Use% Mounted on
overlay         20145724 2975160  17154180  15% /
tmpfs              65536       0     65536   0% /dev
tmpfs            1020356       0   1020356   0% /sys/fs/cgroup
/dev/vda1       20145724 2975160  17154180  15% /etc/hosts
shm                65536       0     65536   0% /dev/shm
tmpfs            1020356       0   1020356   0% /proc/acpi
tmpfs            1020356       0   1020356   0% /proc/scsi
tmpfs            1020356       0   1020356   0% /sys/firmware
openssh-server:~$ uptime
 09:47:23 up 7 min,  0 users,  load average: 0.01, 0.19, 0.14   

```

#### Troubleshooting

If you experience issues connecting, please check the following.

- Ensure you are using the correct port and hostname; check the URI and public port values for the Application Instance.
- Ensure you are using the correct username, password, or public key; check the compose file to validate the values.
- If you are still having issues, add debug output to your SSH command (ie, `ssh -vvv`) to see if you can determine the issue.

