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

 1. Change directories to an existing PyCDK project if you have one.
 2. Source the cdk-bash.sh script either by starting a new bash console or a command like:  ```source ~/pycdk/cdk-bash.sh```
 3. Use the following aws cli command to configure each of your AWS SSO profiles.

    ```$ aws configure sso```

How do I know what SSO profile to create?  
 - The profile can be controlled per project by the cdk_ver.sh script.  See the following section below: Managing PyCDK Projects

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

```$ aws sso login```

Optional Verify SSO

```$ aws sts get-caller-identity```

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

## Managing PyCDK Projects 

### Cloning and creating new PyCDK Projects

See Cheat Sheet section below.

### Managing CDK version and SSO Profile per Project

To control the CDK version and AWS Auth (SSO) per project, a PyCDK project should have this file in the root of the project folder: ```cdk_ver.sh``` If this file does not already exist, you can copy the sample file from this project folder:

```examples/cdk_ver.sh```

Change the PYCDKVER value to control the CDK version used for the project.

 - To experiment with new versions, you can use the following.  This will only persist for the bash session. 

        ```export PYCDKVER=2.12.0```

Change the AWS_PROFILE value to the AWS profile name you wish to use for the project. The profile(s) will need to be created once per workstation.  See step 3 above for the command.

 - PRO TIP: If you have used the CDK bootstrap command to allow assume role to another account, you can use a single profile to manage many cdk projects across accounts. 


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

## AWS Account Setup - No Longer Used
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




