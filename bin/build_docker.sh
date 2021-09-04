#!/bin/sh

. ./config.txt

echo "Build image"
docker build . --tag ${DOCKER_PATH}:${CURRENT}