---
title: Cloudlet Commands
long_title:
overview_description:
description: Use cloudlet metric commands using mcctl utility
---

## Cloudlet Metrics

```
Required Args:
  region        Region name
  cloudlet-org  Company or Organization name of the cloudlet
  selector      Comma separated list of metrics to view, utilization, network, ipusage

Optional Args:
  cloudlet      Name of the cloudlet
  last          Display the last X metrics
  starttime     Time to start displaying stats from
  endtime       Time up to which to display stats

```

### Data keys

- `time`
- `cloudlet`
- `cloudletorg`
- `vCpuUsed`
- `vCpuMax`
- `memUsed`
- `memMax`
- `diskUsed`
- `diskMax`
- `netSend`
- `netRecv`
- `floatingIpsUsed`
- `floatingIpsMax`
- `ipv4Used`
- `ipv4Max`

### Example

```
$ mcctl region=EU cloudlet-org=TDG selector=utilization,network,ipusage last=1
{
  "data": [
    {
      "Series": [
        {
          "columns": [
            "time",
            "cloudlet",
            "cloudletorg",
            "vCpuUsed",
            "vCpuMax",
            "memUsed",
            "memMax",
            "diskUsed",
            "diskMax",
            "netSend",
            "netRecv",
            "floatingIpsUsed",
            "floatingIpsMax",
            "ipv4Used",
            "ipv4Max"
          ],
          "name": "cloudlet-utilization",
          "values": [
            [
              "2020-06-08T22:38:00.458128973Z",
              "munich-main",
              "TDG",
              188,
              200,
              350208,
              512000,
              920,
              5000,
              null,
              null,
              null,
              null,
              null,
              null
            ]
          ]
        },
        {
          "columns": [
            "time",
            "cloudlet",
            "cloudletorg",
            "vCpuUsed",
            "vCpuMax",
            "memUsed",
            "memMax",
            "diskUsed",
            "diskMax",
            "netSend",
            "netRecv",
            "floatingIpsUsed",
            "floatingIpsMax",
            "ipv4Used",
            "ipv4Max"
          ],
          "name": "cloudlet-network",
          "values": [
            [
              "2020-06-08T01:52:29.244553765Z",
              "berlin-main",
              "TDG",
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              0,
              null,
              null,
              null,
              null
            ]
          ]
        },
        {
          "columns": [
            "time",
            "cloudlet",
            "cloudletorg",
            "vCpuUsed",
            "vCpuMax",
            "memUsed",
            "memMax",
            "diskUsed",
            "diskMax",
            "netSend",
            "netRecv",
            "floatingIpsUsed",
            "floatingIpsMax",
            "ipv4Used",
            "ipv4Max"
          ],
          "name": "cloudlet-ipusage",
          "values": [
            [
              "2020-06-08T22:38:08.425162762Z",
              "munich-main",
              "TDG",
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              0,
              10,
              33,
              1004
            ]
          ]
        }
      ]
    }
  ]

}
```

### Utilization example

Cloudlet utilization information.

```
$ mcctl metrics cloudlet region=US cloudlet-org=packet selector=utilization cloudlet=packetcloudlet last=1
data:
- series:
  - columns:
    - time
    - cloudlet
    - cloudletorg
    - vCpuUsed
    - vCpuMax
    - memUsed
    - memMax
    - diskUsed
    - diskMax
    name: cloudlet-utilization
    values:
    - - "2021-07-10T05:58:03.842430299Z"
      - packetcloudlet
      - packet
      - 24
      - 768
      - 49152
      - 97818
      - 0
      - 1000

```

`diskMax` Maximum available Disk size in GBs

`diskUsed` Disk used at a timestamp in GBs

`memMax` Maximum memory on this cloudlet in MBs

`memUsed` Memory used at timestamp in MBs

`vCpuMax` Maximum available number of vCPUs on this cloudlet

`vCpuUsed` Number vCPUs on this cloudlet at timestamp

### Network example

The total number of data sent and received in the Cloudlet in bytes. This is currently not supported on OpenStack.

```
$ mcctl metrics cloudlet region=US cloudlet-org=packet selector=network cloudlet=packetcloudlet last=1

data:
- series:
  - columns:
    - time
    - cloudlet
    - cloudletorg
    - netSend
    - netRecv
    name: cloudlet-network
    values:
    - - "2021-07-10T05:58:03.842430299Z"
      - packetcloudlet
      - packet
      - null
      - 0

```

### IPUsage example

Cloudlet utilization information.

