#! /bin/bash

BUILDCMD="docker buildx build --platform linux/arm/v7 --load" $(dirname $0)/build.sh
