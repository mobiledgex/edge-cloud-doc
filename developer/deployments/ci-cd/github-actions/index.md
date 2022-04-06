---
title: GitHub Actions
long_title: Deploy Applications using GitHub Actions
overview_description:
description:
Learn how our CI/CD approach helps you bridge the gaps between development and operational activities to automate, test, and deploy applications

---

**Last Modified:** 11/18/21

While the [Edge-Cloud Console](https://console.mobiledgex.net/) provides an easy way to deploy your applications, you can auto-deploy your applications to our cloudlets using [GitHub Actions](https://github.com/features/actions). This guide provides steps on how to integrate [GitHub Actions](https://github.com/features/actions) into your own edge application that’s hosted on Github. For reference, we have provided a [sample repository](https://github.com/mobiledgex/github-actions-sample) containing sample files to help guide you in setting up your configuration to successfully deploy your application to our cloudlets.

**Note:** The current version of **GitHub Actions** only supports Docker and Kubernetes-based deployments. While the sample provided in this tutorial shows a Docker deployment, you can follow the same steps if you were to deploy using a Kubernetes-based deployment. Simply specify the deployment type as Kubernetes. However, if you do not specify a deployment type in your manifest, it will default to Kubernetes. See the example in `app.yml`.

## Prerequisites

- Familiarize yourself with [GitHub Actions](https://github.com/features/actions)
- Know how to [create and store encrypted secrets](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets) for the repository
- A Docker application hosted on Github

## One-time Setup to Support GitHub Actions

You will only be required to setup your repository (Steps 1 through 4) once to support **GitHub Actions**.

- Step 1: Set up username and password for the Docker repository
- Step 2: Set up your application configuration files in the repository
- Step 3 (Optional): Configure your application instances
- Step 4: Set up the GitHub workflow

### Step 1: Set up username and password for the Docker repository

Add your console **username** and **password** as secrets to your Github repository. This creates an encrypted environment variable within the repository to be used with **GitHub Actions**.

- On GitHub, navigate to the main page of your repository.
- Under your repository name, click the *Settings* option.
- On the left sidebar, select **Secrets**.
- Type a name for your secret in the **Name** box.
- Type the values of your secret.
- Select **Add secret**.


![GitHub Repository Secrets Page](/developer/assets/git-hub-actions/secrets.png "GitHub Repository Secrets Page")

The username and password are stored as `MOBILEDGEX_USERNAME` and `MOBILEDGEX_PASSWORD`, which are used as variables in the configuration files. Refer to the [main.yml](https://github.com/mobiledgex/github-actions-sample/blob/master/.github/workflows/main.yml) file as an example.

For more information about creating and storing secrets in GitHub, refer to [Creating and storing encrypted secrets](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets).

### Step 2: Set up your application configuration in the repository

This step requires you to set up your application configuration files within the repository. The application configuration mirrors a standard application definition that you would normally provide through the [Edge-Cloud Console](https://console.mobiledgex.net/). However, the only difference will be the *image path*, which does not require you to specify a version tag since the version tag will automatically be retrieved from the GitHub release.

- Within your repository, create a folder called `.mobiledgex` at the root.
- Within this folder, create a .yaml file and name it `app.yml`.
- Define your application configuration using the template provided in our sample repository: [app.yml](https://github.com/mobiledgex/github-actions-sample/blob/master/.mobiledgex/app.yml).


### Step 3 (Optional): Configure your application instances

If you decide to perform this optional step, you need to either specify an autocluster name or ensure that you define your cluster instance beforehand and specify the cluster instance within the application instance.

- Within your repository, navigate to the default path: `.mobiledgex`.
- Create a .yaml file and name it `appinstst.yml`.
- Define your application instance configuration using the template provided in our sample repository: [appinsts.yml](https://github.com/mobiledgex/github-actions-sample/blob/master/.mobiledgex/appinsts.yml).


### Step 4: Set up the GitHub workflow


- Within your repository, create the path `.github/workflows` at the root.
- Under the newly created `.github/workflows` path, create a file and name it `main.yml`.
- Define your build workflow using our template provided in our sample repository: [main.yml](https://github.com/mobiledgex/github-actions-sample/blob/master/.github/workflows/main.yml).


The `main.yml` sample file contains an ordered workflow that will run to deploy an application. The top of the `main.yml` file displays the workflow, as shown below.

```
on:
  release:
    types: [published]

```

Following the workflow are the rest of the steps. Our example uses two open source projects `actions/checkout` and `docker/build-push-action` , as show below. If you wish to customize the steps to check out a repository or push to Gitlab, refer to each project’s documentation for instructions.

```
steps:
      - name: Check out the repo
        uses: actions/checkout@v2

```

The following section of the sample file displays the Docker actions required to build and publish the Docker image to the registry. Make sure to change the repository name and path to match the name and path of the image you will be deploying.

![Push to GitHub](/developer/assets/git-hub-actions/push-to-git.png "Push to GitHub")

The following section of the sample file uses this custom action, as shown below, to deploy your application to our cloudlets. You can learn more about this action from this repository.

![Deploy Application](/developer/assets/sample-code-1.png "Deploy Application")

**Note:** You can use the same workflow process as described above to perform different actions as long as you assign a different name for each workflow. In cases where you want to deploy your application to a specific cloudlet, for example, remember to specify the paths to `appconfig` and `appinstsconfig`. These *optional* parameters are defaulted to `.mobiledgex/app.yml` and `.mobiledgex/appinsts.yml`, respectively.

### Step 5: Deploy the application


- Make any necessary changes within the code.
- Create a release.<br>a. On GitHub, navigate to the main page of your repository.<br>b. Under the repository name, select **Releases**.<br>c. Select **Draft a new release**. d. Type a version number for your release. e. Select the branch that contains the project you want to release using the drop-down menu.<br>f. Type a **title** and **description** for your release.<br>g. Select **Publish release**.<br>h. Select the **Actions** tab to watch the deployment.


For more information on managing your releases on GitHub, refer to [Managing your releases](https://help.github.com/en/github/administering-a-repository/managing-releases-in-a-repository).

That’s it! You have now learned how to use [GitHub Actions](https://github.com/features/actions) to auto-deploy your application.

