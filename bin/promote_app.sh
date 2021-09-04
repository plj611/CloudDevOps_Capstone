#!/bin/bash

. ./config.txt
kubectl get services blue-lb -o=yaml | sed -e "s/get-ip-${LAST}/get-ip-${CURRENT}/g" | kubectl apply -f -