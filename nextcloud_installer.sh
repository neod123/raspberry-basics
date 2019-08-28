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




########## 2. install nextcloud ##########
cd /var/www
wget https://download.nextcloud.com/server/releases/latest.tar.bz2
tar -xvf latest.tar.bz2
rm latest.tar.bz2*
adduser --disabled-password --gecos "" nextcloud
chown -R nextcloud:www-data /var/www/nextcloud
chmod -R o-rwx /var/www/nextcloud



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

########## create the database ##############
echo "4.3.==> Create the DB"
echo "Provide password for the new database:"
read PASSWORD

wget https://github.com/neod123/raspberry-basics/new/master/nextcloud_config/nextcloud.sql
sed -i 's/m_password/$PASSWORD/g' nextcloud.sql

echo "Connect to MariaDb: please provide the main mariaDb password !!!"
mysql -u root -p < nextcloud.sql 


#
echo "5.==> setup domain name"
rm /etc/nginx/sites-available/nextcloud 
wget  https://github.com/neod123/raspberry-basics/new/master/nextcloud_config/nextcloud -P /etc/nginx/sites-available/ 

echo "Domain to set:"
read my_domain
sed -i -e 's/cloud.mondomaine.com/$my_domain/g' /etc/nginx/sites-available/nextcloud 


ln -s /etc/nginx/sites-available/nextcloud /etc/nginx/sites-enabled/nextcloud
systemctl restart nginx.service
systemctl restart php7.3-fpm.service


echo "6.==> setup certificat"
apt-get install -y software-properties-common
add-apt-repository ppa:certbot/certbot -y
apt-get update
apt-get install -y certbot
certbot certonly --webroot -w /var/www/nextcloud --agree-tos --no-eff-email --email email@mondomaine.com -d $my_domain --rsa-key-size 4096

cronjob="0 */12 * * * root test -x /usr/bin/certbot -a \! -d /run/systemd/system && perl -e 'sleep int(rand(3600))' && certbot -q renew
"
(crontab -u root -l; echo "$cronjob" ) | crontab -u root -


echo "7.==> Optimisation"

echo "7.1.==> Timeout"
echo "\nrequest_terminate_timeout = 300" >> /etc/php/7.3/fpm/pool.d/nextcloud.conf
systemctl restart nginx.service
systemctl restart php7.3-fpm.service



echo "7.2.==> Cache PHP"
echo "opcache.enable=1
opcache.enable_cli=1
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=10000
opcache.memory_consumption=128
opcache.save_comments=1
opcache.revalidate_freq=1"  >> /etc/php/7.3/fpm/php.ini


echo "7.3.==> Redis"
echo "Set the folder (/media/Hard_Drive):"
read my_data_dir
rm /var/www/nextcloud/config/config.php
wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/nextcloud_config/config.php -P /var/www/nextcloud/config/
sed -i -e 's/MY_DOMAIN/$my_domain/g' /var/www/nextcloud/config/
sed -i -e 's/MY_DATA_DIR/$my_data_dir/g' /var/www/nextcloud/config/
sed -i -e 's/MY_PASSWORD/$my_password/g' /var/www/nextcloud/config/

echo "8.==> Test it:"


