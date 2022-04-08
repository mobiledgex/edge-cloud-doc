---
title: Regional Commands
long_title:
overview_description:
description: Regional commands using the mcctl utility
---

## Regional Commands

The `region` subcommand provides access to the most commonly used commands for managing a deployment.

### Flavor management

- `flavor create`
- `flavor delete`
- `flavor update`
- `flavor show`
- `flavor addres`
- `flavor removeres`
- `cloudlet findflavormatch`

### Operator codes

- `operatorcode create`
- `operatorcode delete`
- `operatorcode show`

### Cloudlet management

- `cloudlet create`
- `cloudlet delete`
- `cloudlet update`
- `cloudlet show`
- `cloudlet addresmapping`
- `cloudlet removeresmapping`

### Cloudlet pools (Private Edge)

- `cloudletpool create`
- `cloudletpool delete`
- `cloudletpool show`
- `cloudletinfo show`
- `cloudletpool addmember`
- `cloudletpool removemember`
- `cloudletpoolinvitation showgranted`

### Cluster management

- `clusterinst create`
- `clusterinst delete`
- `clusterinst update`
- `clusterinst show`

### Application management

- `app create`
- `app delete`
- `app update`
- `app show`
- `app addautoprovpolicy`
- `app removeautoprovpolicy`

### Application instance management

- `appinst create`
- `appinst delete`
- `appinst refresh`
- `appinst update`
- `appinst show`
- `node show` (Admin-Only)
- `alert show` (Admin-Only)

### Policy management

- `autoscalepolicy create`
- `autoscalepolicy update`
- `autoscalepolicy show`
- `autoprovpolicy create`
- `autoprovpolicy delete`
- `autoprovpolicy update`
- `autoprovpolicy show`
- `autoprovpolicy addcloudlet`
- `autoprovpolicy removecloudlet`
- `trustpolicy create`
- `trustpolicy delete`
- `trustpolicy update`
- `trustpolicy showself`

### Regional settings

- `settings update` (Admin-Only)
- `settings reset` (Admin-Only)
- `settings show` (Admin-Only)

### Resource tagging

- `restagtable create`
- `restagtable delete`
- `restagtable update`
- `restagtable show`
- `restagtable addrestag`
- `restagtable removerestag`
- `restagtable get`

### Debugging

- `debug enabledebuglevels` (Admin-Only)
- `debug disabledebuglevels` (Admin-Only)
- `debug showdebuglevels` (Admin-Only)
- `debug rundebug` (Admin-Only)

### Device management

- `appinstclient showappinstclient`
- `device inject` (Admin-Only)
- `device show` (Admin-Only)
- `device evict` (Admin-Only)
- `device showreport` (Admin-Only)

### Misc commands

- `RunCommand`
- `showlogs`
- `runconsole`
- `accesscloudlet` (Admin-Only)

