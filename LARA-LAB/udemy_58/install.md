# INSTALL STUFF | [VOLTAR](./readme.md)

## PHP, MYSQL, APACHE
```
sudo apt update

sudo apt install apache2

sudo apt install curl git unzip -y

sudo apt install php7.2 libapache2-mod-php7.2 php7.2-mbstring php7.2-xmlrpc php7.2-soap php7.2-gd php7.2-xml php7.2-cli php7.2-zip

sudo apt install msql-server-5.7 php-mysql php7.2-mysql mysql-client-core5.7 -y

sudo mysql_secure_instalation

sudo mysql

grant all privileges on *.* to 'user'@'localhost' identified by 'user';

flush privileges;

quit;

sudo -i;

curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

composer --version

composer global require laravel/installer

nano ~/.bashrc

gedit ~/.bashrc
```

## REDIS
```
https://repogen.simplylinux.ch/generate.php

sudo add-apt-repository ppa:chris-lea/redis-server

sudo apt install redis-server

sudo nano /etc/redis/redis.conf
    supervised no >> supervised systemd

sudo systemctl restart redis 
```

**EXTENSIONS**
```
> dotenv
> Laravel 5 Snippets
> Laravel Blade Snippets
> PHP Intelephense
```