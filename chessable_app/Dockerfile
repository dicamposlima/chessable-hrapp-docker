FROM ubuntu:20.04

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y software-properties-common 
RUN apt-get install -y wget curl nano htop git unzip bzip2 software-properties-common locales

ENV TERM=xterm

WORKDIR /var/www/html

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt update
RUN apt-get install -y \
    php7.4\
    php7.4-fpm \ 
    php7.4-common \ 
    php7.4-curl \ 
    php7.4-mysql \ 
    php7.4-mbstring \ 
    php7.4-json \
    php7.4-xml \
    php7.4-bcmath \
    php7.4-gd \
    libmcrypt-dev \
    php7.4-zip \
    php7.4-soap

RUN apt-get update && apt-get install -y libpng-dev
RUN apt-get install -y \
    libwebp-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev \
    php7.4-mcrypt

# Config fpm to use TCP instead of unix socket
ADD www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN mkdir -p /var/run/php

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Nginx
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
RUN echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y nginx

ADD chessable_app /etc/nginx/sites-enabled/

ADD nginx.conf /etc/nginx/

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose port 80
EXPOSE 8080

# Set supervisor to manage container processes
ENTRYPOINT ["/usr/bin/supervisord"]
