FROM php:apache

COPY ./php.ini /usr/local/etc/php/php.ini

RUN apt-get update \
&& apt-get install -y libonig-dev libzip-dev unzip locales\

&& sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen \
&& locale-gen \
&& update-locale LANG=ja_JP.UTF-8 \

&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \

&& docker-php-ext-install pdo_mysql mbstring zip bcmath\
&& pecl install xdebug\
&& docker-php-ext-enable xdebug

ENV LC_ALL ja_JP.UTF-8

## ドキュメントルートを変更する
RUN sed -ri -e 's!/var/www/html!${DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf

RUN echo 'ServerName localhost' | tee /etc/apache2/conf-available/fqdn.conf
RUN a2enconf fqdn

