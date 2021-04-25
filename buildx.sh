#! /bin/bash

pushd "$(dirname $0)"

docker buildx create --name mybuilder

# BonDriverProxy_Linux
docker buildx build --builder mybuilder --platform linux/arm/v7 --load \
--tag 68fpjc/bondriverproxy:2021-03-02-armhf \
dockerfiles/bon/

# Mirakurun
docker buildx build --builder mybuilder --platform linux/arm/v7 --load \
--tag 68fpjc/mirakurun:3.5.0-armhf \
--build-arg BASE=chinachu/mirakurun:3.5.0 \
dockerfiles/mirakurun/

# mirakc
docker buildx build --builder mybuilder --platform linux/arm/v7 --load \
--tag 68fpjc/mirakc:0.17.3-armhf \
--build-arg BASE=mirakc/mirakc:0.17.3-debian \
dockerfiles/mirakc/

popd
