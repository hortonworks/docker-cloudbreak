
*Cloudbreak is a powerful left surf that breaks over a coral reef, a mile off southwest the island of Tavarua, Fiji.*

*Cloudbreak is a cloud agnostic Hadoop as a Service API. Abstracts the provisioning and ease management and monitoring of on-demand clusters.*

## Overview

Cloudbreak is a RESTful Hadoop as a Service API. Once it is deployed in your favourite servlet container exposes a REST API allowing to span up Hadoop clusters of arbitrary sizes on your selected cloud provider. Provisioning Hadoop has never been easier. Cloudbreak is built on the foundation of cloud providers API (Amazon AWS, Microsoft Azure, Google Cloud Compute...), Apache Ambari, Docker containers, Serf and dnsmasq.

Please note that we are also hosting (based on this Docker image) a Cloudbreak instance - which we maintain, support and continuously improve - based on your feedback. The hosted Cloudbreak is available here:

SequenceIQ's hosted Cloudbreak [instance](https://cloudbreak.sequenceiq.com/).

Cloudbreak [product documentation](http://sequenceiq.com/cloudbreak/).

Cloudbreak [API documentation](http://docs.cloudbreak.apiary.io/).


## Cloudbreak Docker container

We are trying to ease your way to start Cloudbreak and launch on-demand Hadoop clusters in the cloud. The easiest way to start with Cloudbreak is by starting it in  this Docker container. We have put together a fully configured and working Docker container - you will just have to set a few environment variables and you are ready to go.

### Build the image

If you'd like to try directly from the Dockerfile you can build the image as:
```
docker build  -t sequenceiq/cloudbreak .
```

### Start the application stack

To start the application run the following script:

```
sh ./start_cb_stack.sh
```

As a result you'll be provided with the cloudbreak shell terminal; you can start using the application.
(In the background you'll have three containers - the database, the cloudbreak app and the CLI app)
