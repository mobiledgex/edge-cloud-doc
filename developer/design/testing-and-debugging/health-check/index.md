---
title: Health Check
long_title:
overview_description:
description:
Understand the various health check types to identify inconsistencies, irregularities, and issues that can possibly decrease operational efficiencies

---

## Health Check

The MobiledgeX Platform provides a Health Check function that manages autoscaling and failover of applications. The Health Check periodically tests specified ports ensuring that applications are responding correctly and available for service requests.

When creating an application with the Console, `mcctl` utility, or directly via the API, a Health Check on a per-port and per-protocol basis may be added. It is vital to ensure that the application instance backend is listening and capable of responding on all ports that have Health Check enabled. Otherwise, the Health Check process will report a failure condition when the port is tested.

The current status of the application instance(s) will be updated and is based on the results of the Health Check. The status of application instances may be viewed via the Console, the `mcctl` utility, or the API directly.  The Health Check is **enabled** by default from the Create Apps page.

### Health Check types

Two types of Health Checks are available:

- **Non-port specific check:** This Health Check verifies the root Load-Balancer (rootLB) is alive and can forward requests to the application instance.
- **Per-port, per-protocol check:** The system opens a socket connection to the backend application on the port that is specified for the application instance.

### Health Check status

The Health Check process will return one of four status values:

- **HealthCheckOk:** The check returned without issues.
- **HealthCheckFailRootlbOffline:** The application instance is unreachable because the rootLB for this application is not accessible.
- **HealthCheckFailServerFail:** The application instance is not responding. This state indicates the application has either crashed or has exited unexpectedly. Also, this status may indicate a problem with the application instance and should be investigated further.
- **HealthCheckUnknown:** This is the default state at the initial startup for application instances. If this value persists, it may indicate a deployment problem with the application.

When Health Checked is enabled on multiple ports that have an associated application instance, the application instance will be marked as unhealthy if one of the associated ports fails the Health Check.

**Note:** A single status will be returned for the combined ports despite a failure occurring on only one of the ports. The health of applications associated with multiple ports is dependent on the health of all associated ports.

### How Health Check failures are managed

The MobiledgeX Platform takes action on any health check statuses other than **HealthCheckOk**.  Currently, the actions taken are as follows:

- Application instances that fail any health check will be removed from the list of viable backends that are returned from the Distributed Matching Engine.
- Application instances that fail a health check can trigger auto-provisioning policies, once the minimum number of instances is no longer satisfied.

### Testing detail

MobiledgeX has tested different failed-state scenarios to ensure that the Health Check feature performs as expected.

**Test Scenario1: HealthCheckFailRootlbOffline status**. MobiledgeX simulated a VM issue of a platform service, or created a network issue where the platform was made unavailable, by shutting down the VM that had a rootLB Envoy proxy. The VM was restarted and then verified that the VM was returned to full operational status and remained in a healthy state.

**Test Scenario2: HealthCheckFailServerFail status**. MobiledgeX simulated a fault with the backend application by scaling down a K8s-based application to zero replicas, or the container for the Docker-based application was stopped. The application was brought back up, scaled to 1 or more pods (for K8s), and verified that the application returned to a healthy state.

**Note:** A test scenario was not performed for the **HealthCheckUnknown** status. **HealthCheckUnknown** is an invalid state and momentarily displays during the initial startup of application instances. However, if this value persists, issues may exist, and further investigation may be necessary.

### Troubleshooting failed Health statuses

In the event of a failed Health Check status, it is recommended to validate the following:

- The backend process is listening on the defined ports.
- The defined ports can be reached from within the application instance.
- The defined ports are reachable from the internet.

If either of the first two cases fails, troubleshooting of the application should be initiated. If the first two cases pass, but the third fails, a support ticket with MobiledgeX must be opened for technical troubleshooting.

If the connection to the backend drops, you can re-initiate a `FindCloudlet` call to retrieve the IP address of a working backend to connect your application.

### Health Check limitations

As of the current release, the Health Check process is limited by the following. However, future releases will address these limitations:

- Only TCP checks are supported; UDP support is actively being developed.
- The Alerting framework does not support external notifications on Health Check status changes.
- Occasionally, a healthy application may generate a **HealthCheckUnknown** status.

### When to disable Health Check

There is a case when disabling Health Check is necessary. If an application does not require listening to a specified port, for instance, it's only opened if a certain condition in the application backend is satisfied, Health Check should be disabled on that particular port. Otherwise, our mechanism will try to connect to it and will generate a **HealthCheckFailServerFail** status for that application instance.

