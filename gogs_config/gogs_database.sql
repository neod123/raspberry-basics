CREATE DATABASE IF NOT EXISTS gogsdb CHARACTER SET utf8 COLLATE utf8_general_ci;
grant usage on gogsdb.* to gogs@localhost identified by 'm_password';
grant all privileges on gogsdb.* to gogs@localhost ;
FLUSH PRIVILEGES;
use gogsdb;
SET default_storage_engine=INNODB;
SHOW DATABASEs;
select user, password, host from 
exit



