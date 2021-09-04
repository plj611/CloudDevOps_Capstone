#!/bin/bash

eksctl create cluster \
--name cap1 \
--region us-west-2 \
--with-oidc \
--ssh-access \
--ssh-public-key udacity \
--managed
