FROM ubuntu as intermediate

ARG REPO
ENV REPO $REPO
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN nvm install 22
COPY ./script.sh /
COPY ./start.sh /
# docker build -t docker-node-testing --build-arg REPO=https://github.com/moojor224/jstools .