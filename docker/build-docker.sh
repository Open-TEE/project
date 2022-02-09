#!/bin/bash

#Scripts build opentee docker image.

docker build -f Dockerfile.opentee . -t opentee:latest
