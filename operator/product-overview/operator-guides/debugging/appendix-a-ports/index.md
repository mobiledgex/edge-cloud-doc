---
title: Inbound and Outbound Ports
long_title:
overview_description:
description: Learn which ports are used to manage inbound/outbound traffic on the MobiledgeX platform
---

## What Ports are Being Used

The MobiledgeX platform is designed to manage inbound/outbound network traffic for the application instances hosted on the platform. This means that the MobiledgeX platform can manage a block of internet routable addresses for the usage of tenants.

In the event that there is a need to firewall off the network used by the MobiledgeX platform it will be necessary to add rules to the firewall to permit traffic as required.

The information needed to do this can be retrieved either via the API or via the `mcctl` utility program.

### URI

The URI for an application instance is part of the definition for that application instance. It can be retrieved with the following code:

`$ mcctl --output-format json --addr https://console.mobiledgex.net region ShowAppInst region=EU cloudlet-org=someorg | json -Hag key.app_key.name uri test01 docker-cluster1.testcloudlet.someorg.mobiledgex.net test02 docker-cluster2.testcloudlet.someorg.mobiledgex.net test03 docker-cluster3.testcloudlet.someorg.mobiledgex.net`

### Inbound ports

When looking at inbound ports, it is important to understand the difference between *public_port* and *internal_port*. A public port is the port that is exposed to the internet via the loadbalancer or directly. An internal port is used internally within the MobiledgeX platform.

Each port definition includes the type of traffic the port will handle. The table below maps the value to the protocol.

| Value | Protocol |
|-------|----------|
| 0     | Unknown  |
| 1     | TCP      |
| 2     | UDP      |

The port mappings for a given application instance can be retrieved from the API via the following code:

```
$ mcctl --output-format json --addr https://console.mobiledgex.net region ShowAppInst region=EU cloudlet-org=someorg | json -Hag  key.app_key.name uri mapped_ports
test01 docker-cluster1.testcloudlet.someorg.mobiledgex.net [
  {
    "proto": 2,
    "internal_port": 4705,
    "public_port": 4705
  },
  {
    "proto": 1,
    "internal_port": 4705,
    "public_port": 4705
  }

]
test02 docker-cluster1.testcloudlet.someorg.mobiledgex.net [
  {
    "proto": 1,
    "internal_port": 80,
    "public_port": 80
  }

]
test03 docker-cluster1.testcloudlet.someorg.mobiledgex.net [
  {
    "proto": 1,
    "internal_port": 2222,
    "public_port": 2222
  }

```

### Outbound ports

By default, the MobiledgeX platform allows all outbound traffic. Using privacy policies, it is possible to control outbound traffic. This can range from the default (all outbound traffic is permitted), to "full isolation," where no outbound traffic is permitted.

When managing a MobiledgeX deployment behind a firewall where site policies require restrictions on outbound ports it is recommended the privacy policies be put in place on the MobiledgeX platform as well as being enforced by the firewall. This makes it easier to troubleshoot network issues.

Reviewing the defined privacy policies requires a two step process.

First, you need to find application instances that have attached privacy policies. This can be done with the following code:<br>

```
$ mcctl --output-format json --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) region ShowAppInst region=EU cloudlet-org=someorg | json -Hag  key.app_key.name uri privacy_policy

test01 docker-cluster1.testcloudlet.someorg.mobiledgex.net privacypolicy01
test02 docker-cluster2.testcloudlet.someorg.mobiledgex.net privacypolicy02
test03 docker-cluster3.testcloudlet.someorg.mobiledgex.net

```

Once you have identified the policies in use, you can use `mcctl` to view the defined policies.

```
$ mcctl --output-format json --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) region ShowPrivacyPolicy region=EU cluster-org=someorg
[
  {
    "key": {
      "organization": "someorg",
      "name": "privacypolicy01"
    },
    "outbound_security_rules": [
      {
        "protocol": "udp",
        "port_range_min": 53,
        "port_range_max": 53,
        "remote_cidr": "0.0.0.0/0"
      },
      {
        "protocol": "tcp",
        "port_range_min": 443,
        "port_range_max": 443,
        "remote_cidr": "0.0.0.0/0"
      }
    ]
  },
  {
    "key": {
      "organization": "someorg",
      "name": "privacypolicy02"
    },
    "outbound_security_rules": [
      {
        "protocol": "tcp",
        "port_range_min": 8000,
        "port_range_max": 8100,
        "remote_cidr": "255.255.255.0/24"
      }
    ]
  },

```

<br>The policy includes the port range, the CIDR, and the protocol affected.

