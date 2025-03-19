FROM php:8.4-fpm-alpine

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
    linux-headers \
    git

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
# RUN pecl install imagick && docker-php-ext-enable imagick
# RUN pecl install imagick-3.7.0 && docker-php-ext-enable imagick
# Install Imagick via source
RUN git clone https://github.com/Imagick/imagick --depth 1 /tmp/imagick \
    && cd /tmp/imagick \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf /tmp/imagick

# Enable the Imagick PHP extension
RUN docker-php-ext-enable imagick

# Install Xdebug via PECL
RUN pecl install xdebug-3.1.1 && docker-php-ext-enable xdebug

# Copy custom Xdebug config
COPY devops/local/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Expose PHP-FPM port
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]

