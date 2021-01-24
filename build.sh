#! /bin/bash

[ -z "${BUILDCMD}" ] && BUILDCMD="docker build"

REPO=68fpjc/bondriverproxy
FINAL_IMAGE=${REPO}:2021-01-24

${BUILDCMD} "$(dirname $0)"/dockerfiles/bon/ --tag ${FINAL_IMAGE} \
&& docker image tag ${FINAL_IMAGE} ${REPO}

REPO=68fpjc/mirakurun
FINAL_IMAGE=${REPO}:3.5.0
BASE=chinachu/mirakurun:3.5.0

${BUILDCMD} "$(dirname $0)"/dockerfiles/mirakurun/ --tag ${FINAL_IMAGE} \
--build-arg BASE=${BASE} \
&& docker image tag ${FINAL_IMAGE} ${REPO}

REPO=68fpjc/mirakc
FINAL_IMAGE=${REPO}:0.16.1
BASE=mirakc/mirakc:0.16.1-debian

${BUILDCMD} "$(dirname $0)"/dockerfiles/mirakc/ --tag ${FINAL_IMAGE} \
--build-arg BASE=${BASE} \
&& docker image tag ${FINAL_IMAGE} ${REPO}
