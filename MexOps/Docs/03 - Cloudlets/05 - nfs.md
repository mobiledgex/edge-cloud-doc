# NFS

## Host setup on the cluster VMs

The k8s master is set up as an NFS server, with a volume mounted in `/share`.
The backing store for the volume is provided by the IaaS.

```
$ systemctl status nfs-server
```

## NFS operator

The `nfs-client-provisioner` chart is deployed to the app cluster for apps
which make PhysicalVolumeClaims.

https://github.com/helm/charts/tree/master/stable/nfs-client-provisioner

PVCs are satisfied by this provisioner by creating NFS shares on demand on the
master and exporting them to the required node.
