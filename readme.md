# CDK Python Docker Image

## Setup

### Image Build

```
$ cd docker-pycdk
$ docker build . -t pycdk:1-72-0 -t pycdk:active -t pycdk:latest
```

### Bash Profile Script

Add env bash script to .profile or .bashrc Example:

``` . ~/docker-pycdk/cdk-bash.sh```

### AWS SSO Setup

Only needed once per workstation. Follow "Automatic configuration" instructions.  Repeat for each profile.

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html

## Usage

### Initial Login

Must be performed once per session.

```$ aws sso login --profile client-dev```

Optional Verify SSO

```$ aws sts get-caller-identity --profile client-dev```

###  Inline CDK Commands

```
$ cdk --version
$ pycdk virtualenv .env
$ cdkpip install -r requirements.txt
```

### Interactive CDK Shell

```$ pycdk```

## Cheat Sheets

### Existing repo - new clone

```
$ git clone git@github.com:cosgiant/cdk-project.git
$ cd cdk-project
$ pycdk virtualenv .env
$ cdkpip install -r requirements.txt
$ cdk ls
$ cdk diff
```


### New Python CDK Project From Scracth

```
$ mkdir cdk-project
$ cd cdk-project
$ cdk init --language python
#remove and recreate .venv > .env
$ cdkpip install -r requirements.txt
$ sudo chown mike:mike -R *
$ sudo chown mike:mike -R .*
# Create GitHub repo
$ git remote add origin git@github.com:cosgiant/cdk-project.git
$ git push --set-upstream origin master
```