# Troubleshooting

## Logging into VMs

### PlatformVM

Via accesscloudlet command of mcctl with node-type=platformvm

Example:

```
$ mcctl accesscloudlet region=EU cloudlet-org=myoperator cloudlet=mycloudlet1 node-type=platformvm
ubuntu@mycloudlet1-myoperator-pf:~$
```

### Shared LB

Via accesscloudlet command of mcctl with node-type=sharedrootlb

Example:

```
$ mcctl accesscloudlet region=EU cloudlet-org=myoperator cloudlet=mycloudlet1 node-type=sharedrootlb
ubuntu@mycloudlet1:~$
```

### Cluster Dedicated Root LB

Via accesscloudlet command of mcctl with node-name={cluster-name}

You can omit the node-name parameter value to see a list of available clusters.

```
$ mcctl accesscloudlet region=EU cloudlet-org=Telefonica cloudlet=tde-madrid1 node-name=
Error: Bad Request (400), Too many nodes matched, please specify type and name from: [{platformvm tde-madrid1-Telefonica-pf} {sharedrootlb tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb matsuko-k8s-madrid-2.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb matsuko-k8s-madrid.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb tlf-external.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb reservable0.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb nemocluster.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb telefonica-tde-madrid.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb umstefweb.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb umstefmission.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb reservable1.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb protestipx.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb umstef.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb postupgrademadriddockerdedicated.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb cluster-cjvxxr6fkprdzdrlf1g5sihxca.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb markr-systems.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb umstefgpu.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb yerbabuenavrubuntu-nginxv2.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb astiasti-w1010.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb mawarimawariwindowsserver19v1.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb doubleme-incws2016-doubleme-tef10.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb mawarimawariwindowsserver19v1bis.tde-madrid1.telefonica.mobiledgex.net} {dedicatedrootlb odienceodienceaggregator15.tde-madrid1.telefonica.mobiledgex.net}]
```

Example:

```
$ mcctl accesscloudlet region=EU cloudlet-org=myoperator cloudlet=mycloudlet1 node-name=mycluster.mycloudlet.myoperator.mobiledgex.net
ubuntu@mycluster:~$
```

From here you can see the envoy container for the Load Balancer

```
$ docker ps
CONTAINER ID   IMAGE                                                                COMMAND                  CREATED       STATUS       PORTS     NAMES
30ac961dcb26   docker.mobiledgex.net/mobiledgex/mobiledgex_public/envoy-with-curl   "/docker-entrypoint.…"   3 weeks ago   Up 3 weeks             envoymy-app
```

A cluster can be used for multiple App Insts. Each App Inst gets it’s on load balancer container.

### Cluster VMs

Docker hosts and Kubernetes cluster VM’s cannot be access directly using mcctl accesscloudlet. To SSH to a cluster VM you must use accesscloudlet to the Load Balancer VM and then SSH across the internal network.

- Obtain a list of VM’s and IP Addresses
    
    - Docker example
        

```
$ mcctl clusterinst show region=EU cloudlet-org=Telefonica cloudlet=tde-madrid1 cluster=markr-systems | jq -r '.[].resources.vms[] | [ .ipaddresses[0].internalIp, .name, .type ] | join(" ")' | column -t
10.101.1.1    markr-systems.tde-madrid1.telefonica.mobiledgex.net  rootlb
10.101.1.101  mex-docker-vm-tde-madrid1-markr-systems-markr        cluster-docker-node
```

```
$ mcctl clusterinst show region=EU cloudlet-org=Telefonica cloudlet=tde-madrid1 cluster=matsuko-k8s-madrid | jq -r '.[].resources.vms[] | [ .ipaddresses[0].internalIp, .name, .type ] | join(" ")' | column -t
10.101.1.101                                              mex-k8s-node-1-tde-madrid1-matsuko-k8s-madrid-matsuko  cluster-k8s-node
10.101.1.10                                               mex-k8s-master-tde-madrid1-matsuko-k8s-madrid-matsuko  cluster-master
```

- Generate a new SSH key
    
    ```
    ssh-keygen -f .ssh/id_rsa -q -t rsa -N ''
    ```
    
- Set your Github token variable, e.g.
    
    ```
    export TOKEN=$(cat ~/.github)
    ```
    
