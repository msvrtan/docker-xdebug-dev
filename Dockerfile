FROM phusion/baseimage:latest

RUN DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

#add repo with newest PHP versions
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
# 
RUN apt-get update 

# Install PHP 7.1, some PHP extentions and some useful Tools with APT
RUN apt-get install -y \
        acl \
        mysql-client \
        php7.1-bcmath \
        php7.1-cli \
        php7.1-common \
        php7.1-curl \
        php7.1-gd \
        php7.1-intl \
        php7.1-json \
        php7.1-mbstring \
        php7.1-mcrypt \
        php7.1-mysql \
        php7.1-pgsql \
        php7.1-xml \
        php7.1-zip \
        php-imagick \
        php-memcached \
        php-mongodb \
        php-redis \
        php-zip

RUN apt-get install -y \
        php-xdebug

# Install additional tools
RUN apt-get install -y \
        git \
        curl \
        joe

# Add a symbolic link for Node
#RUN ln -s /usr/bin/nodejs /usr/bin/node

# Add convenience aliaseses
RUN echo "alias phpunit='./bin/phpunit'" >> ~/.bashrc
RUN echo "alias phpspec='./bin/phpspec'" >> ~/.bashrc
RUN echo "alias behat='./bin/behat'" >> ~/.bashrc
RUN echo 'alias sf="bin/console"' >> ~/.bashrc
RUN echo 'alias cc="bin/console cache:clear"' >> ~/.bashrc

# Install Composer
RUN curl -s http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer 

# Source the bash
RUN . ~/.bashrc

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www
