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

alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli:2.6.1' 
alias pycdk='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/proj -e PYTHONPATH=".python-local" $REGISTRY/pycdk:$PYCDKVER' 
alias cdk='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/proj -e PYTHONPATH=".python-local" $REGISTRY/pycdk:$PYCDKVER cdk' 
alias cdkpip='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/proj -e PYTHONPATH=".python-local" $REGISTRY/pycdk:$PYCDKVER pip' 

echo "Attempt to set pycdk version based on project. If this fails, latest will be used."

if [ -f cdk_ver.sh ]; then
    source cdk_ver.sh
fi

echo "Pycdk Version: $PYCDKVER"
