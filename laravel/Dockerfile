FROM php:7.4-cli

# sets a working directory
WORKDIR /var/www

# update apt-get package references,
# installs lbzip-dev that will be used in a further RUN command and install 
# installs the zip php extension
RUN apt-get update && \
    apt-get install libzip-dev -y && \
    docker-php-ext-install zip

# sets up the composer package manager for php
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');"

# installs and create a laravel php project
RUN php composer.phar create-project --prefer-dist laravel/laravel laravel

# runs php laravel/artisan serve. Artisan is the command line interface included with Laravel
ENTRYPOINT [ "php", "laravel/artisan", "serve" ]

# sets host as localhost by default, instead of 127.0.0.1, which wouldn't be accessible outside the container
CMD [ "--host=0.0.0.0" ]