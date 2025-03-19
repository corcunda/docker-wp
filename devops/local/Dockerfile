FROM php:8.1-fpm-alpine

# Install dependencies for PHP extensions
RUN apk add --no-cache \
    libjpeg-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libxpm-dev \
    freetype-dev \
    libzip-dev \
    oniguruma-dev \
    imagemagick-dev \
    icu-dev \
    libxml2-dev \
    g++ \
    make \
    autoconf \
    bash \
    linux-headers

# Install required PHP extensions
RUN docker-php-ext-install \
    gd \
    exif \
    intl \
    mysqli \
    pdo \
    pdo_mysql \
    zip \
    opcache

# Enable extensions
RUN docker-php-ext-enable \
    exif \
    opcache

# Install Imagick via PECL
RUN pecl install imagick && docker-php-ext-enable imagick

# Install Xdebug via PECL
RUN pecl install xdebug-3.1.1 && docker-php-ext-enable xdebug

COPY devops/local/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Expose PHP-FPM port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]

