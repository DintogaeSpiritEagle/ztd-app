FROM php:7-fpm AS base

RUN apt update && apt install -y zlib1g-dev libpng-dev git zip

RUN docker-php-ext-install exif gd pdo_mysql

FROM base AS dev

RUN apt update && apt install -y nano nodejs npm
RUN npm install n -g && n stable
COPY --from=composer /usr/bin/composer /usr/bin/composer

FROM base AS build-fpm

WORKDIR /var/www/html

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY /composer.json composer.json
COPY . /var/www/html
RUN composer install --no-dev
RUN composer dump-autoload -o

RUN chmod 777 -R .

#FROM build-fpm AS test

#RUN make test

FROM build-fpm AS fpm

COPY --from=build-fpm /var/www/html /var/www/html
COPY . /var/www/html

FROM node:latest AS assets-build

WORKDIR /code
COPY . /code
RUN npm ci
RUN npm run dev

FROM build-nginx AS nginx

COPY ./build/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=assets-build /code/public/ /var/www/html/