- Run the following script to sign your SSH key using the token from VAULT. Note you must set the URL to your Vault system
    
    ```
    #!/bin/bash
    PATH='/usr/bin:/bin:/usr/local/bin'; export PATH
    set -e
    
    die() {
    	echo "ERROR: $*" >&2
    	exit 2
    }
    
    VAULT="https://{VAULT_URL}"
    
    KEY="$1"
    [[ -z "$KEY" ]] && KEY="$HOME/.ssh/id_rsa.pub"
    [[ -f "$KEY" ]] || die "Unable to find SSH public key to sign: $KEY"
    
    if [[ -z "$TOKEN" ]]; then
    	read -s -p "Github token: " TOKEN </dev/tty
    	echo
    fi
    [[ -z "$TOKEN" ]] && die "No token"
    
    VAULT_TOKEN=$( curl --silent \
    		--request POST \
    		--header "Content-Type: application/json" \
    		--data "{ \"token\": \"$TOKEN\"}" \
    		"${VAULT}/v1/auth/github/login" \
    		| jq -r .auth.client_token )
    
    PUBKEY=$( cat "$KEY" )
    
    SIGNED_KEY="$HOME/.ssh/signed-key"
    TMPFILE=$( mktemp )
    trap 'rm -f "$TMPFILE"' EXIT
    curl --silent \
    	--request POST \
    	--header "X-Vault-Token: $VAULT_TOKEN" \
    	--data "{\"public_key\": \"$PUBKEY\", \"ttl\": \"5m\", \"valid_principals\": \"ubuntu\"}" \
    	"${VAULT}/v1/ssh/sign/user" \
    	| jq -r '.data.signed_key // empty' >"$TMPFILE"
    [[ -s "$TMPFILE" ]] || die "Error signing key"
    mv "$TMPFILE" "$SIGNED_KEY"
    echo "Signed key: $SIGNED_KEY"%
    ```
    
- SSH to the VM
    
    ```
    ssh -i .ssh/signed-key -i .ssh/id_rsa 10.100.1.10
    ```
## Logs and Diagnostics

### All VMs

| **Logs** | **Description**
| --- | --- |
| `/var/log/syslog` | The system log to view events at the operating system level |
| `dmesg` | Kernel messages. May be useful after boot up. |

### PlatformVM

| **Logs** | **Description**
| --- | --- |
| `docker logs crmserver`  | CRM logs, useful when CRM appears to be misbehaving |
| `docker logs shepherd` | Check on the status of metrics |


### Load Balancers

| **Logs** | **Description**
| --- | --- |
| `docker logs {envoy container}`  | Envoy logs, useful when envoy needs debugging |


### Cluster VMs

| **Logs** | **Description**
| --- | --- |
| `docker logs {app container}`  | docker container logs, for docker deployments |
| `kubectl get pods -o wide` | List of pods (See below) |
| `kubectl logs {pod} [-c container]` | Gets the container logs for pod. May need -c when more than one container |

#### Kubernetes Information

MobiledgeX extends the manifest provided by the developer to add system components needed by the platform, such as prometheus.

The actual manifest that is applied to the cluster can be found on the Load Balancer in `~ubuntu/{appname}`

| **command** | **Description**
| --- | --- |
| `kubectl get pods -o wide` | List pods and their status |
| `kubectl describe pod {pod_name}` | Get details of the state of a Pod. Useful when a pod is stuck in `pending` |
| `kubectl delete pod {pod_name}` | Deleting a pod is the easiest way to restart it. K8s will restart automatically |

### Using tcpdump

`tcpdump` is not installed in the base image for VM's. To install run

```
sudo -i
apt-get update
apt-get install tcpdump
```

On a Load Balancer there may be 2 interfaces of interest. One for external network and one for internal. Typicall the external interface is `ens160` and internal is `ens224`, but you should check this with `ifconfig`

```
$ ifconfig
--snip--

ens160: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.101.1.1  netmask 255.255.255.0  broadcast 10.101.1.255
        inet6 fe80::250:56ff:fe09:179a  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:09:17:9a  txqueuelen 1000  (Ethernet)
        RX packets 2837766  bytes 1528684259 (1.5 GB)
        RX errors 0  dropped 49  overruns 0  frame 0
        TX packets 2508770  bytes 1438839366 (1.4 GB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens224: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.10.100.7  netmask 255.255.255.0  broadcast 10.10.100.255
        inet6 fe80::250:56ff:fe09:179b  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:09:17:9b  txqueuelen 1000  (Ethernet)
        RX packets 70109398  bytes 11591582009 (11.5 GB)
        RX errors 0  dropped 155  overruns 0  frame 0
        TX packets 68920856  bytes 771226225612 (771.2 GB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

By default tcpdump uses the first interface. You can chnage this with `-i ens224` or `-i any`
Tracing all traffic may be overwhelming so it's best to use filters.

* Specific port - `tcpdump port 80`
* Source IP/name - `tcpdump src 1.2.3.4`
* Destination IP/name - `tcpdump dst host-name`
* Host IP/name (src and dst) - `tcpdump host 1.2.3.4`
* Protocol - `tcpdump tcp` or `tcpdump udp` or `tcpdump icmp`