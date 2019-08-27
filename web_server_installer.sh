#!/bin/bash

# wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/web_server_installer.sh | sh web_server_installer.sh | rm web_server_installer.sh

apt-get install software-properties-common -y
add-apt-repository ppa:ondrej/php
add-apt-repository ppa:ondrej/nginx
apt update



if [ -f /etc/nginx/nginx.conf ]
then
    echo "==> 1. Nginx already installed"
else 
  echo "==> 1. Install Nginx"
  apt-get install nginx -y
  sudo systemctl stop nginx.service
  sudo systemctl start nginx.service
  sudo systemctl enable nginx.service
fi



if [ -f /usr/bin/mariadb ]
then
    echo "==> 2.3.. MariaDb already installed"
else 

  echo "2.==> install MariaDb"
  sudo apt-get install mariadb-server mariadb-client -y
  sudo systemctl stop mariadb.service
  sudo systemctl start mariadb.service
  sudo systemctl enable mariadb.service

  echo "3.==> Secure MariaDb"
  sudo mysql_secure_installation

  sudo systemctl stop mariadb.service
  sudo systemctl start mariadb.service
  sudo systemctl enable mariadb.service
fi




if [ -f /usr/bin/php7.3 ]
then
  echo "4.==> PHP7.3 already installed"
else

  echo "4.==> Install PHP7.3"
  apt install php7.3-fpm php7.3-common php7.3-mbstring php7.3-xmlrpc php7.3-soap php7.3-gd php7.3-xml php7.3-intl php7.3-mysql php7.3-cli php7.3-zip php7.3-curl -y
  service php7.3-fpm reload
fi

echo "<?php phpinfo() ?>" > /var/www/html/index.php
echo "5.==> test: http://localhost/index.php"
