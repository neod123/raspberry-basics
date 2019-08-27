#!/bin/bash

# wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/nextcloud_installer.sh | sh nextcloud_installer.sh |  rm  nextcloud_installer.sh


apt update


########## install Nginx ##############
if [ -f /etc/nginx/nginx.conf ]
then
    echo "1.==> Nginx already installed"
else 
  echo "1.==> Install Nginx"
  apt-get install nginx -y
  sudo systemctl stop nginx.service
  sudo systemctl start nginx.service
  sudo systemctl enable nginx.service
fi




2. install nextcloud




########## install PHP 7.3 ##############
if [ -f /usr/bin/php7.3 ]
then
  echo "3.==> PHP7.3 already installed"
else

  echo "3.==> Install PHP7.3"
  apt install php7.3-fpm php7.3-common php7.3-mbstring php7.3-xmlrpc php7.3-soap php7.3-gd php7.3-xml php7.3-intl php7.3-mysql php7.3-cli php7.3-zip php7.3-curl -y
  service php7.3-fpm reload
fi

rm /etc/nginx/sites-available/default
wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/web_server_config/default -P  /etc/nginx/sites-available/
service nginx restart




########## install MariaDb ##############
if [ -f /usr/bin/mariadb ]
then
    echo "4.==> MariaDb already installed"
else 

  echo "4.1==> install MariaDb"
  sudo apt-get install mariadb-server mariadb-client -y
  sudo systemctl stop mariadb.service
  sudo systemctl start mariadb.service
  sudo systemctl enable mariadb.service

  echo "4.2==> Secure MariaDb"
  sudo mysql_secure_installation

  sudo systemctl stop mariadb.service
  sudo systemctl start mariadb.service
  sudo systemctl enable mariadb.service
fi

5. setup domain name

6. setup certificat

7. Optimisation
7.1 timeout
7.2 cache PHP
7.3 Redis


