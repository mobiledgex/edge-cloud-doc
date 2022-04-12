# Configuring External Services

## Artifactory

Artifactory is installed and upgraded using Ansible. See [Artifactory upgrade
process](../upgrade_maintenance/global_regional.md#upgrade-artifactory) for
details.

## Chef

### Install Chef

```shell
wget https://packages.chef.io/files/stable/chef-server/13.2.0/ubuntu/16.04/chef-server-core_13.2.0-1_amd64.deb
dpkg -i chef-server-core_13.2.0-1_amd64.deb
chef-server-ctl reconfigure
```

Verify installation:
```shell
curl -D - http://localhost:8000/_status
```

Create admin user:
```shell
chef-server-ctl user-create chefadmin Chef Admin ${EMAIL?} ${PASSWORD?} --filename ./chefadmin.pem
```

Create org: (Current setup uses the org name "mobiledgex")
```shell
chef-server-ctl org-create mobiledgex "MobiledgeX Inc."--association_user chefadmin --filename mobiledgex-validator.pem
```

Add admin user to org:
```shell
chef-server-ctl org-user-add mobiledgex chefadmin
```

### Set up the knife CLI

The [knife](https://docs.chef.io/workstation/knife_setup/) CLI is used to
interact with chef remotely.  Knife is installed as part of the [Chef
Workstation](https://docs.chef.io/workstation/install_workstation/) package.

Verify installation:
```shell
$ knife -v
Chef Infra Client: 15.10.12

$ chef -v
Chef Workstation version: 0.18.3
Chef Infra Client version: 15.10.12
Chef InSpec version: 4.18.111
Chef CLI version: 2.0.10
Test Kitchen version: 2.5.0
Cookstyle version: 6.3.4
```

Create the following file in `~/.chef/knife.rb` to configure the CLI tools to talk to the chef master.
```
current_dir = File.dirname(__FILE__)
home_dir = Dir.home

log_level                 :info
log_location              STDOUT
node_name                 "chefadmin"
client_key                "#{current_dir}/chefadmin.pem"
chef_server_url           "https://chef.mobiledgex.net/organizations/mobiledgex"
cookbook_path             [ "#{home_dir}/go/src/github.com/mobiledgex/edge-cloud-infra/chef/cookbooks/" ]
```

Copy the `chefadmin.pem` file generated previously into `~/.chef/chefadmin.pem`.

Verify that knife commands work:
```shell
knife node list
```

### Setup databags

```shell
$ knife data bag create mexsecrets
$ cat reg_pass.json
{
  "id": "docker_registry",
  "mex_docker_username": "*******",
  "mex_docker_password": "*******"
}
$ knife data bag from file mexsecrets reg_pass.json

$ knife data bag create mex_releases
```

## ElasticSearch

* Set up an Elastic Cloud account: https://cloud.elastic.co/
* Create a [deployment](https://www.elastic.co/guide/en/cloud/current/ec-create-deployment.html)
  * Recommended config:
    * 2 zones, GCP.DATA.HIGHIO.1 with 16 GB of RAM each
    * Single Kibana instance (1 GB of RAM)
* Create a role for Jaeger and Events
```
    {
      "jaeger" : {
        "cluster" : [
          "manage",
          "monitor"
        ],
        "indices" : [
          {
            "names" : [
              "jaeger-*",
              "*-jaeger-*",
              "events-*"
            ],
            "privileges" : [
              "create",
              "create_index",
              "read",
              "write",
              "monitor",
              "delete_index"
            ],
            "field_security" : {
              "grant" : [
                "*"
              ],
              "except" : [ ]
            },
            "allow_restricted_indices" : false
          }
        ],
        "applications" : [ ],
        "run_as" : [ ],
        "metadata" : { },
        "transient_metadata" : {
          "enabled" : true
        }
      }
    }
```
* Create a user associated with the role
* Record username and password in vault in this path:
  * `secret/ansible/internal/accounts/elasticsearch/${SETUPNAME?}`
```shell
$ vault kv get secret/ansible/internal/accounts/elasticsearch/main
======== Data ========
Key             Value
---             -----
url             https://abcdef1234567890abcdef1234567890.us-central1.gcp.cloud.es.io:9243
user            jaeger
pass            XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx
```

### Events Log Account

Follow the instructions here to set up the `esproxy` events log account:
* https://github.com/mobiledgex/edge-cloud-infra/blob/0fdad2a224/ansible/roles/esproxy/README.md

## Postgres

MC needs access to a postgres database. It does not matter where the database
is hosted, but it is simplest to host the database within the same cloud
provider that MC/console are running on to take advantage of secure access
within the VPC network.

We use a Google Cloud SQL postgres database instance with 1 vCPU, 3.75 GB of RAM, and 10 GB of SSD storage.

* Create a database (`mcdb`), and a user with full access to that database (`mcuser`)
* Record the credentials of the user in vault: `secret/ansible/${SETUPNAME?}/accounts/mc`
```shell
$ vault kv get secret/ansible/main/accounts/mc
======= Data =======
Key            Value
---            -----
db             mcdb
db_username    mcuser
db_password    XXXXXXXXXXXXXXXXXX
```
