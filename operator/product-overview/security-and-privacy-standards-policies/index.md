---
title: Security and Privacy Standards Policies
long_title:
overview_description:
description: Learn about our approach to security and privacy policies to protect users and data
---

This document describes MobiledgeX’s approach to security standards and guidelines to protect user data and applications.

## Section 1. Shared Security Responsibility Model

MobiledgeX’s platform aggregates edge infrastructure across operator network locations through one standard interface that application developers can use to design, deploy, and manage their applications. As MobiledgeX’s platform operates across operator infrastructure, security responsibilities become shared between MobiledgeX and the operators. Operators are responsible for securing the underlying infrastructure/IaaS layer. At the same time, MobiledgeX’s Platform Layer is responsible for security as a Tenant inside the operator’s Network. MobiledgeX’s Service Layer operates on a global level within the Public Cloud and is responsible for securing MobiledgeX’s OperatorUsers. The diagram below illustrates the shared responsibilities and various layers, as described.

![MobiledgeX shared security responsibility model](/assets/security-standards-policies/shared-model.png "MobiledgeX shared security responsibility model")

### MobiledgeX security responsibilities

MobiledgeX’s software accesses the Virtualization API endpoint to install the MobiledgeX platform service referred to as the Cloudlet Resource Manager (CRM). CRM acts as a Tenant of the operator’s Virtualization Layer. CRM utilizes Virtualization APIs to manage applications and provides infrastructure and application runtime statistics to the MobiledgeX Controller (over the Internet). MobiledgeX securely stores the credentials to the API. Connections between the CRM and API, which are determined by the environment in which they are deployed, may be placed on a separate network. MobiledgeX guarantees that ingress traffic is not permitted into the CRM and the connection from the CRM to the Controller originates from the CRM. Internal communications between the CRM and MobiledgeX are encrypted and use mutual TLS authentication.

DeveloperUsers of the edge cloud infrastructure may access MobiledgeX’s Service Layer to manage and deploy their applications, where the deployments of these applications operate at a global level in the Public Cloud. For this reason, MobiledgeX ensures that security protocols are in place to protect DeveloperUsers data and deployed applications. Subsequent sections describe additional high-level security standards and guidelines.

### Operator security responsibilities

The operator is responsible for the protection of their edge cloud infrastructure, which can consist of hardware, networking, storage, and physical facilities. In addition to protecting the facility and Infrastructure Layer, the operator is responsible for the security components associated with the Virtualization Layer. The Virtualization layer is where the operator must provide Tenant security, and functionality must be available to provide separation between Tenants. MobiledgeX requires both Admin and Tenant access on the IaaS API level is granted via private and public API endpoints. It is not a requirement to place the IaaS endpoint directly on a public IP; it can reside behind a jumphost or by other security measures.

The operator must ensure that MobiledgeX’s software is deployed behind the operator’s firewall and inside DMZ, provide Intrusion detection/prevention (IDS/IPS) systems, and monitor high and critical priority alerts. MobiledgeX relies on the operator to be responsible for network monitoring and firewall configuration across its infrastructure. Operator-provided firewalls and network monitoring protect MobiledgeX’s services from network attacks. If the operator requires proper network traffic isolation, it is the operator’s responsibility to provide the necessary isolated network interfaces to MobiledgeX.

## Section 2. Operational Security

### Access Control

a). MobiledgeX restricts access to the MobiledgeX Edge Cloud (“Edge Services”) by using an account approval process for application owners by the MobiledgeX console administrator.

b). MobiledgeX implements processes which require that all users are assigned a unique user identification that must not be shared, and are required to authenticate their identity (e.g., passwords) before accessing Edge Services.

c). MobiledgeX implements processes that require the secure creation, modification, and deletion of Edge Services accounts (both local and remote).

d). MobiledgeX reviews and updates access rights to the Edge Services at a minimum, annually.

e). Support for reCAPTHCA is implemented.

f). Two-Factor Authentication(2FA) can be optionally set.

g). MobiledgeX enforces the following minimum password requirements within the Edge Services account set up:

- Passwords are stored hashed.
- User account credentials (e.g., passwords) must not be shared.
- Strong passwords are enforced, with password strength checks performed during account creation and password change operations.
- Default passwords are prohibited.
- Session timeouts are enforced.

### Operations security

