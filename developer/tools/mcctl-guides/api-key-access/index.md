---
title: API Key Access and Permissions
long_title:
overview_description:
description:
Provides steps on how to set up API token and permissions.

---

**Last Modified:** 6/8/2021

## API Key Access

Developers typically access the API using an API token that is generated for their accounts. This token gives the user all the permissions their roles allow them to have. However there may be circumstances where a token is required that has limited permissions to enable other users/processes to perform specific actions, such as limited use of the CLI, automation in scripts, etc.

To facilitate this, an API Key can be generated with a specific set of permissions and then used to login to the API and generate an appropriate, time-limited, API token. This type of token will expire after 4 hours.

### Generating a Limited Access API token

A User can create a limited access API token using `mcctl user createuserapikey`. This command requires an organization and at least one set of permissions specified as a Resource and Action, as shown in this example.

```

# mcctl user createuserapikey org=demoorg description="test" permissions:0.action=view permissions:0.resource=apps

userapikey:
  id: e9028a99-xxxx-xxxx-xxxx-56e32275fb8f

apikey: af2705c7-xxxx-xxxx-xxxx-7e0e377ac5a7

```

The API Key is then used with `mcctl login` to generate a token for further API or `mcctl` calls.

```

# mcctl login apikeyid=e9028a99-xxxx-xxxx-xxxx-56e32275fb8f apikey=af2705c7-xxxx-xxxx-xxxx-7e0e377ac5a7

login successful
token saved to /Users/peterg/.mctoken

```

In this example, the permissions given were for View Apps. This only gives the permissions to use `mcctl app show` and the API end point `/auth/ctrl/ShowApp`. Any attempt to use other `mmctl` commands or API end points will not be allowed.

```

# mcctl app show region=EU

- key:
    organization: demoorg
    name: hello-k8
    version: "1.0"
  imagetype: ImageTypeDocker
  accessports: tcp:8888
  defaultflavor:
    name: m4.small

-- snip --
]

# mcctl appinst show region=EU

Error: Forbidden (403), Forbidden

```

An API Key can be associated with multiple permission by adding additional resource/action pairs to the `createapikey` command and incrementing the index values, e.g

```
mcctl user createuserapikey org=packet  description="Test api key" permissions:0.action=view permissions:0.resource=cloudlets permissions:1.action=view permissions:1.resource=cloudletpools
```

### API Permissions

The permissions specified in the command may give access to multiple related operations, for example, the `manage` action typically grants create, delete and update permissions. The table below shows the list of permissions that are available and the associated operations they enable.

**NOTE:** This is the complete set of permissions. The actual permissions that a user can grant via an API Key will only be a subset of the permissions that their user is allowed. For example, Developer users cannot give other users the `users` permissions.

| Resource                 | Action | Permitted Operations             |
|--------------------------|--------|----------------------------------|
| alert                    | view   | ShowAlert                        |
| appanalytics             | view   | ShowAppinstclient                |
| appinsts                 | manage | ShowDevicereport                 |
| CreateAppinst            |
| DeleteAppinst            |
| RefreshAppinst           |
| RequestAppinstlatency    |
| UpdateAppinst            |
| appinsts                 | view   | ShowDevicereport                 |
| StreamAppinst            |
| ShowAppinst              |
| ShowOperatorcode         |
| apps                     | manage | AddAppautoprovpolicy             |
| RemoveAppautoprovpolicy  |
| CreateApp                |
| DeleteApp                |
| UpdateApp                |
| apps                     | view   | ShowApp                          |
| cloudlets                | view   | ShowCloudlet                     |
| FindmappingCloudlet      |
| GetCloudletResourceUsage |
| ShowOperatorcode         |
| ShowTrustpolicy          |
| ShowOperatorcode         |
| StreamCloudlet           |
| clusterinsts             | manage | DeleteIdlereservableclusterinsts |
| CreateClusterinst        |
| DeleteClusterinst        |
| UpdateClusterinst        |
| clusterinsts             | view   | ShowOperatorcode                 |
| ShowClusterinst          |
| StreamClusterinst        |
| developerpolicy          | manage | AddAutoprovpolicycloudlet        |
| CreateAutoprovpolicy     |
| CreateAutoscalepolicy    |
| DeleteAutoprovpolicy     |
| DeleteAutoscalepolicy    |
| RmAutoprovpolicycloudlet |
| UpdateAutoprovpolicy     |
| UpdateAutoscalepolicy    |
| developerpolicy          | view   | ShowAutoprovpolicy               |
| ShowAutoscalepolicy      |
| flavors                  | view   | ShowFlavor                       |
 |
| users                    | manage | AddUser                          |
| CreateUser               |
| DeleteUser               |
| Updateuser               |
 |
| users                    | show   | ShowUser                         |
| ShowUserRole             |
