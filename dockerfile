FROM ubuntu AS intermediate

ARG REPO
ENV REPO $REPO
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN . ~/.bashrc && \
    nvm install 22
RUN . ~/.bashrc && node -v && npm -v

COPY ./script.sh /
COPY ./start.sh /
COPY ./js /app/js

RUN chmod +x /script.sh
RUN chmod +x /start.sh
# docker build -t docker-node-testing .