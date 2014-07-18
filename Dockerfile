FROM dockerfile/java
MAINTAINER SequenceIQ

# install the cloudbreak app
ADD https://s3-eu-west-1.amazonaws.com/seq-repo/releases/com/sequenceiq/cloudbreak/0.1-20140718152400/cloudbreak-0.1-20140718152400.jar /cloudbreak.jar

# install the cloudbreak-shell app
ADD https://s3-eu-west-1.amazonaws.com/maven.sequenceiq.com/snapshots/com/sequenceiq/cloudbreak/cloudbreak-shell/0.1-SNAPSHOT/cloudbreak-shell-0.1-20140718.152041-37.jar /cloudbreak-shell.jar

# Install starter script for the cloudbreak shell application
ADD add/start_cb_shell.sh /

WORKDIR /tmp
ENTRYPOINT ["java", "-jar", "/cloudbreak.jar"]