```
$ mcctl metrics cloudlet region=US cloudlet-org=packet selector=ipusage cloudlet=packetcloudlet last=1
data:
- series:
  - columns:
    - time
    - cloudlet
    - cloudletorg
    - floatingIpsUsed
    - floatingIpsMax
    - ipv4Used
    - ipv4Max
    name: cloudlet-ipusage
    values:
    - - "2021-07-10T05:58:03.842430299Z"
      - packetcloudlet
      - packet
      - 0
      - 10
      - 4
      - 12

```

- `floatingIpsMax`: Max available number of floating IP addresses
- `floatingIpsUsad`: Number floating IP addresses on this cloudlet at timestamp
- `ipv4Max`: Max available number of external IPv4 addresses
- `ipv4Used`: Number external IPv4 addresses on this cloudlet at timestamp

## Client Cloudlet Usage Metrics

This command is used to collect latency and device information metrics for application instances deployed on cloudlets.

```
$ mcctl metrics clientcloudletusage region=US  -h
View client Cloudlet usage

Usage: mcctl metrics clientcloudletusage [flags] [args]

Required Args:
  region           Region name
  cloudlet-org     Company or Organization name of the cloudlet
  selector         Comma separated list of metrics to view. Available metrics: "latency", "deviceinfo"

Optional Args:
  cloudlet         Name of the cloudlet
  locationtile     Location tile. Provides the range of GPS coordinates for the location tile/square. Format is: "LocationUnderLongitude,LocationUnderLatitude_LocationOverLongitude,LocationOverLatitude_LocationTileLength". LocationUnder are the GPS coordinates of the corner closest to (0,0) of the location tile. LocationOver are the GPS coordinates of the corner farthest from (0,0) of the location tile. LocationTileLength is the length (in kilometers) of one side of the location tile square. Can be used for selectors: latency, deviceinfo.
  deviceos         Device operating system. Can be used for selectors: deviceinfo.
  devicemodel      Device model. Can be used for selectors: deviceinfo.
  devicecarrier    Device carrier. Can be used for selectors: latency, deviceinfo.
  datanetworktype  Data network type used by client device. Can be used for selectors: latency.
  limit            Display the last X metrics
  numsamples       Display X samples spaced out evenly over start and end times
  starttime        Time to start displaying stats from in RFC3339 format (ex. 2002-12-31T15:00:00Z)
  endtime          Time up to which to display stats in RFC3339 format (ex. 2002-12-31T10:00:00-05:00)
  startage         Relative age from now of search range start (default 48h)
  endage           Relative age from now of search range end (default 0)

Flags:
  -h, --help   help for clientcloudletusage

```

### Example

```
$ mcctl metrics clientcloudletusage region=US  selector=deviceinfo cloudlet-org=tmus limit=1
data:
- series:
  - columns:
    - time
    - numsessions
    name: device-metric
    tags:
      cloudlet: tmocloud-2
      cloudletorg: tmus
      devicecarrier: tmus
      devicemodel: Samsung S20
      deviceos: Android
      locationtile: -90.998922,30.993940_-91.007905,31.002985_1
    values:
    - - "2021-07-13T19:08:10.100138782Z"
      - 1

```

```

```

## Cloudlet Resource Usage Metrics

```
metrics cloudletusage -h
View Cloudlet usage

Usage: mcctl metrics cloudletusage [flags] [args]

Required Args:region
Region        name
cloudlet-org  Company or Organization name of the cloudlet
selector      Comma separated list of metrics to view. Available metrics: "resourceusage", "flavorusage"

Optional Args:
cloudlet      Name of the cloudlet
last          Display the last X metrics
starttime     Time to start displaying stats from in RFC3339 format (ex. 2002-12-31T15:00:00Z)
endtime       Time up to which to display stats in RFC3339 format (ex. 2002-12-31T10:00:00-05:00)

Flags:
  -h, --help   help for cloudlet resource usage

```

### Example: Resource usage

```
metrics cloudletusage region=EU cloudlet-org=TDG selector=resourceusage cloudlet=automationMunichCloudlet last=2
data:
series:
columns:
time
cloudlet
cloudletorg
externalIpsUsed
floatingIpsUsed
gpusUsed
instancesUsed
ramUsed
vcpusUsed
 name: openstack-resource-usage
 values:

- "2021-07-16T05:41:47.187017795Z"
automationMunichCloudlet
TDG
2
0
0
2
8192
4
- "2021-07-16T05:16:38.376372537Z"
automationMunichCloudlet
TDG
2
0
1
4
14336
8
```

### Example: Flavor usage

