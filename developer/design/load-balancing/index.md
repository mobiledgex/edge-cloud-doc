---
title: "Best Practices : Load Balancing"
long_title: Best Practices for Load Balancing
overview_description:
description:
Learn how to use MobiledgeX TLS securely to route your network traffic

---

MobiledgeX provides a **Load Balancer** to route traffic to your application instances. Load Balancer provides statistical information that can be used to monitor your application's performance and data points, like the number of connections active, and the amount of data transferred. With the information provided by the **Load Balancer**, you can make informed decisions to improve performance expectations.

## Shared Load Balancers

Shared Load Balancers are shared across multiple applications on a cloudlet. As a result, it is likely that the ports will be remapped and the external facing ports will differ from the ports requested. Your container's ports will be identical to the ones requested. If you click on the details page of your application instance, you will see how your ports have been remapped. You can use the MobiledgeX SDKs to automatically get the correct remapped ports.

## Dedicated Load Balancers

Dedicated Load Balancers are dedicated to your cluster instance. As such, you will have control over which external ports are utilized and can ensure that the internal and external ports are identical. However, this will use another VM for the dedicated Load Balancer. Depending on resource utilization, this option may or may not be available for every cloudlet on MobiledgeX.

## Securing application access with TLS

MobiledgeX lets you quickly and securely deploy your applications using TLS with Load Balancer. The MobiledgeX Load Balancer will forward TLS traffic directly to your container, where you can essentially perform your own TLS termination.

The image below illustrates scenarios covering TCP traffic to secure your applications using Shared Load Balancer versus Dedicated Load Balancer. The following use cases are covered:

- TLS termination by MobiledgeX at the Load Balancer
- No TLS termination by MobiledgeX at the Load Balancer (straight TCP traffic pass-through)
- TLS termination by the customer at the container level (straight TCP traffic pass-through by the Load Balancer)

**Some things to keep in mind:**

- Set the toggle appropriately for the type of scenario used. That is, if the desire is to have MobiledgeX use TLS,  make sure to turn it on for the ports.
- It is possible to have a mix of these approaches; each port can be handled differently. For example, you can pass through three ports in either type of  with one being TLS termination by MobiledgeX, one being straight non-TLS traffic handled as such at the container, and one being TLS traffic passed through by the LoadBlancer and terminated by the container.
- In every case except where TLS is terminated at the container,  the traffic sent from the MobiledgeX Load Balancer to the container is unencrypted (the TLS termination is done at the Load Balancer and the unencrypted data is sent into the container).
- For Load Balancer deployments, the limited maximum amount of TCP ports currently supported is **1000**, while the limited maximum amount of UPD ports currently supported is **10000**.

![MobiledgeX and TLS](/developer/assets/developer-ui-guide/mex-and-tls-rev.png "MobiledgeX and TLS")

### MobiledgeX-managed TLS

MobiledgeX offers TLS termination at the Load Balancer. With TLS termination, the resulting traffic is sent directly to your application instance, allowing you to quickly and securely deploy your application. Enable the TLS option when you specify your port(s) within the Create Apps page. The TLS option removes the need to generate and manage Certs, and eliminates the requirement to configure your application for TLS.

- Within the Create Apps page, Select **Load Balancer** as the *Access Type*.
- Enable TLS for each port(s) desired.
- Ensure your application is listening on the ports enabled; TLS termination will be performed at the load balancer, so you do not need to enable TLS/SSL in your application.
- Test your connection.


### UDP Traffic

For UDP, traffic is sent through the Load Balancer as well, but since it's datagram-based, there is no TLS option. Below illustrates the UDP flow.

**Note:** Currently, UDP datagrams are limited to a maximum size of 1,400 bytes. Datagrams greater than 1,400 bytes will be dropped by the Load Balancer. Also, UDP traffic through the shared Load Balancer is subject to the same port remapping that is noted for TCP traffic.

![MobiledgeX and UDP](/developer/assets/developer-ui-guide/mex-lb-udp.png "MobiledgeX and UDP")

