#!/bin/bash

# wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/octoprint_installer.sh | sh octoprint_installer.sh |  rm  octoprint_installer.sh



apt update




# 1.==> Install essential
echo "1.==> Install essential"
apt-get install build-essential python-dev python-pip libcairo2-dev libpango1.0-dev libglib2.0-dev libxml2-dev librrd-dev python2.7-dev rrdtool python-rrdtool  -y
wget https://pypi.python.org/packages/source/p/psutil/psutil-2.1.1.tar.gz
tar xf psutil-2.1.1.tar.gz
cd psutil-2.1.1
sudo python setup.py install
sudo apt install python-pip python-dev python-setuptools python-virtualenv git libyaml-dev build-essential -y

## instal cura 
echo "2.==> Install cura"
mkdir /prj
cd /prj
sudo apt-get -y install gcc-4.7 g++-4.7
git clone -b legacy https://github.com/Ultimaker/CuraEngine.git
cd CuraEngine
make


### as pi user
echo "3.==> As Pi user"
su - pi -c "cd ~
mkdir OctoPrint && cd OctoPrint
virtualenv venv
source venv/bin/activate
pip install pip --upgrade
pip install https://get.octoprint.org/latest"

### configure
echo "4.==> Configure"
sudo usermod -a -G tty pi
sudo usermod -a -G dialout pi

### launch
echo "5.==> Launch the server"
octoprint serve


echo "5.==> Start gogs service"
sudo systemctl enable /opt/gogs/scripts/systemd/gogs.service
sudo systemctl start gogs.service
sudo systemctl status gogs.service

echo "6.==> Test it: http://localhost:5000"

