---
title: "Best Practices : Deployments"
long_title: Best Practices for Container Deployments on MobiledgeX
overview_description:
description:
Learn about best practices and recommendations for container deployment for deploying to the MobiledgeX Edge-Cloud platform.

---

**Version:** 1.0<br />
**Last Modified:** 9/11/2020

The MobiledgeX platform allows the deployment of virtual machine images and any workload that may be containerized. MobiledgeX provides you with enormous flexibility, but keep in mind; not all supported deployment methods may be able to use all of  MobiledgeX’s platform features. The purpose of this document is to provide a high level overview of the deployment types we support, high-level descriptions of features applicable to each deployment types are provided, detailed security and storage considerations are outlined, and more.

The table below shows the deployment methods and platform features available for each method.

| Deployment Type | Autoscale | Autoprovision | Health Check | Load Balancer | TLS Termination |
|-----------------|-----------|---------------|--------------|---------------|-----------------|
| Virtual Machine | X         | X             | X            |
| Docker Image    | X         | X             | X            | X             |
| Docker Compose  | X         | X             | X            | X             |
| Kubernetes YAML | X         | X             | X            | X             | X               |
| HELM Chart      | X         | X             | X            | X             | X               |

## Feature Definition

### Autoscale

The auto-scale policy governs scaling the number of nodes of a Kubernetes cluster to provide more compute resources for your application by monitoring the CPU load on the nodes. For more information, see [Autoscale](/deployments/application-runtime/autoscale).

### Auto-Provision

The auto-provision policy can be set to manage the deployment of application instances to different cloudlets providing better service and redundancy. The auto-provision policy works by monitoring `FindCloudlet` requests for applications across all cloudlets associated with the policy. For more information, see [Auto-Provisioning Policy](/deployments/application-runtime/auto-prov).

### Health Check

The MobiledgeX Platform provides a Health Check function that manages autoscaling and failover of applications. The Health Check periodically tests specified ports ensuring that applications are responding correctly and available for service requests.

When creating an application with the Console, `mcctl` utility, or directly via the API, a Health Check on a per-port and per-protocol basis may be added. It is vital to ensure that the application instance backend is listening and capable of responding on all ports that have Health Check enabled. Otherwise, the Health Check process will report a failure condition when the port is tested. For more information, see [Health Check](/design/testing-and-debugging/health-check).

### Load Balancer

You can determine how traffic is routed to application instances. For more information, see [Load Balance](/design/load-balancing).

### TLS Termination

MobiledgeX offers TLS termination at the load balancer. With TLS termination, the resulting traffic is sent directly to your application instance, allowing you to quickly and securely deploy your application. Enable the TLS option when you specify your port(s) within the Create Apps page. The TLS option removes the need to generate and manage Certs, and eliminates the requirement to configure your application for TLS. For more information, see [Securing application access with TLS](/design/load-balancing).

### Languages

The MobiledgeX platform does not require the use of specific languages, as long as the workload is expressed in containers or virtual machine.

### Security Considerations

MobiledgeX recommends that your application is secured according to industry best practices and any internal guidelines your organization maintains. If you need assistance securing your application, MobiledgeX provides features designed to help secure your application. These include [Trust Policies](https://developers.mobiledgex.com/deployments/security), TLS security for inbound connections, and the default denial of any inbound traffic that is not explicitly set for an application.

Additionally, containerized workloads should adhere to the following criteria:

- Do not run untrusted binaries inside your application container.
- Follow the principle of least access; do not add additional capabilities to your docker container (such as SYS or NET) unless there is a need for these privileges.

### Deployment

Applications are deployed to the MobiledgeX platform in the following ways:

- Through the Web Console.
- Through the `mcctl` utility.
- Using the MobiledgeX API directly.


### Application Versioning

MobiledgeX provides a version field that distinguishes between different application versions. Distinguishing applications allow gradual rollouts of changes. Our suggested process to version your application is performed via any of the three options listed above.

**Note:** The platform does not enforce any versioning standards; any value may be added in this field.

#### Considerations

For virtual machine deployments, it is not possible to update the ports on a deployed application. You must recreate the application to deploy to an alternate port.

### Persistent Storage Considerations

All data required for applications to run correctly should be loaded as part of the initialization process. If you require persistent data, it is recommended that the persistent data store is located in a non-edge location. Once the data store is located, pull the data to the edge as needed. Be sure to allow for the time necessary to populate your edge application with the data as part of your high availability/scaling procedures.

If you require persistent storage on the edge, you may make use of the volumes defined in the application definition. If you choose to do this, it is recommended that you establish the architecture of your application in such a way that it is readily available through clustering or replication. Additionally, ensure to have a defined backup/recovery process, and it is tested regularly. For more information, see [Shared Volume support](/deployments/deployment-workflow/clusters#shared-volume-support).

### Continuous Integration

MobiledgeX’s API may be used to enable CI/CD pipelines by using tools such as [GitHub Actions](/deployments/ci-cd/github-actions) or Jenkins jobs.

### Secret Storage

When deploying workloads to the Edge, you will likely have secrets (passwords, keys, certificates, etc.) that your application will need to access.

- In most cases, a secrets management system should be used to enforce standardized access to secrets, including auditing, key rotation, and better management.
- If the use of a secrets management system is not possible, it is recommended not to check secrets into version control.

### Load Shedding/Throttling

Your applications should contain logic that allows it to throttle requests; this ensures that the application will not be overwhelmed by those requests to the point where it affects user experience. The threshold at which the application will begin to throttle or shed connections should be defined as higher than the thresholds defined within the MobiledgeX Platform for the [Autoscale](/deployments/application-runtime/autoscale) and [Auto-provision](/deployments/application-runtime/auto-prov) policies. Setting your threshold higher provides a safety net for applications if an issue occurs within the application instance or if excessive traffic is sent to the instance.

Setting a threshold also defines a reference when the application needs to either be scaled or when more instances are provisioned.

### Auditing/Tracing

The container engine can process all logging of your containers. The container engine is available for view in the MobiledgeX [Edge-Cloud Console](https://console.mobiledgex.net/#/). MobiledgeX suggests that audit information is added to the application to aid in troubleshooting. The MobiledgeX [Edge-Cloud Console](https://console.mobiledgex.net/#/) provides audit information for actions taken in the console but does not provide information for the application logic.

### Application Monitoring

MobiledgeX provides monitoring for deployed containers via the web console, the mcctl utility, and the MobiledgeX API. The following metrics are available for an Application Instance:

- CPU usage
- Memory usage
- Disk usage
- Inbound/Outbound Network usage
- Histogram of Connection times

If you wish for more detailed metrics for your application, they must be included as part of your deployment.

### Debugging

#### Application BOM

To aid debugging and to provide documentation for troubleshooting, MobiledgeX recommends that every application deployed to contain a BOM file that supplies the following information:

- The version of the components, possibly including commit information.
- Hash of the files.
Build environment details:

- Software versions
- Environment variables
- SDK version


- Dependency versions
- Any other pertinent information

### Trace ID

Every action that is performed on the MobiledgeX platform is associated with a `TraceID`. `TraceID` is a 17-character alphanumeric that uniquely identifies actions within the MobiledgeX audit system. If you encounter an error on the MobiledgeX platform, please provide the associated `TraceID`(s) to customer support to expedite the investigation and remediation of the issue.

### Time Zone

As a best practice, when components are using or displaying time information when possible, the time data should be expressed in UTC format. Once put into UTC, the time data can be converted to a display format if necessary.

