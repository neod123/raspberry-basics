SET GLOBAL innodb_file_per_table = ON;
CREATE DATABASE gogsdb;
CREATE USER 'gogsuser' IDENTIFIED BY 'm_password';
GRANT ALL ON gogsdb.* TO 'gogsuser'@'localhost' IDENTIFIED BY 'm_password' WITH GRANT OPTION;
ALTER DATABASE gogsdb CHARACTER SET = utf8mb4 COLLATE utf8mb4_unicode_ci;
FLUSH PRIVILEGES;
SHOW DATABASEs;
select user, password, host from mysql.user;
exit