```
metrics cloudletusage region=EU cloudlet-org=TDG selector=flavorusage cloudlet=automationMunichCloudlet last=2
data:
series:
columns:
time
cloudlet
cloudletorg
count
flavor    name: cloudlet-flavor-usage
values:
- "2021-07-16T05:41:47.187017795Z"
automationMunichCloudlet
TDG
2
m4.medium
- "2021-07-16T05:16:38.376372537Z"
automationMunichCloudlet
TDG
1
m4.small-gpu
```

## CloudletInfo Show

This command provides information about cloudlet key, cloudlet state, cloudlet resources, flavors, platform VMs, clusters, trust policy and more, as shown in the example below.

###  Cloudletinfo show example

```
mcctl --addr https://console.mobiledgex.net cloudletinfo show region=EU cloudlet=automationHamburgCloudlet
- key:
    organization: TDG
    name: automationHamburgCloudlet
  state: CloudletStateReady
  notifyid: 29
  controller: controller-f9454c787-j8t4q@10.244.5.43:55001
  osmaxram: 512000
  osmaxvcores: 200
  osmaxvolgb: 5000
  flavors:
  - name: m4.xxlarge16
    vcpus: 16
    ram: 65536
    disk: 120
    propmap:
      hw: mem_page_size=large
  - name: m4.small-gpu
    vcpus: 2
    ram: 4096
    disk: 40
    propmap:
      hw: numa_nodes=1
      pci_passthrough: alias=t4gpu:1
  - name: m4.large-gpu
    vcpus: 4
    ram: 8192
    disk: 80
    propmap:
      hw: numa_nodes=1
      pci_passthrough: alias=t4gpu:1
  - name: m4.medium
    vcpus: 2
    ram: 4096
    disk: 40
    propmap:
      hw: mem_page_size=large
  - name: m4.xlarge-gpu
    vcpus: 4
    ram: 8192
    disk: 160
    propmap:
      hw: numa_nodes=1
      pci_passthrough: alias=t4gpu:1
  - name: m4.xxlarge32-64-160
    vcpus: 32
    ram: 65536
    disk: 160
    propmap:
      hw: mem_page_size=large
  - name: m4.xxlarge-gpu
    vcpus: 4
    ram: 32768
    disk: 160
    propmap:
      hw: numa_nodes=1
      pci_passthrough: alias=t4gpu:1
  - name: m4.large
    vcpus: 4
    ram: 8192
    disk: 80
    propmap:
      hw: mem_page_size=large
  - name: m4.tiny
    vcpus: 1
    ram: 512
    disk: 10
    propmap:
      hw: mem_page_size=large
  - name: m4.xlarge
    vcpus: 8
    ram: 16384
    disk: 160
    propmap:
      hw: mem_page_size=large
  - name: m4.xxxlarge-gpu
    vcpus: 8
    ram: 16384
    disk: 160
    propmap:
      hw: numa_nodes=1
      pci_passthrough: alias=t4gpu:1
  - name: m4.large-vgpu
    vcpus: 4
    ram: 8192
    disk: 80
    propmap:
      hw: mem_page_size=large
      resources: VGPU=1
  - name: ram64
    vcpus: 1
    ram: 64
    disk: 1
    propmap:
      hw: mem_page_size=large
  - name: m4.small
    vcpus: 2
    ram: 2048
    disk: 20
    propmap:
      hw: mem_page_size=large
  containerversion: 2021-06-08-1
  controllercachereceived: true
  resourcessnapshot:
    platformvms:
    - name: automationHamburgCloudlet-TDG-pf
      type: platform
      status: ACTIVE
      infraflavor: m4.medium
      ipaddresses:
      - externalip: 80.187.135.175
    - name: automationhamburgcloudlet.tdg.mobiledgex.net
      type: rootlb
      status: ACTIVE
      infraflavor: m4.medium
      ipaddresses:
      - externalip: 80.187.134.197
      - internalip: 10.101.28.1
    info:
    - name: RAM
      value: 339968
      inframaxvalue: 512000
      units: MB
    - name: vCPUs
      value: 178
      inframaxvalue: 200
    - name: Instances
      value: 67
      inframaxvalue: 100
    - name: Floating IPs
      inframaxvalue: 10
    clusterinsts:
    - clusterkey:
        name: cluster1623136354-852825
      organization: automation_dev_org
    - clusterkey:
        name: cluster1623158521-1634557
      organization: automation_dev_org
    - clusterkey:
        name: porttestcluster
      organization: MobiledgeX
  trustpolicystate: NotPresent
  compatibilityversion: 1

```

