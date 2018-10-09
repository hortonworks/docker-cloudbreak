export MAVEN_METADATA_URL = maven.sequenceiq.com/releases/com/sequenceiq/cloudbreak/maven-metadata.xml

dockerhub:
	./deploy.sh $(VERSION)
