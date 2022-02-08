# Docker CDK Bash Env Setup
# Add to .profile or .bashrc Example:
#  . ~/docker-pycdk/cdk-bash.sh
ECR='421327123456.dkr.ecr.us-west-2.amazonaws.com'
export ECR
alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli' 
alias pycdk='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/proj $ECR/pycdk:active' 
alias cdk='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/proj $ECR/pycdk:active cdk' 
alias cdkpip='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/proj $ECR/pycdk:active pip' 
