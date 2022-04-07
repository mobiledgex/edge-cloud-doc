---
title: Application Definition
long_title:
overview_description:
description:
Define the application definition used to create application instances that can be deployed on MobiledgeX

---

**Last Modified:** 11/15/21

The Apps page lets you create application definitions for any applications deploying to our registry. Doing this creates an ’inventory’ of your applications that are part of the registry. Creating an application definition also prepares it for deployment. Refer to our [Tutorial: Deploying an application to the MobiledgeX platform](/developer/services/computer-vision/cv-deployment/index.md) for steps on how to deploy a sample application.

You can mark each application as **Trusted** if you wish to deploy and configure your outbound connections as prohibited. Upon deployment of your application, the security policy is applied and thus, making your deployment fully private. For more information, refer to the section on [Security and Trust Policies](/developer/deployments/security/index.md). Note that this is only supported for Dedicated IP access.

The following actions may be performed on this page:

- Filter your apps by region
- To filter by group, simply drag and drop the Region, Organization, or Deployment header into the **Drag header here to group** by option
- Use the Search bar to search for specific Apps. Type in a few letters to auto-populate your search results
- Create a new app definition
- Access the quick access menu under Actions to either **Update**, **Delete**, or **Create Instance**.

## Specify Application Definition


- Select **Apps** from the left navigation and select the plus sign icon.
- Once the Create App page opens, populate all required fields. When typing in an application name, do not use underscores.
- Select **Create**.


When specifying the port, you are limited to the following:

- For TCP ports, the maximum number of ports supported is currently 1000.
- For UDP ports, the maximum number of ports supported is currently 10000.

**Warning:** Validation between ports/names are not performed automatically. Therefore, when specifying your ports/names, you must ensure that there are no conflicts between them. Otherwise, your deployment will not succeed.

![Create Apps Screen](/developer/assets/developer-ui-guide/create-apps.png "Create Apps Screen")

Once you have defined your application, it will appear on the Apps page.

![Application Definition list](/developer/assets/developer-ui-guide/apps-list.png "Application Definition list")

## Application Versioning

Application version is used as a key within the MobiledgeX platform. This means a given application is identified by the following:

- **Region** : The regions your application can be deployed
- **Organization** : The organization this application is associated with
- **Application Name** : The name for application definition
- **Application Version** : The version associated with this application definition


Although it is a key, the application version is not checked or parsed by the MobiledgeX platform; this is purely provided as a reference for the developer. Any versioning scheme can be used to identify the app version, for example, you can use a Github commit ID, an image tag name, or even a string description to identify the app version.

## Upgrade Prompt

When a new version of an application is created, the MobiledgeX platform will prompt you to upgrade any Application Instances that are on a version of the application that is older than the most recently deployed version. Note that this does not perform any check of the data entered into the `version` field; it simply checks to see if there is an updated Application with a new version key.

### Setup Application Versioning


- Create a new application version from the Applications screen.
- Within the Application Instances screen, you will see the option to upgrade an application in the Actions menu. Additionally, you will see an up-arrow next to the Application Region column. You may upgrade each application instances on this screen by selecitng **Upgrade** on the application instance. Upgrading allows you to upgrade each application instance at your own pace.
- To perform a bulk upgrade to all application instances in a specific region, select **Upgrade** from the Applications screen. The platform will upgrade all the application instances that have been launched from that application.


**Note:** The platform does not enforce any versioning standards; any value may be added in this field.

