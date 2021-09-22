## Cloud DevOps Engineer capstone project

[![CircleCI](https://circleci.com/gh/plj611/c5/tree/master.svg?style=svg)](https://circleci.com/gh/plj611/c5/tree/master)

### Project introduction

This [Udacity course](https://www.udacity.com/course/cloud-dev-ops-nanodegree--nd9991) capstone project operationalize a simple Python/Flask app which will return the status and the version of it in json format. It demonstrates the blue-green deployment and uses [CircleCI](https://circleci.com/) to build and deploy the app into AWS EKS (Amazon Elastic Kubernetes Service)

This project has workflow defined in CircleCI to
- Lint and build the app image after code commit
- Push image into DockerHub
- Promote to production if app passes smoke test. Uses blue-green deployment strategy to promote app into production

The jobs and tasks pipeline defined in CircleCI can be visualized in the following picture

![pipleline.jpg](https://github.com/plj611/c5/blob/master/images/pipeline.jpg?raw=true "pipeline")

The blue-green deployment is described in the following picture

![bluegreen](https://user-images.githubusercontent.com/30945062/134278718-e217955c-9012-4637-89c8-f0e5c29402eb.jpg)

![bluegreen.jpg](https://github.com/plj611/c5/blob/master/images/bluegreen.jpg?raw=true "bluegreen")

### Setup

Since the project is going to demonstrate the blue-green deployment strategy, an initial blue environment must be setup

To setup the initial blue environment
- Install eksctl, kubectl and aws-iam-authenticator
- Execute 'bin/create_cluster.sh' to create Kubernetes cluster in AWS EKS
- Execute 'bin/setup_first_k8s_app.sh' to setup the blue environment (blue app and blue load balancer)

To use CircleCI as a CI/CD platform, this project must be followed in CircleCI and setup the following environment variables
- AWS_ACCESS_KEY_ID
- AWS_DEFAULT_REGION
- AWS_SECRET_ACCESS_KEY
- DOCKER_LOGIN
- DOCKER_PASSWORD
- KUBECONFIG_DATA

### How to opperationalize the app

1. Perform application development and code change
2. Modify the CURRENT, LAST variables in config.txt in root directory of the app. **CURRENT represents the version going to be released, LAST represents the previous version of the app with respect to this release (ie CURRENT)**
3. Commit the code change and push to github

### Project files description

- Makefile: contains commands to prepare the virtual environment, install dependencies and lint the build files
- app.py: the simple Flask app
- Dockerfile: contains instructions on how to containerize the microservice
- requirements.txt: dependencies for app.py
- config.txt: contains setup variables for the app
- bin/build_docker.sh: build the image of CURRENT version of the app
- bin/build_push_first_docker.sh: build and push the blue app into DockerHub
- bin/create_cluster.sh: create the EKS k8s cluster
- bin/del_current_app.sh: delete the CURRENT version of app in k8s cluster (GREEN candidate)
- bin/del_green_lb.sh: delete the green load balancer
- bin/del_last_app.sh: delete the LAST version of app in k8s cluster
- bin/deploy_green_app.sh: deploy the CURRENT version of app in k8s cluster (GREEN candidate)
- bin/deploy_green_lb.sh: deploy the green load balancer
- bin/get_k8s.sh: get the base64 string of the k8s cluster configuration. The string is used to setup KUBECONFIG_DATA in CircleCI
- bin/promote_app.sh: promote the CURRENT version of app (CREEN candidate) to Production 
- bin/push_docker.sh: push the CURRENT version of app (GREEN candidate) image to DockerHub
- bin/setup_first_k8s_app.sh: setup the BLUE environment