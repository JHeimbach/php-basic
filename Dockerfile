FROM php:7.2-fpm

RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		libpng-dev \
		ca-certificates \
		curl \
		git \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-install -j$(nproc) mcrypt \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-install pdo_mysql json opcache zip

ARG PHP_INI=./php.ini

COPY $PHP_INI ${PHP_INI_DIR}/php.ini