FROM php:8.1-fpm-alpine

#RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql

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
    autoconf

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

# Clean up temporary files to reduce image size
RUN rm -rf /var/cache/apk/*


