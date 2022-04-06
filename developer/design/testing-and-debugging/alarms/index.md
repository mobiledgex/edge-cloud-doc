---
title: Alerts
long_title:
overview_description:
description:
View a list of the different alarm logs to help you take action to repair or maintain the MobiledgeX platform and its components

---

Alerts are generated when criteria that are defined by the user are met. Alerts enable you to monitor the performance and counteract irregularities within the system, helping you to proactively mitigate any performance or functional issues. A notification is sent either through Slack, PagerDuty, or email, depending on the preferred delivery method configured by the user. When the issue or condition is resolved, an additional notification is sent to the user indicating that the issue has been fixed.<br>Some alerts depend on health checks which can be enabled by the user on the MobiledgeX Console. See below for a list of examples.

## Supported Alerts

- Application port not responding
- Root LB is offline
- Alert Policy

For more information on the type of issues that can generate alerts, refer to the document on [Health Check](https://developers.mobiledgex.com/design/testing-and-debugging/health-check).

## Alert notifications

The alert framework sends out two types of notifications:

- **Firing:** The alert condition is currently manifesting.
- **Resolved:** The alert condition is no longer manifesting.

## Severity levels

Alert subscriptions can be filtered based on a severity level. Currently, you can select one of three severity levels.

- **Info:** Normal operational messages that require no action.
- **Warning:** May indicate that an error will occur if action is not taken.
- **Error:** Error conditions.

## AlertManager

The AlertManager is a global component of MobiledgeX’s product and is responsible for distributing alerts to application owners. Alarms are consolidated at the regional level, where each regional controller receives alarms via a notification.

The image below illustrates the AlertManager workflow. A user can create an alert receiver and set up their preferred notification method through the Edge-Cloud Console. Once an alert receiver is created, the receiver is pushed to the MobiledgeX Platform. When an alarm is triggered, the Alert Manager within the platform sends an alert notification to the user for mitigation. Currently, alert notifications are sent only for application instance(s) that are down-`AppInstDown`.

![Alert Manager Workflow](/assets/alertreceiver.png "Alert Manager Workflow")

### Alert management

The MobiledgeX platform provides a flexible alerting interface that includes the following:

- RBAC support for users, roles, and organizations that control access to alerts. Any user having the ability to view a resource [that generates an alert] can create or delete an alert receiver for the resource. However, since alerts are raised and cleared by the platform, users cannot create custom alerts.
- Flexibility to manage the delivery of alerts to different “alert receivers” based on user configuration. We currently support the delivery of alerts to your Slack or email account.

### Alert receiver types

Alerts may be generated from multiple components within the environment, such as app instances or clusters. For example, an alert notification will be sent if an application instance goes down or has anomalies due to the health check for a particular application.

There are several different alert receivers you can set up to receive a notification about your application instance. For example, if you want to receive a notification with a specific application instance, you can specify the `appname`, `app-org`, and `appvers`. You can also monitor all of the application instances associated with a particular application from all the cloudlets by, again, specifying the `appname`, `app-org`, `appvers`.

To receive notification about all the application instances that are running on a particular cluster, specify `cluster` and `cluster-org`.

Here’s an example of what an alert receiver setup may look like for an application instance:

```
name: DevOrgReceiver2
type: email
severity: errors
user: mexadmin
email: somebody@nowhere.net
appinst:
  appkey:
      organization: DevOrg
      name: DevOrg SDK Demo
      version: "1.0"
    clusterinstkey:
      clusterkey:
        name: AppCluster
      cloudletkey:
        organization: mexdev
        name: localtest
      organization: DevOrg

```

### Alert policy

**Note:** This feature is currently supported for Kubernetes apps only.

To help you further monitor your applications, you can set up Alert Policies and be notified or alerted based on these policies. When you set up an alert policy and associate it to your application, you can:

- create measurement rules
- create alert rules based on measurements
- show alert and measurement rules

**Note:** Rules are the thresholds that you specify for the measurements you wish to be alerted to.

Alert Policies include measurements such as CPU usage, Memory usage, Disk usage, and the number of active connections. You can combine your rules into a single UserAlert, such as `cpu &gt; 80% and memory &gt;50%`. However, you cannot combine the` number of active connections` rule with any other rules; it must be a single rule.

Once you have defined your Alert Policy, you attach the rule to an existing application. Once an Alert Policy is attached to the application, you will be notified if any of the application instances of this application violates the Alert Policy via the monitoring page. If you wish to receive an alert notification email,  ensure that an alert receiver is set up.

#### Labels and annotations

When you set up to generate an alert on the UI based on your alert policy, the title of your alert, by default, will be the name of your alert. However, if you specify ’Title’ in the Annotations section and provide an alert name, the existing default title of your alert name will be overwritten by the value you specified in your Annotation. With ’Description’, If you did not provide a description when you first created your alert policy, the description of the alert will be blank. However, the description will be pulled from the Annotation value if you provided a ’Description’ in your Annotation.

![Alert Policy Annotations](/assets/developer-ui-guide/annotation-1628783853.png "Alert Policy Annotations")

#### Set up an Alert Policy:</strong>


- From the left navigation, expand **Policies** and select **Alert Policy**.


![Alert Policy Create page](/assets/developer-ui-guide/alert-policy-create.png "Alert Policy Create page")


- Specify all the required fields, and click **Create Policy**. Your new Alert Policy will appear on the Alert Policy page.


![Alert Policy page](/assets/developer-ui-guide/alert-policy-page.png "Alert Policy page")


- From the left navigation, scroll down to **Apps**.

-If you’re creating a new application and wish to attach the alert policy to the new application, click the **+** sign, populate all required fields, and scroll down to the **Advanced Settings**.<br>-If you have an existing application and wish to attach an alert policy to the existing application, from the Actions menu, select **Update**.
- Scroll down to the Alert Policies field under Advanced Settings and select an Alert Policy from the drop-down list to attach the policy to your application.


![Alert Policies](/assets/developer-ui-guide/alert-policies.png "Alert Policies")


- Click **Create** or **Update,** depending on whether you’re adding a new application or updating an existing one.<br>Your application is now associated with the Alert Policy.
- If an application instance was created from the application and then you decide to add an alert policy or another alert policy to the application, you must perform an application instance update.


![Update Application Instance](/assets/-update-app.png "Update Application Instance")

## Alert Receiver and MobiledgeX APIs

Alert Receivers are designed to be configurable via the MobiledgeX APIs, directly and through the `mcctl` utility program, providing flexibility for users integrating with their existing monitoring systems.

| Action                   | API Route                          |
|--------------------------|------------------------------------|
| Create an Alert Receiver | `api/v1/auth/alertreceiver/create` |
| Delete an Alert Receiver | `api/v1/auth/alertreceiver/delete` |
| Show all Alert Receivers | `api/v1/auth/alertreceiver/show`   |

For detailed AlertReceiver API examples, please refer to the [MCCTL Reference Guide](https://dev-stage.mobiledgex.com/tools/mcctl-guides/mcctl-reference).

#### To set up alert receivers and notification methods through the console

While you can use the `mcctl` tool and the commands provided to set up your alerts and notification preferences, we recommend using the Edge-Cloud Console to set up your alert receivers for ease of use.

- Navigate to the Alert Receivers sub-menu and click the **+** plus sign. The Create Receiver screen opens.


![Create Alert Receiver screen](/assets/developer-ui-guide/create-alert-receiver-dev.png "Create Alert Receiver screen")


- Additional fields appear depending on your selections. Populate all the required fields.


![Additional Alert Receiver fields](/assets/developer-ui-guide/additional-alert-receiver.png "Additional Alert Receiver fields")


- Your new Alert Receiver will appear on the Alert Receivers page.


![Alert Receiver list](/assets/developer-ui-guide/alert-receiver-list.png "Alert Receiver list")


- When you click the Alert icon, information about the alert is displayed.


![Information about Alerts](/assets/developer-ui-guide/alert-descr1.png "Information about Alerts")

