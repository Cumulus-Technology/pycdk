FROM python:3

LABEL maintainer="mike@cumulustech.us"
LABEL cdk_version=1.71.0

#Python virtual env
RUN python -m pip install --upgrade virtualenv
ENV VIRTUAL_ENV=/proj/.env
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

#node and cdk
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt install -y nodejs
RUN npm install -g aws-cdk@1.71.0

#Matt's CDK SSO Plugin https://www.npmjs.com/package/cdk-cross-account-plugin
RUN npm i -g cdk-cross-account-plugin aws-sdk

RUN mkdir /proj
WORKDIR /proj

CMD ["/bin/bash"]