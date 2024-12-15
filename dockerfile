FROM ubuntu as intermediate

ARG REPO
ENV REPO $REPO
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git
COPY ./script.sh /
# docker build -t docker-node-testing --build-arg REPO=https://github.com/moojor224/jstools .