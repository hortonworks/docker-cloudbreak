FROM java:openjdk-8
MAINTAINER info@hortonworks.com

ENV VERSION 1.16.5-rc.11

WORKDIR /

# Install zip
RUN apt-get update --no-install-recommends && apt-get install -y zip=3.0-8 && apt-get clean && rm -rf /var/lib/apt/lists/*

# install the cloudbreak app
ADD https://s3-eu-west-1.amazonaws.com/maven.sequenceiq.com/releases/com/sequenceiq/cloudbreak/$VERSION/cloudbreak-$VERSION.jar /cloudbreak.jar

# add jmx exporter
ADD https://s3.eu-central-1.amazonaws.com/hortonworks-prometheus/jmx_prometheus_javaagent-0.10.jar /jmx_prometheus_javaagent.jar

# extract schema files
RUN ( unzip cloudbreak.jar schema/* -d / ) || \
    ( unzip cloudbreak.jar BOOT-INF/classes/schema/* -d /tmp/ && mv /tmp/BOOT-INF/classes/schema/ /schema/ )

# Install starter script for the Cloudbreak application
COPY bootstrap/start_cloudbreak_app.sh /
COPY bootstrap/wait_for_cloudbreak_api.sh /

ENTRYPOINT ["/start_cloudbreak_app.sh"]