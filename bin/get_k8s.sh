#!/bin/bash

cat ~/.kube/config | base64 -w 0
