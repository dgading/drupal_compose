FROM php:7.1-apache

RUN apt-get update && apt-get install -yqq --no-install-recommends \
  rsyslog \
  supervisor \
  cron \
  mysql-client \
  libpng-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libpng12-dev \
  locales \
  git \
  ca-certificates \
  && a2enmod rewrite \
  && a2enmod expires \
  && a2enmod headers \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install mysqli pdo_mysql zip mbstring gd exif pcntl opcache \
  && pecl install apcu xdebug \
  && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini \
  && apt-get clean autoclean && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php \
        && mv composer.phar /usr/local/bin/ \
        && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

COPY ./drupal /var/www/html
WORKDIR /var/www/html
RUN composer install --prefer-source --no-interaction && \
    chown -R www-data:www-data web/sites web/modules web/themes
ENV PATH="~/.composer/vendor/bin:../vendor/bin:${PATH}"

WORKDIR /var/www/html/web
