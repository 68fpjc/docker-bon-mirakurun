#! /bin/bash

cd "$(dirname $0)"

docker buildx create --name mybuilder

# BonDriverProxy_Linux
docker buildx build --builder mybuilder --platform linux/arm/v7 --load \
--tag 68fpjc/bondriverproxy:2021-03-02-armhf \
dockerfiles/bon/ \
|| exit 1

# Mirakurun
docker buildx build --builder mybuilder --platform linux/arm/v7 --load \
--tag 68fpjc/mirakurun:3.8.0-armhf \
--build-arg BASE=chinachu/mirakurun:3.8.0 \
dockerfiles/mirakurun/ \
|| exit 1

# mirakc
docker buildx build --builder mybuilder --platform linux/arm/v7 --load \
--tag 68fpjc/mirakc:1.0.0-armhf \
--build-arg BASE=mirakc/mirakc:1.0.0-debian \
dockerfiles/mirakc/ \
|| exit 1
