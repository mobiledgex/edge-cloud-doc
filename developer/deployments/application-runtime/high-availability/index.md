---
title: High Availabilty
long_title:
overview_description:
description:
Learn how to ensure continuous availability of the MobiledgeX platform for all applications running on the cloudlets

---

**Last Modified: 11/18/21**

MobiledgeX aims to ensure your application instances are continuously available and operational on cloudlets. In the event that the application(s) experience connectivity issue or one of the cloudlets become unreachable, our high availability feature will ensure that applications and cloudlets remain fully operational with very minimal disruptions to users who are connected to your application.

High availability, which works in concert with the auto provision policy, lets you specify the number of active application instances on the policy to enable high availability for all applications and cloudlets associated to the policy. This guarantees that the policy will maintain the specified number of active instances among the cloudlets for all applications associated to the policy.

**Note:** An application instance is not considered active if the health check fails for that instance, if the cloudlet in which the instance is associated with fails health check, or if the cloudlet is under maintenance.

### Enable high availability

To enable high availability, specify the **Min Active Instances** setting on the Create Auto Provision Policy page to set up for either *active-standby* or *active-active* high availability.

- Specifying a minimum active instance of 1 creates an *active-standby* approach. This means if the single instance fails, another instance is created on a different cloudlet once the failure is detected.
- Specifying a minimum active instance of 2 or more creates an *active-active* approach, where the policy will always maintain the number of specified instances. This approach ensures that one instance will always be available unless there are multiple concurrent failures.

Application high availability works in conjunction with the `FindCloudlet` client demand-based deployment. Instances may be deployed in response to client demand, or to meet the minimum active instances requirement in the policy. For demand-based auto deployment, instances are only created on cloudlets that are listed on the policy. To meet the **minimum active instances** requirement, a cloudlet from the list that has seen recent client activity will be selected. If no such activity exists, then the next available cloudlet on the list will be chosen. With demand-based auto deployment, only one instance of the app will be automatically deployed per cloudlet.

![](/developer/assets/ha-select.png "")

