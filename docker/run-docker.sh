#!/bin/bash

# Scripts runs opentee docker image

mkdir -p ~/.TEE_secure_storage

docker run -it --rm=true --net=host --ipc=host \
       --user $(id -u):$(id -g) \
       -v /tmp:/tmp \
       -v /opt/OpenTee:/opt/OpenTee \
       -v ~/.TEE_secure_storage:/home/docker/.TEE_secure_storage \
       -v $(pwd)/../..:/home/docker/opentee \
       -v /dev/log:/dev/log \
       opentee


