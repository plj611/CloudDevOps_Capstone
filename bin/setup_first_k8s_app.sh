
#!/bin/sh

. ./config.txt
# deploy app into k8s
kubectl create deployment get-ip-${LAST} --image=docker.io/${DOCKER_PATH}:${LAST} --replicas=2 --port=80
kubectl rollout status deployment/get-ip-${LAST} # Health check

# setup blue load balancer
kubectl expose deployment get-ip-${LAST} --type=LoadBalancer --port=80 --target-port=8080 --name=blue-lb --save-config

while [ 1 ]
do
   URL=$(kubectl get services blue-lb -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
   if [ ! -z $URL ]
   then
      break
   fi
   echo "waiting for url...\n"
   sleep 1
done
echo $URL