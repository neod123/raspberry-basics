#!/bin/bash

# /gogs_installer.sh | sh gogs_installer.sh |  rm  gogs_installer.sh


if [ -f / ]
then
    echo "==> 1. 2. Mariadb already installed"
 else   
    echo "1.==> install MariaDb"
    apt-get install mariadb-server mariadb-client -y
    systemctl stop mariadb.service
    systemctl start mariadb.service
    systemctl enable mariadb.service

    echo "2.==> Secure MariaDb"
    mysql_secure_installation

    systemctl stop mariadb.service
    systemctl start mariadb.service
    systemctl enable mariadb.service

fi


echo "3.==> Install git"
sudo apt-get install git -y

echo "4.==> install gogs"
cd /opt
sudo wget https://dl.gogs.io/0.11.53/gogs_0.11.91_raspi_armv7.zip
sudo unzip gogs_0.11.91_raspi_armv7.zip
sudo rm gogs_0.11.91_raspi_armv7.zip


echo "5.==> Configure gogs"
sudo chown -R git:git /opt/gogs


cat "[Unit]
Description=Gogs
After=syslog.target
After=network.target
#After=mariadb.service mysqld.service postgresql.service memcached.service redis.service
 
[Service]
# Modify these two values and uncomment them if you have
# repos with lots of files and get an HTTP error 500 because
# of that
###
#LimitMEMLOCK=infinity
#LimitNOFILE=65535
Type=simple
User=git
Group=git
WorkingDirectory=/home/git/gogs
ExecStart=/opt/gogs/gogs web
Restart=always
Environment=USER=git HOME=/home/git
 
[Install]
WantedBy=multi-user.target" > /opt/gogs/scripts/systemd/gogs.service

sudo -H -u git mkdir /home/git/gogs


echo "5.==> Start gogs service"
sudo systemctl enable /opt/gogs/scripts/systemd/gogs.service
sudo systemctl start gogs.service
sudo systemctl status gogs.service

echo "6.==> Test it: http://localhost:3000"

