FROM alpine:3.6

LABEL maintainer="Lutz Selke <ls@hfci.de>"

# NPM / Webpack support
RUN apk add --update \
        nodejs nodejs-npm build-base zlib-dev \
        autoconf automake libtool nasm libpng-dev

# PHP composer support
RUN curl https://php.codecasts.rocks/php-alpine.rsa.pub > /etc/apk/keys/php-alpine.rsa.pub && \
    echo "http://php.codecasts.rocks/v3.6/php-7.1" >> /etc/apk/repositories && \
    apk add --update openssl git php7 php7-mbstring php7-openssl php7-phar php7-json php7-zlib

ADD scripts/* /usr/local/bin/

RUN apk add --update openssh curl docker rsync lftp && \
    mkdir /deploy && \
    chmod +x /usr/local/bin/install-ssh-key \
             /usr/local/bin/post-telegram-message \
             /usr/local/bin/trust-host \
             /usr/local/bin/run-deploy \
             /usr/local/bin/sftp-deploy \
             /usr/local/bin/sftp-deploy-dry-run

WORKDIR /deploy
