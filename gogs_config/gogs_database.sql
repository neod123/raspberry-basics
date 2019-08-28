SET GLOBAL innodb_file_per_table = ON;
CREATE DATABASE gogsdb;
CREATE USER 'gogsuser'@'localhost' IDENTIFIED BY 'new_password_here';
GRANT ALL ON gogsdb.* TO 'gogsuser'@'localhost' IDENTIFIED BY 'new_password_here' WITH GRANT OPTION;
ALTER DATABASE gogsdb CHARACTER SET = utf8mb4 COLLATE utf8mb4_unicode_ci;
FLUSH PRIVILEGES;
EXIT;
