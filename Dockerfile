FROM java:openjdk-8
MAINTAINER Hortonworks

ENV VERSION 2.1.0-dev.70

WORKDIR /

# Install zip
RUN apt-get update && apt-get install zip && apt-get clean

# install the cloudbreak app
ADD https://s3-eu-west-1.amazonaws.com/maven.sequenceiq.com/releases/com/sequenceiq/cloudbreak/$VERSION/cloudbreak-$VERSION.jar /cloudbreak.jar

# extract schema files
RUN ( unzip cloudbreak.jar schema/* -d / ) || \
    ( unzip cloudbreak.jar BOOT-INF/classes/schema/* -d /tmp/ && mv /tmp/BOOT-INF/classes/schema/ /schema/ )

# Install starter script for the Cloudbreak application
ADD bootstrap/start_cloudbreak_app.sh /
ADD bootstrap/wait_for_cloudbreak_api.sh /

ENTRYPOINT ["/start_cloudbreak_app.sh"]
