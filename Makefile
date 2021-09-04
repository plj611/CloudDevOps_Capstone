## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv .capstone

install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
		pip install -r requirements.txt
	sudo wget https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64 -O /bin/hadolint
	sudo a+x /bin/hadolint

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203 app.py

aws-iam:
	# Install aws-iam-authenticator
	curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
	chmod +x ./aws-iam-authenticator
	mv ./aws-iam-authenticator /usr/local/bin

build_docker:
	# Build image
	./bin/build_docker.sh

push_docker:
	# Push image
	./bin/push_docker.sh


all: install lint test
