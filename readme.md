# CDK Python Docker Image

## Setup

### Bash Profile Script

Add env bash script to .profile or .bashrc Example:

``` . ~/docker-pycdk/cdk-bash.sh```

### Docker Tag

You must tag an image as "active" in order to determine which version of the cdk to use.

```
docker pull cumulusmike/pycdk:1.86.0
docker tag cumulusmike/pycdk:1.86.0 cumulusmike/pycdk:active
```

### AWS SSO Setup

Only needed once per workstation. Follow "Automatic configuration" instructions.  Repeat for each profile.

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html

## Usage

### Initial Login

Must be performed once per session.

```$ aws sso login --profile client-dev```

Optional Verify SSO

```$ aws sts get-caller-identity --profile client-dev```

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

1. Update Dockerfile and commit changes to master branch. A build for "latest" will automatically start in Dockerhub.
2. Create a version tag in Github and a version build/tag will automatically start in Dockerhub.
### Manual Image Build

```
$ cd docker-pycdk
$ docker build . -t cumulusmike/pycdk:1.86.0 -t cumulusmike/pycdk:latest --build-arg CDK_VERSION=1.86.0
$ docker push cumulusmike/pycdk:1.86.0
$ docker push cumulusmike/pycdk:latest
```