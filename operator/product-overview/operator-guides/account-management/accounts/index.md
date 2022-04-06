---
title: Accounts
long_title:
overview_description:
description: Learn how to create and manage accounts
---

## Create an Account

First, create an account, if you haven’t already done so. All users must have an account to receive an invite to join an organization.

### To sign up for an account

**Step 1:** From the [Edge-Cloud Console](https://console.mobiledgex.net/#/), select **Register**. A Create New Account screen opens.

![Create New Account screen](/assets/operator-ui-guide/create-new-account.png "Create New Account screen")

**Step 2:** Provide your credentials. Here are some guidelines:

- For the **Username** box, do not use spaces; it must be all one word.
- For the **Password** box, follow the recommend guidelines.

You may optionally select **Generate** to have the system generate a password for you. We suggest managing your password securely or using a password management tool like [LastPass](https://www.lastpass.com/) to safely store your password.

![Password guidelines](/assets/operator-ui-guide/passwd-guide1.png "Password guidelines")

**Step 3:** Provide a valid email address to associate to this account. Use this email address later to access a link and verify your account.

**Step 4:** Read our [Terms of Use](https://mobiledgex.com/terms-of-use) and [Privacy Policy](https://mobiledgex.com/privacy-policy) and select **Sign Up**.

**Step 5:** An email will be sent to you with a link to verify your account. Once you have verified your account, return to the [Edge-Cloud Console](https://console.mobiledgex.net/site1?pg=1) to sign in.

**Note:** After you create your credentials and successfully logged on to our [Edge-Cloud Console](https://console.mobiledgex.net/), Artifactory and Docker registries are automatically created for you. You will use the same credentials to sign in to those registries as you would to sign in to the <a href="https://console.mobiledgex.net/">
**Edge-Cloud Console</a>.**

### Two-factor authentication (2FA)

You can optionally set up two-factor authentication for your account. If you want to add an extra layer of security, we highly recommend that you enable 2FA, which requires a second step of verification when you sign in. Before you can use 2FA, download the free Google Authenticator app from either the [Google Store](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en_US&gl=US) or the [Apple Store](https://apps.apple.com/us/app/google-authenticator/id388497605) from your mobile device.

#### To set up two-factor authentication:</strong>

**Step 1:** After you entered your credentials on the Create New Account screen, toggle the **2FA** enable button until it turns green.

**Step 2:** Select **SIGN UP**. The barcode screen opens.

![Scan barcode screen](/assets/operator-ui-guide/scan-bar-code.png "Scan barcode screen")

**Note:** If you do not have an authentication app on your phone, select **enter this text code instead** to manually enter a code.

**Step 3:** Using the Google Authenticator app, bring your phone camera up to the barcode to scan and receive a text code.

**Step 4:** Select **Done**. You will see a message on the screen that look like the following example:

![Welcome screen](/assets/operator-ui-guide/welcome.png "Welcome screen")

**Step 5:** Continue to follow the instructions to verify your email. You will see a **Sign in** screen after your email is validated.

**Step 6:** Once MobiledgeX Support unlocks your account, type in your username and password.

**Step 7:** You will see the One-Time Passcode (OTP) screen. You can either retrieve the OTP from the authenticator app or from your email used to register the account. Note that your OTP expires after 2 minutes of receiving it. If you need to generate another OTP, select **Login** in the right-hand corner of the console.

![One-Time Passcode screen](/assets/operator-ui-guide/otp-screen.png "One-Time Passcode screen")

**Step 8:** Enter the OTP, and click **Validate OTP**. You are now logged on to the Console.

### Password guidelines

MobiledgeX strives to protect user identity by enforcing the use of strong passwords. The password requirements list appears when you first attempt to create a password, and your password must satisfy all requirements. These requirements help stop possible brute force attacks in cases where usernames are compromised. In addition to the password requirements, the password **Strength** must meet all security protocols provided by MobiledgeX. MobiledgeX measures password strengths on the backend using an entropy score and a password-crack scoring system for both regular and admin users. As you attempt to create your password, the **Strength** indicator bar will turn green, indicating that your password meets the scoring requirements to be considered a strong password.

#### New accounts

For regular users, if the password strength is insufficient, a user account will not be created. The password strength must adhere to the password guidelines to successfully create an account.<br>For admin users, password strength requirements are more robust.

#### Existing accounts

For users with an existing account, MobiledgeX currently allows user logins with a current password. Still, upon use, the console will issue a warning indicating that the password strength is insufficient. The user must decide whether to proceed with their current password or recreate a stronger one. If a user chooses to proceed with their current password, that account may be vulnerable to a security compromise.<br>For admin users, MobiledgeX will check the password strength, and if deemed insufficient, the admin user will not be able to log in until the password is updated.

### Bot protection

Upon login, select the user verification **I’m not a robot** checkbox. However, if the system detects suspicious behavior upon login, you may be required to validate that you are not a Bot with an image recognition task.

## Account Recovery

If you forgot your password, on the Login screen, select **Forgot Password?**, enter the email address associated to the account, and select **Send Password Reset Email**. You will receive an email with a link to reset your password. If you need to unlock your account, contact support@mobiledgex.com.

