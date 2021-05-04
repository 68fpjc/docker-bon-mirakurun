#! /bin/bash

for IMAGE in \
68fpjc/bondriverproxy:2021-03-02 \
68fpjc/mirakurun:3.5.0 \
68fpjc/mirakc:0.17.4 \
; do
  ssh tvtuner docker image inspect ${IMAGE} &> /dev/null
  if [ $? -ne 0 ]; then
    echo Deploying ${IMAGE} ...
    docker save ${IMAGE}-armhf | ssh tvtuner docker load \
    && ssh tvtuner docker image tag ${IMAGE}-armhf ${IMAGE} \
    && ssh tvtuner docker image rm ${IMAGE}-armhf
  fi
done
