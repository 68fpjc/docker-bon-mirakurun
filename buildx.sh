#! /bin/bash

pushd "$(dirname $0)"

docker buildx create --name mybuilder

# BonDriverProxy_Linux
docker buildx build --builder mybuilder --platform linux/arm/v7 --load \
--tag 68fpjc/bondriverproxy:2021-03-02-armhf \
dockerfiles/bon/

# Mirakurun
docker buildx build --builder mybuilder --platform linux/arm/v7 --load \
--tag 68fpjc/mirakurun:3.7.1-armhf \
--build-arg BASE=chinachu/mirakurun:3.7.1 \
dockerfiles/mirakurun/

# mirakc
docker buildx build --builder mybuilder --platform linux/arm/v7 --load \
--tag 68fpjc/mirakc:1.0.0-armhf \
--build-arg BASE=mirakc/mirakc:1.0.0-debian \
dockerfiles/mirakc/

popd
