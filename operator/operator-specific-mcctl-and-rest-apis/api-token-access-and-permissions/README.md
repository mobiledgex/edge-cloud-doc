---
title: API Key Access and Permissions
long_title:
overview_description:
description: Provides steps on how to set up API token access and permissions
---

## API Key Access

Operators typically access the API using an API token that is generated for their accounts. This token will give the user all the permissions their roles allow them to have. However, there may be circumstances where a token is required that has limited permissions to enable other users/processes to perform specific actions, such as limited use of the CLI, automation in scripts, etc. For example, creating an operator API Key Access will not automatically give you view access to cluster instances or app instances in a cloudlet pool unless you specifically grant view permissions to the cloudlet pool. Once permission to the cloudlet pool is granted, access is given to the `clusterinst show` and `appinst show` `mcctl` commands.

To facilitate this, an API Key can be generated with a specific set of permissions that can then be used to login to the API and generate an appropriate, time limited, API token. This type of token will expire after four hours.

### Generating a limited access API token

A user can create a limited access API token using `mcctl user createuserapikey`. This command requires an organization and at least one set of permissions specified as a Resource and Action, as shown in this example. These commands must be run by an admin on behalf of the user as it requires a pre-existing token in order to run successfully.

```
mcctl  user createuserapikey org=opdemoorg  description="Test api key" permissions:0.action=view permissions:0.resource=cloudletpools
userapikey:
id: 66b4f0d6-9711-4700-b8a9-d41fd059451b
apikey: de982b1c-09c7-4d73-89a4-0d73d403e7e8
```

The API Key is then used with `mcctl login` to generate a token for further API or `mcctl` calls.

```
mcctl  login apikeyid=66b4f0d6-9711-4700-b8a9-d41fd059451b apikey=de982b1c-09c7-4d73-89a4-0d73d403e7e8
login successful
token saved to /Users/leon.adams/.mctoken
```

As mentioned earlier, once view permissions to cloudlet pools are granted, you can view cluster/app instances within the cloudlet pool with an API key. In these preceding examples, the `cloudletpool show`, `clusterinst show` and `appinst show` commands are displayed.

```
mcctl  cloudletpool show region=US

key:
organization: opdemoorg
name: TestMonitor
cloudlets:

testcloudlet
createdat:
seconds: 1626127993
nanos: 319176148

```

```
mcctl  clusterinst show region=US

key:
clusterkey:
name: dockershared
cloudletkey:
organization: opdemoorg
name: testcloudlet
organization: testmonitor
flavor:
name: automation_api_flavor
liveness: Static
state: Ready
ipaccess: Shared
nodeflavor: m1.medium
deployment: docker
resources:
vms:

name: mex-docker-vm-testcloudlet-dockershared-testmonitor
type: cluster-docker-node
status: ACTIVE
infraflavor: m1.medium
ipaddresses:

internalip: 10.101.0.101
createdat:
seconds: 1624486289
nanos: 490275282

```

```
mcctl  appinst show region=US

key:
appkey:
organization: testmonitor
name: app-us
version: v1
clusterinstkey:
clusterkey:
name: dockershared
cloudletkey:
organization: opdemoorg
name: testcloudlet
organization: testmonitor
cloudletloc:
latitude: 32.8205865
longitude: -96.8716264
uri: testcloudlet.opdemoorg.mobiledgex.net
liveness: Static
mappedports:

proto: Tcp
internalport: 8080
publicport: 8080
flavor:
name: automation_api_flavor
state: Ready
runtimeinfo:
containerids:

app-usv1
createdat:
seconds: 1625761987
nanos: 800656855
revision: 2020-09-04T172613
healthcheck: Ok
powerstate: PowerOn
vmflavor: m1.medium
```

```
mcctl  app show region=US
Error: Forbidden (403), Forbidden

```

An API Key can be associated with multiple permission by adding additional resource/action pairs to the `createuserapikey` command and incrementing the index values, e.g.:

```
mcctl user createuserapikey org=packet  description="Test api key" permissions:0.action=view permissions:0.resource=cloudlets permissions:1.action=view permissions:1.resource=cloudletpools
```

### API permissions

The permissions specified in the command may give access to multiple related operations, e.g. the `manage` action typically grants create, delete and update permissions. The table below shows the list of permissions that are available and the associated operations they enable.

**Note: This is the complete set of permissions. The actual permissions that a user can grant via an API Key will only ever be a subset of the permissions that their user is allowed. For example operator or developer, users cannot give other users the **
`users`
** permissions.**

<table>
<tbody>
<tr>
<th>Resource</th>
<th>Action</th>
<th>Permitted Operations</th>
</tr>
<tr>
<td>alert</td>
<td>manage</td>
<td>CreateAlert</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>DeleteAlert</td>
</tr>
<tr>
<td>alert</td>
<td>view</td>
<td>ShowAlert</td>
</tr>
<tr>
<td>cloudlets</td>
<td>manage</td>
<td>CreateCloudlet</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>DeleteCloudlet</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>UpdateCloudlet</td>
</tr>
<tr>
<td>cloudlets</td>
<td>view</td>
<td>ShowCloudlet</td>
</tr>
<tr>
<td>cloudletpools</td>
<td>manage </td>
<td>CreateCloudletPool</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>DeleteCloudletPool</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>UpdateCloudletPool</td>
</tr>
<tr>
<td>cloudletpools</td>
<td>view</td>
<td>ShowCloudletPool</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>ShowClusterinst</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>ShowAppinst</td>
</tr>
<tr>
<td>cloudletanalytics </td>
<td>view</td>
<td>ShowCloudlet</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>MetricsCloudlet</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>MetricsCloudletusage</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>MetricsClientCloudletusage</td>
</tr>
<tr>
<td>restagtbl</td>
<td>manage</td>
<td>CreateTagTable</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>DeleteTagTable</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>UpdateTageTable</td>
</tr>
<tr>
<td>restagtbl</td>
<td>view</td>
<td>ShowTagTable</td>
</tr>
<tr>
<td>users</td>
<td>manage</td>
<td>CreateUser</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>DeleteUser</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>Updateuser</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>AddUser</td>
</tr>
<tr>
<td>users</td>
<td>show</td>
<td>ShowUser</td>
</tr>
<tr>
<td>

<br>
<br>
</td>
<td>

<br>
<br>
</td>
<td>ShowUserRole</td>
</tr>
</tbody>
</table>

