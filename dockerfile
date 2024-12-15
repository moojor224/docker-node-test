FROM ubuntu AS intermediate

ARG REPO
ENV REPO $REPO
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# ENV NVM_DIR $HOME/.config/nvm
# RUN bash $NVM_DIR/nvm.sh && $NVM_DIR/nvm.sh && \
#     [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
#     nvm install 22

COPY ./script.sh /
COPY ./start.sh /
# docker build -t docker-node-testing .