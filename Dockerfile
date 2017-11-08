FROM alpine:3.6

LABEL maintainer="Lutz Selke <ls@hfci.de>"

ADD scripts/* /usr/local/bin/

RUN apk add --update openssh curl docker rsync && \
    mkdir /deploy && \
    chmod +x /usr/local/bin/install-ssh-key \
             /usr/local/bin/post-telegram-message \
             /usr/local/bin/trust-host \
             /usr/local/bin/run-deploy

WORKDIR /deploy
