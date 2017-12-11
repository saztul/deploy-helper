FROM alpine:3.6

LABEL maintainer="Lutz Selke <ls@hfci.de>"

# basics
RUN apk add --update openssh curl docker rsync lftp bash

# NPM / Webpack support
RUN apk add --update \
        nodejs nodejs-npm build-base zlib-dev \
        autoconf automake libtool nasm libpng-dev

# PHP support
RUN curl https://php.codecasts.rocks/php-alpine.rsa.pub > /etc/apk/keys/php-alpine.rsa.pub && \
    echo "http://php.codecasts.rocks/v3.6/php-7.1" >> /etc/apk/repositories && \
    apk add --update openssl git php7 php7-mbstring php7-openssl php7-phar php7-json php7-zlib && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    php --version

# PHP composer support
RUN curl -L https://getcomposer.org/installer > composer-setup.php && \
    php composer-setup.php --filename=composer --install-dir=/usr/local/bin && \
    rm -f composer-setup.php && \
    composer --version

# phpunit
RUN curl -L https://phar.phpunit.de/phpunit.phar > /usr/local/bin/phpunit && \
    chmod +x /usr/local/bin/phpunit && \
    phpunit --version

# fake docker-compose
RUN echo "#\!/bin/sh\necho 'docker-compose not available in deploy conatiner'" > /usr/local/bin/docker-compose

# grunt
RUN npm i -g grunt-cli

ADD scripts/* /usr/local/bin/

RUN mkdir /deploy && \
    chmod +x /usr/local/bin/install-ssh-key \
             /usr/local/bin/post-telegram-message \
             /usr/local/bin/trust-host \
             /usr/local/bin/run-deploy \
             /usr/local/bin/sftp-deploy

WORKDIR /deploy
