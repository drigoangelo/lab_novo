FROM php:7.2-apache

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

COPY ./apache2 /etc/apache2

RUN docker-php-ext-install mysqli pdo pdo_mysql

EXPOSE 80