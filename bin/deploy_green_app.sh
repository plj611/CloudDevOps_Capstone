#!/bin/sh

. ./config.txt
kubectl create deployment get-ip-${CURRENT} --image=docker.io/${DOCKER_PATH}:${CURRENT} --replicas=2 --port=80
kubectl rollout status deployment/get-ip-${CURRENT} # Health check