#!/bin/sh

# Переходим в рабочую директорию
cd /var/www/html

# Проверяем, установлен ли WordPress
if [ ! -f wp-config.php ]; then
  # Скачиваем WordPress
  curl -O https://wordpress.org/latest.tar.gz
  tar -xzf latest.tar.gz --strip-components=1
  rm latest.tar.gz

  # Настраиваем wp-config.php
  cp wp-config-sample.php wp-config.php
  sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/g" wp-config.php
  sed -i "s/username_here/${WORDPRESS_DB_USER}/g" wp-config.php
  sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/g" wp-config.php
  sed -i "s/localhost/${WORDPRESS_DB_HOST}/g" wp-config.php

  # Устанавливаем правильные права доступа
  chown -R www-data:www-data /var/www/html
  chmod -R 755 /var/www/html
fi

# Запускаем PHP-FPM
exec php-fpm
~                                                                                                                                                                                             
~              
