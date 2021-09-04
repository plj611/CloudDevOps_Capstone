#!/bin/sh

. ./config.txt

echo "Build first image"
docker build . --tag ${DOCKER_PATH}:${LAST}

echo "Login Docker"
docker login 

echo "Push image"
docker push ${DOCKER_PATH}:${LAST}