a). MobiledgeX implements and maintains controls to prevent and detect unauthorized access, intrusions, and malware to MobiledgeX component services, which at a minimum includes:

- a process that will install any applicable critical patches or security updates for all production and internet-facing environments within thirty (30) days; or communications with the customer detailing why patches and updates are not required.
- ensuring that only licensed software or open-source software with proper attribution is installed in MobiledgeX’s component services. Attribution is not able to be confirmed in third party application developers code.

b). MobiledgeX maintains documented change management procedures that provide a consistent approach for controlling and identifying changes (including high risk and emergency changes) to the Edge Service, which includes segregation of duties and security requirements.

c). Development and testing environments for the Edge Services are physically and/or logically separated from production and internet-facing environments. The appropriate owner approves production changes.

d). MobiledgeX’s test environment has the same controls as the production environment; and

e). MobiledgeX provides physical and/or logical separation from other MobiledgeX customer account information.

### Cryptography

All security information processed by the Edge Services is encrypted when in transit and at rest, and MobiledgeX protects customers’ information by implementing cryptographic and hashing algorithm types, strength, and key management processes, consistent with or exceeding current security industry standards. MobiledgeX does not transfer customer information to any portable computing device or any portable storage medium unless it is encrypted and compatible with or exceeding current security industry standards.

#### Application and device security

Control-plane communication between a device and MobiledgeX services is encrypted using server-side TLS. An additional optional client authentication process is also provided, which leverages a public key pair provided by the DeveloperUser.

Data-plane communication between an application client on a device and its backend deployed by MobiledgeX is encrypted using server-side TLS. Any authentication of the device or user of the device is the responsibility of the DeveloperUser’s backend.

#### Cloud services and operations security

All communications between internal MobiledgeX services are encrypted using mutual TLS consistent with or exceeding current industry standards.

All access to MobiledgeX infrastructure, including edge cloud infrastructure deployed within the Operator-managed virtualization layer, is audited.

#### Rate limiting

To protect services and endpoints from brute-force attempts, such as DDoS attacks, and reduce the likelihood of security breaches, MobiledgeX limits the number of requests an entity (user or organization) can send to an API within a time window. Once the entity reaches the rate limiter cap, MobiledgeX will block additional requests sent to the API for a defined amount of time. We support rate-limiting for MC, DME, and Controller APIs.

### Software development requirements

MobiledgeX implements a documented and validated software development life cycle process, which includes requirements gathering, system design, integration testing, user acceptance testing, and system acceptance. Security requirements are documented throughout the Edge Services life cycle. All confirmed high/critical security vulnerabilities found during testing are remediated and retested before moving to the production phase. Additionally, all edge-cloud images are security scanned using **[Trivy](https://aquasecurity.github.io/trivy/v0.19).**

### MobiledgeX-owned repository 

**Docker Registry:** MobiledgeX stores DeveloperUser applications’ container images in GitLab instance.

**VM Registry:** DeveloperUser applications’ VMs for VM-based deployments are stored in MobiledgeX’s Artifactory instance. Access to the VM instances is limited to the least amount of privilege necessary.

MobiledgeX Support will never access private repositories unless required for support reasons, and only when requested by the owner of the repository via a support ticket. When working on a support issue, MobiledgeX strives to respect DeveloperUser privacy as much as practical and will only access files and settings, as required, to resolve the issue. Developers will at all times have access and admin rights to the MobiledgeX GitLab CE registry so they can view, change, or delete the data.

## Section 3. OS Security Compliance

### CIS-CAT

Center of Internet (CIS) is a non-profit organization set up to identify, develop, validate, promote, and sustain best practice solutions for cyber defense. CIS employs a closed crowdsourcing model to identify and refine effective security measures, and releases these recommendations as a set of benchmarks for individual operating systems. CIS also publishes a configuration assessment tool (CIS-CAT) that compares the configuration of target systems to the recommended benchmarks.

#### CIS-CAT certified for MobiledgeX base images

MobiledgeX base images were tested and certified against the following:

- **CIS Ubuntu Linux 18.04 LTS Benchmark, v1.0.0 with the Level 1-Server profile**
- ***CIS Ubuntu Linux 18.04 LTS Benchmark, v2.0.0 with Level 1-Server profile**
- ***CIS Benchmark for CentOS Linux 7 Benchmark v2.2.0 Level 1 Server**

