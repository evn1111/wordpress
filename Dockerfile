# Используем официальный образ PHP 8.2 FPM
FROM php:8.2-fpm

# Устанавливаем необходимые зависимости и модули PHP
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    curl \
    && docker-php-ext-install pdo_mysql mysqli zip exif gd

# Устанавливаем Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Копируем скрипт для установки WordPress
COPY install-wordpress.sh /usr/local/bin/install-wordpress.sh
RUN chmod +x /usr/local/bin/install-wordpress.sh

# Устанавливаем рабочую директорию
WORKDIR /var/www/html

# Запускаем скрипт при старте контейнера
CMD ["sh", "-c", "/usr/local/bin/install-wordpress.sh && php-fpm"]
