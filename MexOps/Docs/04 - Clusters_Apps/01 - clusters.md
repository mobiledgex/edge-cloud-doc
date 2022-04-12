# Clusters

The primary cluster types are:
  * Kubernetes
  * Docker
  * VM

## Kubernetes Clusters

The CRM sets up a k8s master and zero or more worker nodes. (If the number of
worker nodes is zero, the master will be configured to run application loads.
If not, master will only run the k8s control plane.)

The kubeconfig for the k8s cluster is placed in the home directory of the
ubuntu user in the root LB. For instance:
  * `/home/ubuntu/matsuko-k8s-bcn.Telefonica.kubeconfig`

`kubeadm` is used to deploy the cluster. The scripts to deploy the cluster
are included in the `mobiledgex` package which is pre-installed on all base images.
  * https://github.com/mobiledgex/edge-cloud-infra/blob/master/openstack-tenant/packages/mobiledgex/install-k8s-master.sh
  * https://github.com/mobiledgex/edge-cloud-infra/blob/master/openstack-tenant/packages/mobiledgex/install-k8s-node.sh

Along with the k8s services, we also deploy the prometheus operator to retrieve
cluster metrics, and if required, the NFS provisioner and NVIDIA GPU operators.

## Docker Clusters

Docker clusters are simple single-VM clusters dedicated to an app instance. The
app instance container (or containers, in case of docker-compose) are launched
on the cluster VM with host-mode networking.

## VM

VM apps are initiated as dedicated VM instances from the developer-provided
QCOW2 images. No additional customisation is carried out on the VMs.
