#!/bin/bash
# Log in to ECR and pull active pycdk image
docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli ecr get-login-password --region us-west-2 --profile college-sso-dev | docker login --username AWS --password-stdin $ECR
docker pull $ECR/pycdk:active