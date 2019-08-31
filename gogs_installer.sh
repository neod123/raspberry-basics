#!/bin/bash

# wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/gogs_installer.sh | sh gogs_installer.sh |  rm  gogs_installer.sh
#
# src: https://www.techcoil.com/blog/setting-up-your-own-raspberry-pi-3-git-server-with-go-git-service-gogs-and-raspbian-stretch-lite/
# src: https://websiteforstudents.com/install-gogs-git-server-with-mariadb-on-ubuntu-16-04-18-04-lts/

########## install MariaDb ##############
if [ -f /usr/bin/mariadb ]
then
    echo "1.2.==>  MariaDb already installed"
else 

  echo "1.==> install MariaDb"
  sudo apt-get install mariadb-server mariadb-client -y
  sudo systemctl stop mariadb.service
  sudo systemctl start mariadb.service
  sudo systemctl enable mariadb.service

  echo "2.==> Secure MariaDb"
  echo "Please feel all general infos for MariaDB configuration and don t forget the user and the password for root!! (press Y for all)"
  sudo mysql_secure_installation

  sudo systemctl stop mariadb.service
  sudo systemctl start mariadb.service
  sudo systemctl enable mariadb.service
fi


########## install git ##############
echo "3.==> Install git"
sudo apt-get install git -y

########## install gogs ##############
echo "4.==> install gogs"
cd /opt
sudo wget https://dl.gogs.io/0.11.91/gogs_0.11.91_raspi_armv7.zip
sudo unzip -o gogs_0.11.91_raspi_armv7.zip
sudo rm gogs_0.11.91_raspi_armv7.zip


########## Configure gogs ##############
echo "5.==> Configure gogs"
adduser --disabled-login --gecos 'Go Git Service' git
chown -R git:git /opt/gogs

rm /opt/gogs/scripts/systemd/gogs.service
wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/gogs_config/gogs.service -P  /opt/gogs/scripts/systemd/

sudo -H -u git mkdir /home/git/gogs

########## create the database ##############
echo "6.==> Create the DB"
echo "Provide password for the new user in database:"
read PASSWORD

#mysql -u root -p < /opt/gogs/scripts/mysql.sql 

wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/gogs_config/gogs_database.sql
sed -i 's/m_password/$PASSWORD/g' gogs_database.sql
cat gogs_database.sql
echo "Connect to MariaDb: please provide the main mariaDb password !!!"
mysql -u root -p < gogs_database.sql 


########## Start gogs service ##############
echo "7.==> Start gogs service"
sudo systemctl enable /opt/gogs/scripts/systemd/gogs.service
sudo systemctl start gogs.service

echo "8.==> Done: Test it: http://localhost:3000"
sudo systemctl status gogs.service


