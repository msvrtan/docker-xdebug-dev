FROM phusion/baseimage:latest

RUN DEBIAN_FRONTEND=noninteractive
RUN locale-gen en_US.UTF-8

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm

# 
RUN apt-get update 

# Install PHP-CLI 7, some PHP extentions and some useful Tools with APT
RUN apt-get install -y \
        mysql-client \
        php7.0-mysql \
        php7.0-cli \
        php7.0-common \
        php7.0-curl \
        php7.0-json \
        php7.0-xml \
        php7.0-mbstring \
        php7.0-mcrypt \
        php7.0-zip \
        php-memcached \
        php7.0-bcmath \
        php-mongodb

RUN apt-get install -y \
        php-xdebug

# Install additional tools
RUN apt-get install -y \
        git \
        curl \
        joe

# Add a symbolic link for Node
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Add convenience aliaseses
RUN echo "alias phpunit='./bin/phpunit'" >> ~/.bashrc
RUN echo "alias phpspec='./bin/phpspec'" >> ~/.bashrc
RUN echo "alias behat='./bin/behat'" >> ~/.bashrc
RUN echo 'alias sf="bin/console"' >> ~/.bashrc
RUN echo 'alias cc="bin/console cache:clear"' >> ~/.bashrc

# Install Composer
RUN curl -s http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/ \
    && echo "alias composer='/usr/local/bin/composer.phar'" >> ~/.bashrc

# Source the bash
RUN . ~/.bashrc

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www
