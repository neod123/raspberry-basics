#!/bin/bash

# wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/gogs_installer.sh | sh gogs_installer.sh |  rm  gogs_installer.sh


########## install MariaDb ##############
if [ -f /usr/bin/mariadb ]
then
    echo "==> 1.2. MariaDb already installed"
else 

  echo "1.==> install MariaDb"
  sudo apt-get install mariadb-server mariadb-client -y
  sudo systemctl stop mariadb.service
  sudo systemctl start mariadb.service
  sudo systemctl enable mariadb.service

  echo "2.==> Secure MariaDb"
  sudo mysql_secure_installation

  sudo systemctl stop mariadb.service
  sudo systemctl start mariadb.service
  sudo systemctl enable mariadb.service
fi



echo "3.==> Install git"
sudo apt-get install git -y

echo "4.==> install gogs"
cd /opt
sudo wget https://dl.gogs.io/0.11.91/gogs_0.11.91_raspi_armv7.zip
sudo unzip gogs_0.11.91_raspi_armv7.zip
sudo rm gogs_0.11.91_raspi_armv7.zip


echo "5.==> Configure gogs"
sudo chown -R git:git /opt/gogs

rm /opt/gogs/scripts/systemd/gogs.service
wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/gogs_config/gogs.service -P  /opt/gogs/scripts/systemd/

sudo -H -u git mkdir /home/git/gogs


echo "5.==> Start gogs service"
sudo systemctl enable /opt/gogs/scripts/systemd/gogs.service
sudo systemctl start gogs.service
sudo systemctl status gogs.service

echo "6.==> Test it: http://localhost:3000"

