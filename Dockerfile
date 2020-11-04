FROM python:3.9-alpine

LABEL maintainer="mike@cumulustech.us"
LABEL cdk_version=1.71.0

#Setup
RUN mkdir /proj
WORKDIR /proj
RUN apk -U --no-cache add \
    bash \
    git \
    curl \
    nodejs \
    npm &&\
    rm -rf /var/cache/apk/*

#Python virtual env
RUN python -m pip install --upgrade virtualenv
ENV VIRTUAL_ENV=/proj/.env
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

#node and cdk
RUN npm install -g aws-cdk@1.71.0

#Matt's CDK SSO Plugin https://www.npmjs.com/package/cdk-cross-account-plugin
RUN npm i -g cdk-cross-account-plugin aws-sdk

CMD ["/bin/bash"]