FROM alpine:3.6

MAINTAINER Lutz Selke <ls@hfci.de>

RUN apk add --update openssh curl docker

ADD scripts/* /usr/local/bin/

RUN chmod +x /usr/local/bin/install-ssh-key /usr/local/bin/post-telegram-message /usr/local/bin/trust-host
RUN PATH="/usr/local/bin:$PATH"
