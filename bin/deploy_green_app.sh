#!/bin/sh

. ./config.txt
kubectl create deployment get_ip_${CURRENT} --image=docker.io/${DOCKER_PATH}:${CURRENT} --replicas=2 --port=80
kubectl rollout status deployment/get_ip_${CURRENT} # Health check