---
title: mcctl Installation and Setup Guide
long_title:
overview_description:
description: Learn how to download and install the mcctl utility, manage users and organizations, and review mcctl commands
---

## What is `mcctl` Utility?

The `mcctl` utility is designed to provide access to the MobiledgeX APIs from the command line. This is a MobiledgeX supported utility and can be downloaded from Artifactory. Binaries for both MacOS and Linux x86_64 are available.

## Download the `mcctl` Utility:


- Go to [artifactory.mobiledgex.net](https://artifactory.mobiledgex.net/). Log in to Artifactory using the same credentials used to log into the [Edge-Cloud Console](https://console.mobiledgex.net/).
- On the left navigation, select **Artifacts**. Then, in the folder directory, select **downloads &gt; mcctl &gt; **(preferred operating system)** &gt; mcctl**.


![](/assets/artifactory.png "")


- Download the mcctl file.


Once downloaded, you will need to add execute permission to the file in order to execute it. This can be done by using the terminal to run `chmod 755 ./mcctl`.

Users of MacOS Catalina will need to take an additional step to authorize the application with [Gatekeeper](https://en.wikipedia.org/wiki/Gatekeeper_(macOS)). This involves the following steps:

- Open finder in the directory (folder) where you have downloaded the `mcctl` program. This can be done by running `open .` in the terminal.
- Launch the app you’re trying to run and acknowledge the Gatekeeper warning that prevents the app from running.
- Open **System Preferences**, then select ** Security and Privacy &gt; General**, and look for a note at the bottom of the screen about an app launch being denied.
- Click **Open Anyway** to bypass Gatekeeper and launch the app.


## Overview of `mcctl`

### Command help

Running `mmctl` with either the `-h` flag or no arguments will cause it to print the usage information. Additionally, the help information will display when invalid commands or arguments are specified (this behavior can be changed by supplying the `--silence-usage` flag to `mcctl`).

```
$mcctl
Usage: mcctl [command]

User and Organization Commands
  login                   Login using account credentials
  user                    Manage your account or other users
  role                    Manage user roles and permissions
  org                     Manage organizations
  billingorg              Manage billing organizations

Operator Commands
  cloudlet                Manage Cloudlets
  cloudletpool            Manage CloudletPools
  cloudletpoolinvitation  Manage CloudletPool invitations
  cloudletinfo            Manage CloudletInfos
  trustpolicy             Manage TrustPolicys
  restagtable             Manage ResTagTables
  operatorcode            Manage OperatorCodes
  cloudletrefs            Manage CloudletRefs
  vmpool                  Manage VMPools
  reporter                Manage report schedule
  gpudriver               Manage GPUDrivers
  report                  Manage reports

Developer Commands
  cloudletshow            View cloudlets
  cloudletpoolresponse    Manage CloudletPool responses to invitations
  app                     Manage Apps
  clusterinst             Manage ClusterInsts
  appinst                 Manage AppInsts
  autoscalepolicy         Manage AutoScalePolicys
  autoprovpolicy          Manage AutoProvPolicys
  appinstclient           Manage AppInstClients
  appinstrefs             Manage AppInstRefs
  appinstlatency          Manage AppInstLatencys
  runcommand              Run a Command or Shell on a container
  runconsole              Run console on a VM
  showlogs                View logs for AppInst

Logs and Metrics Commands
  metrics                 View metrics
  billingevents           View billing events
  events                  Search events and audit events
  usage                   View App, Cluster, etc usage
  alertreceiver           Manage alert receivers
  useralert               Manage UserAlerts

Other Commands
  version                 Version of mcctl cli utility

Flags:
      --addr string            MC address (default "http://127.0.0.1:9900")
      --data string            json formatted input data, alternative to name=val args list
      --datafile string        file containing json/yaml formatted input data, alternative to name=val args list
      --debug                  debug
  -h, --help                   help for mcctl
      --output-format string   output format: yaml, json, or json-compact (default "yaml")
      --output-stream          stream output incrementally if supported by command (default true)
      --parsable               generate parsable output
      --silence-usage          silence-usage
      --skipverify             don’t verify cert for TLS connections
      --token string           JWT token

```

Additionally, using the keyword `help` along with the command you wish to view help information will provide additional data. For example, to get help on the `audit` command option, you can simply run:

```
$ mcctl help audit
Show audit logs

Usage: mcctl audit [flags] [command]

Available Commands:
  showself
  showorg
  operations

Flags:
  -h, --help   help for audit

Global Flags:
      --addr string            MC address (default "http://127.0.0.1:9900")
      --data string            json formatted input data, alternative to name=val args list
      --datafile string        file containing json/yaml formatted input data, alternative to name=val args list
      --debug                  debug
      --output-format string   output format: yaml, json, or json-compact (default "yaml")
      --output-stream          stream output incrementally if supported by command (default true)
      --parsable               generate parsable output
      --silence-usage          silence-usage
      --skipverify             don’t verify cert for TLS connections
      --token string           JWT token

Use "mcctl audit [command] --help" for more information about a command.

```

### Output formats

The `mcctl` utility will produce output in three different formats:

- [YAML](https://en.wikipedia.org/wiki/YAML)
- [JSON](https://en.wikipedia.org/wiki/JSON) Data with added whitespace for readability.
- [JSON-compact](https://en.wikipedia.org/wiki/JSON) Data without extra whitespace.

## Using `mcctl`

### Logging in

In order to use `mcctl`, you must first log into the API to retrieve an authorization token. Make sure you check the directory for where you downloaded your `mcctl` executable. Follow this example in your terminal.

```
/Users/username/Downloads/mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) login name=username
password:
login successful
token saved to /home/username/.mctoken
```

**Note:** Distinguish between your usernames. The directory will require your OS username, while the subsequent login and password will use your account info for accessing the **Edge-Cloud Console** (which should have been the same login you used to access Artifactory).

### Permissions error

Commands for which you do not have permission to run will be rejected with a **403** return code from the API.

```
$ mcctl config  --addr  [https://console.mobiledgex.net](https://console.mobiledgex.net)   show
Error: Forbidden (403), Forbidden
Usage: mcctl config show [flags] [args]
Required Args:
Optional Args:
Flags:
  -h, --help   help for show

Global Flags:
      --addr string            MC address (default "http://127.0.0.1:9900")
      --data string            json formatted input data, alternative to name=val args list
      --datafile string        file containing json/yaml formatted input data, alternative to name=val args list
      --debug                  debug
      --output-format string   output format: yaml, json, or json-compact (default "yaml")
      --output-stream          stream output incrementally if supported by command (default true)
      --parsable               generate parsable output
      --silence-usage          silence-usage
      --skipverify             don’t verify cert for TLS connections
      --token string           JWT token

```

## Specify Array Values to mcctl

A number of inputs to the `mcctl` utility are passed as arrays of multiple values. These inputs will be shown in the format of `somearray:#.somevalue` in the help output.

There are two ways to specify array inputs, as described below.

### Using a file

Create a yaml file with all the fields and values required by the command. You can view the required information by using `mcctl` with the command and (if needed) subcommand without any additional arguments. For example, to list the required and options arguments for the `app create` command, run `mcctl app create`.

The sample below shows a YAML file that defines two configurations to the MobiledgeX platform as part of creating an application.

#### Sample YAML file

```
region: EU
app:
  key:
    name: deleteme
    organization: testmonitor
    version: ’1.0’
  image_path: docker.mobiledgex.net/testmonitor/images/myfirst-app:v1
  image_type: 1
  configs:
  - config: "&lt;yaml-content0&gt;"
    kind: helmCustomizationYaml
  - config: "&lt;yaml-content1&gt;"
    kind: helmCustomizationYaml

```

Once the YAML file is created, it can be passed to the `mcctl` utility using the `--datafile` command line option:

`mcctl app create region --datafile &lt;above-filename.yml&gt;`

### Using the CLI

It is also possible to pass this information on the command line. This requires that you replace the `#` shown in the help text with a value that corresponds to the number of an element in the array. Note that the array is zero-based.

#### Sample CLI

This command passes the same information as the yaml file above.

```
$ mcctl app create region=EU appname=testapp appvers=1.0 app-org=testmonitor imagetype=ImageTypeHelm configs:0.kind=helmCustomizationYaml configs:0.config="&lt;yamlcontent0&gt;" configs:1.kind=helmCustomizationYaml configs:1.config="&lt;yamlcontent1&gt;"

```

## Account Management

The `mcctl` utility can be used to create, update, and delete account level information with the MobiledgeX environment for users with appropriate permissions.

### User management

`$ mcctl --addr https://console.mobiledgex.net user`

The following user operations are available with the `mcctl` user command:

```
Available Commands:
  create                Create a new user
  delete                Delete an existing user
  update                Update a user
  show                  Show users
  current               Show the currently logged in user
  newpass               Set a new password, requires the existing password
  resendverify          Request that the user verification email be resent
  verifyemail           Verify a user’s email account from the token in the email
  passwordresetrequest  Request a password reset email to be sent to the user’s email
  passwordreset         Reset the password using the token from the password reset email
  createuserapikey      Create an API key for reduced access, typically for automation
  deleteuserapikey      Delete an API key
  showuserapikey        Show existing API keys

```

### Role management

`$ mcctl --addr https://console.mobiledgex.net role`

The following user operations are available with the mcctl role command:

- `names`
- `add`
- `remove`
- `show`
- `assignment`
- `perms`

### Organization management

`$ mcctl --addr https://console.mobiledgex.net org`

The following user operations are available with the `mcctl` org command:

- `create`
- `update`
- `delete`
- `show`

## Two Factor Authentication

```
$ mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) user create name=new2famcctluser email=john.doe+new2famcctluser@mobiledgex.com enabletotp=true
password:
verify password:
User created with two factor authentication enabled. Please use the following text code with the two factor authentication app on your phone to set it up
7XYK3DYXGMF6SNE6ANSHXE7QHCSU44LW
```

Copy the key and put it in your authenticator. MobiledgeX must unlock your user account and verify the account email before proceeding. The user must use the totp option to log in. Get the one time password from the authenticator to use for the totp.

```
$ mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) login name=new2famcctluser totp=499265
password: xxxxxxxxxxxxx
login successful
token saved to /Users/john.doe/.mctoken
```

The user can turn the one time password feature on or off from their account by logging in and then doing a user update.

```
$ mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) user update enabletotp=false
user updated
$ mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) login name=new2famcctluser password=H31m8@W8maSfg
login successful
token saved to /Users/john.doe/.mctoken
$ mcctl --addr [https://console.mobiledgex.net](https://console.mobiledgex.net) user update enabletotp=true
User updated
Enabled two factor authentication. Please use the following text code with the two factor authentication app on your phone to set it up
6XPOCFIK2UURY5ZQA7YZALZENUZYVXSR
```

