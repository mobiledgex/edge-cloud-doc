# DME

The DME is the primary interface to discover applications hosted on the
MobiledgeX platform. It exposes a REST API which can be used by client
applications (including the SDK) to find the best cloudlet hosting a particular
appinstance.

## DME discovery

DMEs are deployed alongside the controller in each region cluster. However,
this is not a hard restriction, and DMEs can be deployed anywhere necessary,
with the only requirement being that they need to be able to establish a
communication channel with the controller.

In addition to the DMEs, DNS CNAME aliases are set up for operators based on
their MCC-MNC codes: https://www.mcc-mnc.com/. The setup of these CNAMEs is a
manual process and not every operator has MCC-MNC codes set up in DNS. The
primary consumer for the MCC-MNC CNAME records is the client SDK which
determines the operator MCC/MNC from the user's mobile device, and uses that to
locate the right DME using the DNS CNAME for the MCC/MNC.

Example:
```
$ host 222-01.dme.mobiledgex.net
222-01.dme.mobiledgex.net is an alias for eu-mexdemo.dme.mobiledgex.net.
eu-mexdemo.dme.mobiledgex.net has address 40.118.43.19
```

In addition, there is a special DME entry called `wifi.dme.mobiledgex.net`
which uses GeoDNS to resolve to the DME instance closest to the client
performing the DNS lookup.

https://dnschecker.org/#A/wifi.dme.mobiledgex.net

## DME REST API

The primary API endpoints used by clients of the DME are these:

### RegisterClient

Registers the client with the closest DME.

```shell
curl -s -X POST https://wifi.dme.mobiledgex.net:38001/v1/registerclient \
        -d '{
                "app_name": "MobiledgeX SDK Demo",
                "app_vers": "2.0",
                "org_name": "MobiledgeX",
                "ver": 1
        }'
```

### FindCloudlet

Locates the best cloudlet hosting the requested application.  Requires the
session cookie returned by RegisterClient.

```shell
REGCLIENT=$( curl -s -X POST https://wifi.dme.mobiledgex.net:38001/v1/registerclient \
        -d '{"app_name": "MobiledgeX SDK Demo", "app_vers": "2.0", "org_name": "MobiledgeX"}' )

SESSCOOKIE=$( echo "$REGCLIENT" | jq -r .session_cookie )

curl -s -X POST https://wifi.dme.mobiledgex.net:38001/v1/findcloudlet \
        -d '{
                "session_cookie": "'${SESSCOOKIE}'",
                "carrier_name": "TDG",
                "gps_location": {"latitude": 48.0, "longitude": 11.0},
                "ver": 1
        }'
```
