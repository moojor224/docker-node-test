FROM ubuntu:22.04 AS intermediate

ARG REPO
ENV REPO=$REPO

# update system and install required packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git curl wget systemctl
# install nodejs
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN . ~/.bashrc && \
    nvm install 22
RUN . ~/.bashrc && node -v && npm -v

# download gitea executable
RUN wget -O gitea https://dl.gitea.com/gitea/1.22.6/gitea-1.22.6-linux-amd64

# copy bash scripts
COPY ./script.sh /
COPY ./start.sh /
COPY ./start_gitea.sh /
COPY ./js /app/js
COPY ./gitea/gitea.service /etc/systemd/system/gitea.service

# make bash scripts executable
RUN chmod +x /script.sh
RUN chmod +x /start.sh

# run setup script
RUN . /script.sh

# docker build -t docker-node-testing .