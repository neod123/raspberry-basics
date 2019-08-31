# raspberry-basics
Raspberry basics installer scripts

All theses scripts shall be run in root.
Theses script may ask for password setting, due to connexion to database for example. Don't hesitate to check the source code

# Web server installer
```wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/web_server_installer.sh | sh web_server_installer.sh | rm web_server_installer.sh```
- Status: TESTED
- Version infos: mariaDb: 10.3.15, nginx: 1.14.2,php: 7.3, raspberry: debian-buster-lite
# Gogs installer

```wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/gogs_installer.sh | sh gogs_installer.sh | rm gogs_installer.sh```
Info:
- Src: https://www.techcoil.com/blog/setting-up-your-own-raspberry-pi-3-git-server-with-go-git-service-gogs-and-raspbian-stretch-lite/
- Src: https://websiteforstudents.com/install-gogs-git-server-with-mariadb-on-ubuntu-16-04-18-04-lts/
- Status: TESTED
- Version infos: mariaDb: 10.3.15, gogs: 0.11.91, raspberry: debian-buster-lite

# Nextcloud installer 
```wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/nextcloud_installer.sh | sh nextcloud_installer.sh | rm nextcloud_installer.sh```

- Src: https://howto.wared.fr/ubuntu-installation-nextcloud-nginx/
- Add a hard_drive folder: https://docs.nextcloud.com/server/9/admin_manual/configuration_files/external_storage/local.html
- Status: UNTESTED


# Mail server installer (TBD)
```wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/mail_server_installer.sh | sh mail_server_installer.sh | rm mail_server_installer.sh```
- Status: NOT IMPLEMENTED YET

# Octoprint
```wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/octoprint_installer.sh | sh octoprint_installer.sh | rm octoprint_installer.sh```
- Status: UNTESTED



# Concourse-ci installer (TBD)
```wget https://raw.githubusercontent.com/neod123/raspberry-basics/master/concourse-ci_installer.sh | sh concourse-ci_installer.sh | rm concourse-ci_installer.sh```
- Status: NOT IMPLEMENTED YET
