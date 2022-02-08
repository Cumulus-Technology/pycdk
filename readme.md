# CDK Python Docker Image

## Workstation Setup

### Bash Profile Script

Add env bash script to .profile or .bashrc Example:

``` . ~/docker-pycdk/cdk-bash.sh```
### AWS SSO Setup

Only needed once per workstation. Follow "Automatic configuration" instructions.  Repeat for each profile.

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html


### Docker Tag

Perform the following initially, then periodically to use the "active" cdk version. You must be logged in to AWS (see below).

```
./update-pycdk.sh
```

## AWS Account Setup - One Time
### CloudFormation - ECR

Create the docker repository with ecr.yaml.  This only needs to be executed once in the dev environment.

```$ aws cloudformation create-stack --stack-name pycdk-ecr --template-body file://ecr.yaml --profile cos-sso-dev```

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

TODO: Create Jenkins Build Job
### Manual Image Build

```
$ cd docker-pycdk
$ aws ecr get-login-password --region us-west-2 --profile college-sso-dev | docker login --username AWS --password-stdin $ECR
$ docker build . -t $ECR/pycdk:1.86.0 -t $ECR/pycdk:latest --build-arg CDK_VERSION=1.86.0
$ docker push $ECR/pycdk:1.86.0
$ docker push $ECR/pycdk:latest
```




