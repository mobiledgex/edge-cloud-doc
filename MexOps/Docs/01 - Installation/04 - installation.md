# Installation

## Architecture

![image](./images/components.png)


## Glossary

|     |     |     |     |
| --- | --- | --- | --- |
| **Component** | **Scope** | **Location** | **Description** |
| Master Controller | Global | Google Cloud | API and Authentication |
| Artifactory | Global | External Service, e.g JFROG | VM Image, Docker Compose and Kubernetes Manifest Repository |
| Docker Registry | Global | External Service, e.g. Harbor, Github Container Service, Gitlab | Registry for Docker Images |
| Postgres | Global | External service | Persistent datastore for MobiledgeX configuration |
| Vault | Global | External Service | Secrets and PKI |
| ElasticSearch | Global | External Service | Backend for Jaeger (tracing data) and events |
| Regional Controller | Regional (at least one) | Google Cloud | Manages cloudlets, App/cluster deployments, metrics gathering, auto provisioning and scaling.<br><br>Region can be any chosen territory such as a country, geo region (e.g. EMEA) etc. |
| DME | Regional | Part of Regional Controller | DME API for edge discovery and events |
| Influxdb | Regional | External Service (1 per region) | Metrics persistence |
| Etcd | Regional | External Service (1 per region) | App Inst/Cluster state persistence |

## Prerequisites

### Mandatory Components

