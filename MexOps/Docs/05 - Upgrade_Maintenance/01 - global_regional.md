# Global and Regional Upgrades

Global and regional services are upgraded in sync, and they are both managed
using Ansible. Builds are identified by the datestamps of the nightly builds
(`2022-02-02`).

There are a bunch of images built for each nightly build. The main image is
`edge-cloud`: `harbor.mobiledgex.net/mobiledgex-dev/edge-cloud:<datestamp>`. In
addition, there are component-specific images built for individual services:

  * edge-cloud-alertmgr-sidecar
  * edge-cloud-autoprov
  * edge-cloud-cluster-svc
  * edge-cloud-controller
  * edge-cloud-crm
  * edge-cloud-dme
  * edge-cloud-edgeturn
  * edge-cloud-frm
  * edge-cloud-mc
  * edge-cloud-notifyroot

In addition, every nightly also builds an Ansible deploy image for the same
datestamp.  This deploy image is the simplest way to deploy/upgrade the global
and regional services.

Pick the deploy image with the same tag as the build you are deploying. For
instance, if you are deploying build 2022-03-24, pick the following deployment
image: harbor.mobiledgex.net/mobiledgex/deploy:2022-03-24

```
$ docker run --rm -it harbor.mobiledgex.net/mobiledgex/deploy:${BUILD?} -h
```

NOTE: The deployment will prompt for Github credentials which will be used to
      log in to vault and also to look up console releases, if required. If you
      don’t have one already, generate a personal access token with at least
      repo scope.

### Common Commandline Switches

| Switch | Explanation | Example |
| ------ | ----------- | ------- |
| `-V <build>` | Edge-cloud build tag to deploy | `-V 2022-03-23` |
| `-C <build>` | Console build tag to deploy | `-C v3.0.16.6` |
| `-s <tag>,<tag>..` | Skip components during deploy. For instance, to skip the vault setup stage during the install, use `-s vault-setup` | `-s setup,vault-setup` |

### Common Upgrade Scenarios

#### Deploy the full staging setup

```
docker run --rm -it harbor.mobiledgex.net/mobiledgex/deploy:${BUILD?} -V ${BUILD?} staging
```

#### Deploy just the console to the development setup

Normally, MC and console get deployed together. To deploy just the console, use
the `-s mc switch` to skip MC deployment. Additionally, console does not
interact with vault directly and so, vault setup can also be skipped in most
cases.

```
docker run --rm -it harbor.mobiledgex.net/mobiledgex/deploy:${BUILD?} -C ${CONSOLE_BUILD?} \
  -s vault-setup,mc development console
```

#### Quick deployment of just the console in the staging setup

Use the `-s setup` switch to skip the setup steps and just update the console.
Only do this for minor upgrades where you are sure there is no other change in
the deployment infrastructure (nginx config, etc.) and it is just the console
that is being updated.

```
docker run --rm -it harbor.mobiledgex.net/mobiledgex/deploy:${BUILD?} -C ${CONSOLE_BUILD?} \
  -s setup,vault-setup,mc staging console
```

#### Adding a new region

Add the region details to `group_vars/platform.yml` in the inventory for the
environment where the region needs to be added.  (Eg:
staging/group_vars/platform.yml).  In pretty much every case, the entry would
contain just the parameters "name", "location", and "region".  For example:

```
  - name: mexplat-stage-eu
    location: westeurope
    region: EU
```

Once the region details are in `group_vars/platform.yml`, run the `region-setup.yml` playbook:
```
$ cd edge-cloud-infra/ansible
$ ./deploy.sh -p region-setup.yml -n staging   ### Dry-run in staging
$ ./deploy.sh -p region-setup.yml staging      ### Add new region in staging
```

#### Upgrade Artifactory

```
$ cd edge-cloud-infra/ansible
$ vi artifactory.yml
### Update "artifactory_version" ###

$ ./deploy.sh -p artifactory.yml main
```

