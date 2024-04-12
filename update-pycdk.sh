#!/bin/bash
docker pull $REGISTRY/pycdk:$PYCDKVER

# AWS ECR and pull active pycdk image
# docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli ecr get-login-password --region us-west-2 --profile college-sso-dev | docker login --username AWS --password-stdin $REGISTRY
# docker pull $REGISTRY/pycdk:active

#Update AWS CLI
docker pull amazon/aws-cli:latest