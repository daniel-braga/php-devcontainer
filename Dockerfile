FROM php:7.4.23-fpm-alpine

RUN apk --update add --no-cache git libjpeg-turbo-dev libwebp-dev zlib-dev libxpm-dev libpng libpng-dev icu icu-dev autoconf \
    gcc musl-dev make libxml2-dev openssl-dev \
    && docker-php-ext-install gd intl mysqli pdo_mysql xml soap \
    && pecl install mongodb \
    && pecl install xdebug \
    && docker-php-ext-enable mongodb xdebug \
    && docker-php-source delete \
    && apk del libjpeg-turbo-dev libwebp-dev zlib-dev libxpm-dev libpng-dev icu-dev autoconf gcc musl-dev make libxml2-dev openssl-dev \
    && rm -rf /tmp/pear/download/*

COPY --from=composer /usr/bin/composer /usr/bin/composer

EXPOSE 8080