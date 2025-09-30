FROM 01e9/ide-in-docker AS php

ARG PHP_VERSION='8.4'
ARG COMPOSER_VERSION='2.8.11'

RUN apt-get update \
    # PHP
    && apt-get install -y \
        php${PHP_VERSION} \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-dev \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-zip \
        php${PHP_VERSION}-sqlite3 \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-pgsql \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-amqp \
        php${PHP_VERSION}-intl \
        php${PHP_VERSION}-redis \
        php-pear \
        && sed -i 's/^;\?\(date\.timezone\) =.*/\1 = "Europe\/Bucharest"/' /etc/php/${PHP_VERSION}/cli/php.ini \
    # Imagick # throws error https://github.com/Imagick/imagick/issues/668
    #&& apt-get install -y libmagickwand-dev \
    #    && pecl install imagick \
    #    && echo "extension=$(find /usr/lib/php -iname imagick.so)" > /etc/php/${PHP_VERSION}/cli/conf.d/20-imagick.ini \
    # Debugger
    && pecl install xdebug \
        && echo "zend_extension=$(find /usr/lib/php -iname xdebug.so)" > /etc/php/${PHP_VERSION}/cli/conf.d/30-xdebug.ini \
        && echo 'xdebug.mode=debug' >> /etc/php/${PHP_VERSION}/cli/conf.d/30-xdebug.ini \
        && echo 'xdebug.client_port=9000' >> /etc/php/${PHP_VERSION}/cli/conf.d/30-xdebug.ini \
        && echo 'xdebug.remote_enable=1' >> /etc/php/${PHP_VERSION}/cli/conf.d/30-xdebug.ini \
        && echo 'xdebug.idekey="docker-ide"' >> /etc/php/${PHP_VERSION}/cli/conf.d/30-xdebug.ini \
    # Composer
    && wget -O /usr/bin/composer "https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar" \
        && chmod +x /usr/bin/composer \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

FROM php

ARG NODEJS_VERSION='22'
ARG NPM_VERSION='11.6.0'
ARG PNPM_VERSION='10.16.1'

RUN apt-get update \
    && (curl -sL "https://deb.nodesource.com/setup_${NODEJS_VERSION}.x" | bash -) \
        && apt-get install -y nodejs \
    && npm install --location=global "npm@${NPM_VERSION}" \
    && npm install --location=global "pnpm@${PNPM_VERSION}" \
    && env SHELL=bash pnpm setup \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*
