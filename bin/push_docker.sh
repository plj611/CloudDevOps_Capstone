#!/bin/sh

. ./config.txt

echo "Login Docker"
docker login 

echo "Push image"
docker push ${DOCKER_PATH}:${CURRENT}