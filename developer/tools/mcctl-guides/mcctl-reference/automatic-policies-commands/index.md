---
title: Automatic Policies Commands
long_title: 
overview_description: 
description: 
Learn about policy management commands with mcctl utility

---

## Auto Provision Policy Management

Auto-provision policies allow you to manage the deployment of application instances to more efficient cloudlets, improving service and latency.

```
mcctl --addr https://console.mobiledgex.net autoprovpolicy
Error: Please specify a command
Usage: mcctl autoprovpolicy [flags] [command]

Available Commands:
  create          Create an Auto Provisioning Policy
  delete          Delete an Auto Provisioning Policy
  update          Update an Auto Provisioning Policy
  show            Show Auto Provisioning Policies. Any fields specified will be used to filter results.
  addcloudlet     Add a Cloudlet to the Auto Provisioning Policy
  removecloudlet  Remove a Cloudlet from the Auto Provisioning Policy

Flags:
  -h, --help   help for autoprovpolicy

```

## Auto Scale Policies

Auto-scale policies allow you to increase or decrease the computing resources for an application based on its needs.  

```
mcctl --addr https://console.mobiledgex.net autoscalepolicy
Error: Please specify a command
Usage: mcctl autoscalepolicy [flags] [command]

Available Commands:
 create   Create an Auto Scale Policy
 delete   Delete an Auto Scale Policy
 update   Update an Auto Scale Policy
 show     Show Auto Scale Policies. Any fields specified will be used to filter results.

Flags:
 -h, --help  help for autoscalepolicy

```

