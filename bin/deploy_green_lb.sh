#!/bin/sh

. ./config.txt
kubectl expose deployment get-ip-${CURRENT} --type=LoadBalancer --port=80 --target-port=8080 --name=green-lb --save-config

while [ 1 ]
do
   URL=$(kubectl get services green-lb -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
   if [ ! -z $URL ]
   then
      break
   fi
   echo "waiting for url...\n"
   sleep 1
done
echo $URL
