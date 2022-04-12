# System Networking

The networking config for the infrastructure is also managed by Terraform/Ansible as part of the installation. The general rules are that these:
- Components need to be communicate to each other over the notify channel
- MC's LDAP interface needs to be accessible to Artifactory and Gitlab
- PostgreSQL needs to be accessible from MC
- HTTPS ports needs to be open on the console and Gitlab

The following is for reference:

### Alertmanager

Alertmanager needs the following ports open:
- 9094/tcp

### Console & MC

Console needs the standard HTTPS port open:
- 443/tcp

MC's LDAP server needs to be accessible on port 9389/tcp from the Artifactory instance as well as the Gitlab instance.
- 9389/tcp (only from Artifactory and Gitlab)

MC's Notify server needs to be accesible:
- 52001/tcp

## Controller

Ports:
- 36001/tcp
- 37001/tcp
- 41001/tcp
- 55001/tcp

## DME

Ports:
- 38001/tcp
- 50051/tcp

## EdgeTurn

Ports:
- 443/tcp
- 6080/tcp

## InfluxDB

Ports:
- 8086/tcp (from region controller for that region and MC)

### Notifyroot

Ports:
- 53001/tcp

### Postgres

Ports:
- 5432/tcp (from MC)

### Vault Instances

Vault instances need the following ports open for vault API and cluster communication.
- 8200/tcp
- 8201/tcp
