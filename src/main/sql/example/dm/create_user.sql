create login tpcc identified by "tpcc" default database oltpdb role sys_admin;
create user tpcc related by tpcc;
grant dba to tpcc;
