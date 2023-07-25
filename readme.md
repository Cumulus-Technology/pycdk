# CDK Python Docker Image


## Workstation Setup

### 1 - Bash Profile Script

Add env bash script to .profile or .bashrc (or .zshenv on a Mac). Example:

``` . ~/pycdk/cdk-bash.sh```

### 2 - Github Access Token

Create a PAT using the following instructions: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

 - Only give this PAT the scope to "Read Packages".

Save your PAT to your home directory as:  ~/.github_pat_pycdk

### 3 - AWS SSO Setup

Use the following aws cli command to configure each of your AWS SSO profiles.

```$ aws configure sso```

__*IMPORTANT!*__

When prompted for "SSO session name" DO NOT supply a session name.  If a name is supplied the pycdk context switching will not recognize the SSO profile.


This step is only needed once per workstation. For more information see: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html


### 4 - Docker Tag

Perform the following initially, then periodically to use the "active" cdk version. You must be logged in to AWS (see below).

```
./update-pycdk.sh
```

---

## Usage

### Initial Login

Must be performed once per session.

```$ aws sso login --profile college-sso-dev```

Optional Verify SSO

```$ aws sts get-caller-identity --profile college-sso-dev```

### Example Inline CDK Commands

```
$ cdk --version
$ pycdk python --version
```

### Interactive CDK Shell

```$ pycdk```

### Pip and installing Packages

Use the following command to install a python package locally:

```cdkpip install --target .python-local [my-package]```

To view installed packages, you can use:

```cdkpip list```

### Change CDK Version

Use the following to change the CDK version.
```export PYCDKVER=2.12.0```

This will only persist for the shell session.  To make a permanent change, edit the cdk-bash.sh script located in your CDK project.

---

## Cheat Sheets

### Existing repo - new clone

```
$ git clone git@github.com:client/cdk-project.git
$ cd cdk-project
$ cdk ls
$ cdk diff
```

### New Python CDK Project From Scracth

```
$ mkdir cdk-project
$ cd cdk-project
$ cdk init --language python
#remove .venv or .env
$ sudo chown mike:mike -R *
$ sudo chown mike:mike -R .*
# Create GitHub repo
$ git remote add origin git@github.com:client/cdk-project.git
$ git push --set-upstream origin master
```

## Maintenance

### Automated Image Build

Build instructions are located in the workflows directory. Cumulus maintains current docker images in the Github Pacakge: ghcr.io/cumulus-technology/pycdk:latest 

## AWS Account Setup - One Time
### CloudFormation - ECR

Create the docker repository with ecr.yaml.  This only needs to be executed once in the dev environment.

```$ aws cloudformation create-stack --stack-name pycdk-ecr --template-body file://ecr.yaml --profile cos-sso-dev```

### Manual Image Build (AWS)

The following instructions were used to host in AWS but are no longer used.

```
$ cd docker-pycdk
$ aws ecr get-login-password --region us-west-2 --profile college-sso-dev | docker login --username AWS --password-stdin $ECR
$ docker build . -t $ECR/pycdk:1.86.0 -t $ECR/pycdk:latest --build-arg CDK_VERSION=1.86.0
$ docker push $ECR/pycdk:1.86.0
$ docker push $ECR/pycdk:latest
```




