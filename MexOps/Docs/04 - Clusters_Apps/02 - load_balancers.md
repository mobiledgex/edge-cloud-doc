# Load Balancers

Envoy is used for load balancing in the rootLBs. It does the following:
  * Reverse proxy to the ports/services exposed by the apps
  * TLS termination and certificate management. (Certs are from LetsEncrypt.)
  * Traffic monitoring and metrics
  * Health checks

Config Path on the root LB:
  * `~/envoy/<app>/envoy.yaml`

Envoy exposes a metrics interface which shepherd scrapes to retrieve app and
cluster metrics. The metrics interface details will be in `envoy.yaml`. For
instance:

```
...
admin:
  access_log_path: "/tmp/admin.log"
  address:
    socket_address:
      address: 127.2.255.255
      port_value: 65121
```

Certificates are shared across all applications behind a root LB.  Certificates
are stored in the root LB:
  * `~/envoy/certs/`
