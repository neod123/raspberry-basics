SET GLOBAL innodb_file_per_table = ON;
CREATE DATABASE nextcloud;
CREATE USER 'nextcloud' IDENTIFIED BY 'm_password';
GRANT ALL ON nextcloud.* TO 'nextcloud'@'localhost' IDENTIFIED BY 'm_password' WITH GRANT OPTION;
ALTER DATABASE gogsdb CHARACTER SET = utf8mb4 COLLATE utf8mb4_unicode_ci;
FLUSH PRIVILEGES;
SHOW DATABASES;
select user, password, host from mysql.user;
exit
