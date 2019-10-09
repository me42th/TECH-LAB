# INSTALAÇÃO

```
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');
sudo chmod +x composer.phar
sudo mv composer.phar /usr/local/bin/composer
```