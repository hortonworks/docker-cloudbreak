#!/bin/bash

set -eo pipefail
if [[ "$TRACE" ]]; then
    : ${START_TIME:=$(date +%s)}
    export START_TIME
    export PS4='+ [TRACE $BASH_SOURCE:$LINENO][ellapsed: $(( $(date +%s) -  $START_TIME ))] '
    set -x
fi

debug() {
  [[ "$DEBUG" ]] && echo "-----> $*" 1>&2 || :
}


install_deps() {
  if ! dockerhub-tag --version &>/dev/null ;then
    debug "installing dockerhub-tag binary to /usr/local/bin"
    curl -L https://github.com/progrium/dockerhub-tag/releases/download/v0.2.0/dockerhub-tag_0.2.0_$(uname)_x86_64.tgz | tar -xz -C /usr/local/bin/
  else
    debug "dockerhub-tag already installed"
fi
}

new_version() {
  install_deps
  
  declare VERSION_TYPE="$(echo ${VERSION} | awk -F"-" '{ print $2 }' | awk -F"." '{ print $1 }')"

  declare VERSION_BRANCH="master"
  if [[ "$VERSION_TYPE" = "rc" ]]; then
    VERSION_BRANCH="$(echo ${VERSION} | awk -F"." '{ print "rc-"$1"."$2 }')"
  elif [[ "$VERSION_TYPE" = "" ]]; then
    VERSION_BRANCH="$(echo ${VERSION} | awk -F"." '{ print "release-"$1"."$2 }')"
  fi

  debug "checking out branch: $VERSION_BRANCH"

  git checkout ${VERSION_BRANCH}

  debug "building docker image for version: $VERSION"
  sed -i "/^ENV VERSION/ s/VERSION .*/VERSION ${VERSION}/" Dockerfile

  git commit -m "Release ${VERSION}" Dockerfile
  git tag ${VERSION}
  git push origin ${VERSION_BRANCH} --tags
  
  dockerhub-tag set ${DOCKER_IMAGE} ${VERSION} ${VERSION} /
}

main() {
  : ${VERSION:?"required!"}
  : ${DOCKER_IMAGE:?"required!"}
  : ${DOCKERHUB_USERNAME:?"required!"}
  : ${DOCKERHUB_PASSWORD:?"required!"}
  : ${DEBUG:=1}

  new_version "$@"
}

[[ "$0" ==  "$BASH_SOURCE" ]] && main "$@"
