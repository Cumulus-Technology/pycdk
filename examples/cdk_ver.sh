#Use this script to set the CDK version to use with this project
# Command: source cdk_ver.sh

#version of PyCDK image (CDK version) to use
export PYCDKVER=2.90.0
echo "PYCDK VERSION $PYCDKVER"

#Name of AWS Profile to use with this project for AWS CLI
#This profile needs to be set up once per workstation with the command: $ aws configure sso
export AWS_PROFILE=ct-sso-asaas-cda
echo "AWS PROFILE $AWS_PROFILE"