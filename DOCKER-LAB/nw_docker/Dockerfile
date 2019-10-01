FROM centos:7
MAINTAINER The CentOS Project <cloud-ops@centos.org>
LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum -y --setopt=tsflags=nodocs install epel-release yum-utils && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum -y --setopt=tsflags=nodocs install net-tools && \
    yum-config-manager --disable remi-php54 && \
    yum-config-manager --enable remi-php73 && \
    yum -y install php php-cli php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json && \
    yum clean all && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    php composer.phar create-project laravel/laravel --prefer-dist

EXPOSE 80