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
<table>
<tbody>
<tr>
<th>Resource</th>
<th>Action</th>
<th>Permitted Operations</th>
</tr>
<tr>
<td>alert</td>
<td>view</td>
<td>ShowAlert</td>
</tr>
<tr>
<td>appanalytics</td>
<td>view</td>
<td>ShowAppinstclient</td>
</tr>
<tr>
<td>appinsts</td>
<td>manage</td>
<td>ShowDevicereport</td>
</tr>
<tr>
<td></td>
<td></td>
<td>CreateAppinst</td>
</tr>
<tr>
<td></td>
<td></td>
<td>DeleteAppinst</td>
</tr>
<tr>
<td></td>
<td></td>
<td>RefreshAppinst</td>
</tr>
<tr>
<td></td>
<td></td>
<td>RequestAppinstlatency</td>
</tr>
<tr>
<td></td>
<td></td>
<td>UpdateAppinst</td>
</tr>
<tr>
<td>appinsts</td>
<td>view</td>
<td>ShowDevicereport</td>
</tr>
<tr>
<td></td>
<td></td>
<td>StreamAppinst</td>
</tr>
<tr>
<td></td>
<td></td>
<td>ShowAppinst</td>
</tr>
<tr>
<td></td>
<td></td>
<td>ShowOperatorcode</td>
</tr>
<tr>
<td>apps</td>
<td>manage</td>
<td>AddAppautoprovpolicy</td>
</tr>
<tr>
<td></td>
<td></td>
<td>RemoveAppautoprovpolicy</td>
</tr>
<tr>
<td></td>
<td></td>
<td>CreateApp</td>
</tr>
<tr>
<td></td>
<td></td>
<td>DeleteApp</td>
</tr>
<tr>
<td></td>
<td></td>
<td>UpdateApp</td>
</tr>
<tr>
<td>apps</td>
<td>view</td>
<td>ShowApp</td>
</tr>
<tr>
<td>cloudlets</td>
<td>view</td>
<td>ShowCloudlet</td>
</tr>
<tr>
<td></td>
<td></td>
<td>FindmappingCloudlet</td>
</tr>
<tr>
<td></td>
<td></td>
<td>GetCloudletResourceUsage</td>
</tr>
<tr>
<td></td>
<td></td>
<td>ShowOperatorcode</td>
</tr>
<tr>
<td></td>
<td></td>
<td>ShowTrustpolicy</td>
</tr>
<tr>
<td></td>
<td></td>
<td>ShowOperatorcode</td>
</tr>
<tr>
<td></td>
<td></td>
<td>StreamCloudlet</td>
</tr>
<tr>
<td>clusterinsts</td>
<td>manage</td>
<td>DeleteIdlereservableclusterinsts</td>
</tr>
<tr>
<td></td>
<td></td>
<td>CreateClusterinst</td>
</tr>
<tr>
<td></td>
<td></td>
<td>DeleteClusterinst</td>
</tr>
<tr>
<td></td>
<td></td>
<td>UpdateClusterinst</td>
</tr>
<tr>
<td>clusterinsts</td>
<td>view</td>
<td>ShowOperatorcode</td>
</tr>
<tr>
<td></td>
<td></td>
<td>ShowClusterinst</td>
</tr>
<tr>
<td></td>
<td></td>
<td>StreamClusterinst</td>
</tr>
<tr>
<td>developerpolicy</td>
<td>manage</td>
<td>AddAutoprovpolicycloudlet</td>
</tr>
<tr>
<td></td>
<td></td>
<td>CreateAutoprovpolicy</td>
</tr>
<tr>
<td></td>
<td></td>
<td>CreateAutoscalepolicy</td>
</tr>
<tr>
<td></td>
<td></td>
<td>DeleteAutoprovpolicy</td>
</tr>
<tr>
<td></td>
<td></td>
<td>DeleteAutoscalepolicy</td>
</tr>
<tr>
<td></td>
<td></td>
<td>RmAutoprovpolicycloudlet</td>
</tr>
<tr>
<td></td>
<td></td>
<td>UpdateAutoprovpolicy</td>
</tr>
<tr>
<td></td>
<td></td>
<td>UpdateAutoscalepolicy</td>
</tr>
<tr>
<td>developerpolicy</td>
<td>view</td>
<td>ShowAutoprovpolicy</td>
</tr>
<tr>
<td></td>
<td></td>
<td>ShowAutoscalepolicy</td>
</tr>
<tr>
<td>flavors</td>
<td>view</td>
<td>ShowFlavor</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td>users</td>
<td>manage</td>
<td>AddUser</td>
</tr>
<tr>
<td></td>
<td></td>
<td>CreateUser</td>
</tr>
<tr>
<td></td>
<td></td>
<td>DeleteUser</td>
</tr>
<tr>
<td></td>
<td></td>
<td>Updateuser</td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td>users</td>
<td>show</td>
<td>ShowUser</td>
</tr>
<tr>
<td></td>
<td></td>
<td>ShowUserRole</td>
</tr>
</tbody>
</table>

