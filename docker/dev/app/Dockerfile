FROM php:8.3-apache

RUN echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

RUN apt-get update &&\
    apt-get install -y zip openssl

# php extensions install
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions opcache intl pdo_mysql xdebug

# composer install
RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
    mv composer.phar /usr/local/bin/composer

# symfony-cli install
RUN curl -1sLf https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh | bash - &&\
    apt-get install -y symfony-cli

COPY ./config/php-config.ini /usr/local/etc/php/conf.d/php-config-overrides.ini

WORKDIR /var/www/

ENTRYPOINT ["bash", "./api-scripts.sh", "start-env-dev"]
