FROM python:3.9-alpine

# Set image labels
LABEL maintainer="mike@cumulustech.us"

# Set build args with defaults
ARG CDK_VERSION=2.12.0

# Setup
RUN mkdir /proj
WORKDIR /proj
RUN apk -U --no-cache add \
    bash \
    git \
    curl \
    nodejs \
    npm &&\
    rm -rf /var/cache/apk/*

# Install essential Python packages
RUN pip install beautifulsoup4 requests

# Query PyPI registry for all installable CDK modules
COPY list-cdk-packages.py .
RUN ./list-cdk-packages.py ${CDK_VERSION} > cdk-requirements.txt &&\
    pip install -r cdk-requirements.txt

# AWS CDK, AWS SDK
RUN npm i -g aws-cdk@${CDK_VERSION} aws-sdk

# Install additional Python packages
# (this is positioned here to take advantage of layer caching)
RUN pip install Jinja2 stringcase boto3

# Configure Python bytecode behavior
ENV PYTHONDONTWRITEBYTECODE=true
ENV PYTHONPYCACHEPREFIX=/tmp/__pycache__

# Set default run command
CMD ["/bin/bash"]
