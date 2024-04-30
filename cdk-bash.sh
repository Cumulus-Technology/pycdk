# Docker CDK Bash Env Setup
# Add to .profile or .bashrc Example:
#  . ~/pycdk/cdk-bash.sh

#AWS Example
# export REGISTRY='421327123456.dkr.REGISTRY.us-west-2.amazonaws.com'

#Github Example
echo "Github Login"
cat ~/.github_pat_pycdk | docker login ghcr.io -u USERNAME --password-stdin
export REGISTRY='ghcr.io/cumulus-technology'

#Use this env var to control the CDK version. "latest" can be replaced with a version number.
export PYCDKVER=latest

<<<<<<< HEAD
alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli:2.13.3 --profile $AWS_PROFILE' 
=======
alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli:latest --profile $AWS_PROFILE' 
>>>>>>> 5e732e21ed9e57085bcf8bff5c1ea5e65c10028a
alias pycdk='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/proj -e PYTHONPATH=".python-local" $REGISTRY/pycdk:$PYCDKVER' 
alias cdk='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/proj -e PYTHONPATH=".python-local" $REGISTRY/pycdk:$PYCDKVER cdk --profile $AWS_PROFILE' 
alias cdkpip='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/proj -e PYTHONPATH=".python-local" $REGISTRY/pycdk:$PYCDKVER pip' 

echo "Attempt to set pycdk version based on project. If this fails, latest will be used."
source cdk_ver.sh
echo "Pycdk Version: $PYCDKVER"
