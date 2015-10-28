FROM php:5.5-fpm

MAINTAINER Dmitry Averbakh <adm@ruhub.com>

RUN apt-get update && apt-get install -y libicu-dev zlib1g-dev libmcrypt-dev libcurl4-gnutls-dev libxml2-dev \

    && curl -L -o /tmp/xdebug-2.3.3.tgz http://xdebug.org/files/xdebug-2.3.3.tgz \
    && curl -L -o /tmp/apcu-4.0.7.tgz https://pecl.php.net/get/apcu-4.0.7.tgz \
    && tar xfz /tmp/xdebug-2.3.3.tgz \
    && tar xfz /tmp/apcu-4.0.7.tgz \
    && rm -r /tmp/xdebug-2.3.3.tgz /tmp/apcu-4.0.7.tgz \
    && mv xdebug-2.3.3 /usr/src/php/ext/xdebug \
    && mv apcu-4.0.7 /usr/src/php/ext/apcu \

    && docker-php-ext-install apcu intl mbstring mysql xdebug zip iconv mcrypt mbstring curl json soap \

    && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

ADD php.ini /usr/local/etc/php/conf.d/fly.ini

WORKDIR /var/www/symfony

EXPOSE 9876
