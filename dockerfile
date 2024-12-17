FROM ubuntu:22.04 AS intermediate

ARG REPO
ENV REPO $REPO
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git curl wget
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN . ~/.bashrc && \
    nvm install 22
RUN . ~/.bashrc && node -v && npm -v

COPY ./script.sh /
COPY ./start.sh /
COPY ./js /app/js

RUN chmod +x /script.sh
RUN chmod +x /start.sh

# enable ssh
# RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN wget -O gitea https://dl.gitea.com/gitea/1.22.6/gitea-1.22.6-linux-amd64
RUN adduser \
    --system \
    --shell /bin/bash \
    --gecos 'Git Version Control' \
    --group \
    --disabled-password \
    --home /home/git \
    git
RUN apt install -y systemctl
RUN mkdir -p /var/lib/gitea/{custom,data,log}
RUN chown -R git:git /var/lib/gitea/
RUN chmod -R 750 /var/lib/gitea/
RUN mkdir /etc/gitea
RUN chown root:git /etc/gitea
RUN chmod 770 /etc/gitea
RUN cp gitea /usr/local/bin/gitea
COPY ./gitea/gitea.service /etc/systemd/system/gitea.service
RUN chown git:git /etc/systemd/system/gitea.service
RUN chown git:git /usr/local/bin/gitea
RUN chmod +x /usr/local/bin/gitea
# RUN su git -c "/usr/local/bin/gitea web"
RUN systemctl enable gitea
RUN systemctl start gitea
RUN chmod 750 /etc/gitea
RUN chown git:git /etc/gitea
RUN echo "systemctl enable gitea && systemctl start gitea" >> /etc/rc.local
# RUN chmod 640 /etc/gitea/app.ini

# service ssh start

# docker build -t docker-node-testing .