- A docker registry for hosting the edge-cloud components. We use [Harbor](https://goharbor.io/), but any docker registry will work, including the [GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry).
    
- Set up a [GCP project](https://developers.google.com/workspace/marketplace/create-gcp-project) and create a service account with credentials to manage VMs and firewalls. The service account needs at least the following privileges:
    
    1.  Compute Instance Admin
        
    2.  Compute Load Balancer Admin
        
    3.  VPC Firewalls User
        
- Our platform currently only supports Cloudflare for managing DNS records. [Set up Cloudflare](https://developers.cloudflare.com/dns/zone-setups/full-setup/setup/) as the authoritative name server for the full domain.
    
    - Additionally, DME uses [NS1](https://ns1.com/) to set up GeoDNS. This is not mandatory, and if this is skipped, just pass a random string as the NS1 token wherever required.
        
- A PostgreSQL database for MC’s database.
    
- An ElasticSearch instance. We use [Elastic Cloud](https://www.elastic.co/cloud/).
    
- Set up a [teleport cluster](https://goteleport.com/docs/installation/) and record its proxy IP/hostname
    
- Set up an [InfluxDB 1.8 installation](https://docs.influxdata.com/influxdb/v1.8/) for recording time series data for the infrastructure components.
    

## Instructions

There are some additional changes to support setting up independent setups which are not in the primary Github branch yet. Until the changes are merged, use the [new-setup](https://github.com/mobiledgex/edge-cloud-infra/tree/new-setup) branch of the edge-cloud-infra repo to deploy the setup.

```
git clone https://github.com/mobiledgex/edge-cloud-infra.git
cd edge-cloud-infra
git switch new-setup
```

### Set up the environment

```
export TF_VAR_cloudflare_account_email="<cloudflare-account-email>"
export TF_VAR_cloudflare_account_api_token="<cloudflare-account-api-token>"
export TF_VAR_cloudflare_zone_id="<cloudflare-zone-id>"
export GOOGLE_APPLICATION_CREDENTIALS="<path-to-gcp-service-account-file>"
export GOOGLE_CLOUD_KEYFILE_JSON="$GOOGLE_APPLICATION_CREDENTIALS"
```

### Set up global firewall rules in GCP

```
$ cd edge-cloud-infra/terraform/mexplat/global

## Remove the `provider "azurerm"` and `terraform`/`backend` sections
## to make terraform operate locally, or replace them with a different backend

$  terraform version
Terraform v0.12.31

$ terraform plan
$ terraform apply
```

### Set up vault

#### Set up a fallback SSH CA

```
ssh-keygen -f fallback-ssh-ca
```

Archive the private key somewhere safe, and make the public key available ..uh.. publicly, like in a public GCS bucket. Our SSH public key is available here: https://storage.googleapis.com/mobiledgex-downloads/fallback-ssh-ca.pub

Update the fallback public key location in terraform config here: edge-cloud-infra/terraform/modules/vm_gcp/cloud-config.yaml

#### Generate an SSH cert for initial vault setup

```
ssh-keygen -s fallback-ssh-ca \
  -I "$(whoami)@$(hostname) user key" \
  -n ansible \
  -V -5m:+6h \
  ~/.ssh/id_rsa.pub
```

#### Update teleport config

Update the teleport\_proxy\_source_ip parameter in edge-cloud-infra/terraform/modules/fw\_teleport\_node_gcp/variables.tf

#### Bring up the vault VMs

```
cd edge-cloud-infra/terraform/mexplat/_tmpl
terraform-0.13.7 apply \
  -target=module.vault_a_dns.cloudflare_record.vm \
  -target=module.vault_b_dns.cloudflare_record.vm \
  -target=module.vault_c_dns.cloudflare_record.vm \
  -target=module.vault_a.google_compute_instance.vm \
  -target=module.vault_b.google_compute_instance.vm \
  -target=module.vault_c.google_compute_instance.vm
```

#### Deploy vault

This will set up a three node HA vault instance, along with all the loadbalacing plumbing in Google Cloud.

```
cd edge-cloud-infra/ansible
ansible-playbook --skip-tags vault_ssh,monitoring -i test.tf.yml \
  -e mex_docker_username="$HARBOR_USER" \
  -e mex_docker_password="$HARBOR_PASS" \
  -e cloudflare_account_email="$CF_USER" \
  -e cloudflare_account_api_token="$CF_TOKEN" \
  -e artifactory_token="$ARTF_TOKEN" \
  -e ns1_apikey="$NS1_APIKEY" vault.yml
```

It can take half an hour, sometimes even longer, for GCP to issue a cert for the new vault loadbalancer.

#### Initialise vault

```
export VAULT_ADDR=https://vault-test-a.mobiledgex.net:8200
vault operator init
```

This will print out the unseal codes as well as the initial root token for the vault. Make sure these are stored somewhere secure. There will be five unseal codes, and these are designed to be distributed among multiple people. To unseal a vault (for instance, after a restart or reboot of a VM), any three of the five unseal codes will be required.

#### Unseal all vault instances

```
for inst in a b c; do
  export VAULT_ADDR=https://vault-test-${inst}.mobiledgex-dev.net:8200
  vault operator unseal
done
```

#### Configure the secret engines, roles, and policies in vault

```
cd edge-cloud-infra/ansible
./deploy.sh -p vault-setup.yml -s vault_ssh -x \
  -e vault_address=https://vault-test.mobiledgex.net \
  test.tf.yml
```

#### Populate vault data

The following parameters need to be set in vault

- Initialise the JWT keys
    
    ```
    export VAULT_ADDR=https://vault-test.mobiledgex.net
    vault kv put jwtkeys/dme secret=${RANDSTRING1?} refresh=60m
    vault kv put jwtkeys/mcorm secret=${RANDSTRING2} refresh=60m
    ```
    
- Set up MC admin account credentials
    
    ```
    vault kv put secret/ansible/${SETUP:-test}/accounts/mc \
        db=mcdb db_username=mcuser superuser=mexadmin \
    	db_password=abcd1234 superpass=efgh5678
    
    vault kv put secret/ansible/${SETUP:-test}/accounts/mc_ldap \
        username=gitlab password=XXXXXXXX
    ```
    
- Set up vault data for the following keys (TODO Add sample data for each key)
    
    - secret/accounts/azure
        
    - secret/accounts/chef
        
    - secret/accounts/cloudflare
        
    - secret/cloudlet/openstack/mexenv.json
        
    - secret/cloudlet/gcp/auth_key.json
        
    - secret/ansible/common/accounts/artifactory
        
    - secret/ansible/common/accounts/artifactory_publish
        
    - secret/ansible/common/accounts/azure
        
    - secret/ansible/common/accounts/cloudflare
        
    - secret/ansible/common/accounts/gcp
        
    - secret/ansible/common/accounts/locapi
        
    - secret/ansible/common/accounts/mex_docker
        
    - secret/ansible/common/accounts/ns1
        
    - secret/ansible/common/accounts/sendgrid
        
    - secret/ansible/common/accounts/telegraf
        
    - secret/ansible/internal/accounts/influxdb
        
    - secret/ansible/common/accounts/recaptcha
        
    - secret/accounts/noreplyemail
        
- Add credentials for Artifactory and the docker registry. Current setup uses the following:
    
    - secret/registry/artifactory.mobiledgex.net
        
    - secret/registry/registry.mobiledgex.net
        

### Set up region clusters in Azure

Set the parameters for the regions in edge-cloud-infra/ansible/_tmpl/vars.json

```
 "regions": [
    {
      "kubernetes_version": "1.20.15",
      "latitude": 52.3667,
      "location": "northeurope",
      "longitude": 4.9,
      "name": "mexplat-test-eu",
      "region": "EU"
    }
  ]
```

Provision the region clusters

```
cd edge-cloud-infra/ansible
./deploy.sh -p region-setup.yml \
  -e vault_address=https://vault-test.mobiledgex.net \
  test.tf.yml
```

### Provision the rest of the global infrastructure

Use terraform again to provision the rest of the global infrastructure (console, jaeger, etc.)

```
cd edge-cloud-infra/terraform/mexplat/_tmpl
terraform-0.13.7 apply
```

### Deploy the complete platform

```
cd edge-cloud-infra/ansible
./deploy -e vault_address=https://vault-test.mobiledgex.net test.tf.yml
```
