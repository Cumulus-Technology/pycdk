# Docker CDK Bash Env Setup
# Add to .profile or .bashrc Example:
#  . ~/docker-pycdk/cdk-bash.sh
alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli' 
alias pycdk='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/proj pycdk:active' 
alias cdk='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/proj pycdk:active cdk' 
alias cdkpip='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/proj pycdk:active pip' 