A TPCC workload generator for OLTP performance test, generally the test should be performed to evaluate the storage performance


HISTORY:

    Version 1.0
        - Support Oracle, SQL Server, DB2, Informix, MySQL databases
    
    Version 1.1
        - Support DaMeng database



BUILD:

    This is a maven project developed on codenvy.io, please follow the steps to build the project.

    1. Install JDBC drivers into local Maven reponsitory 
        
        (the following are tested driver, if you want to replace or add jdbc driver, please install the jar file to maven reponsitory, and edit the dependency in pom.xml)
    
        mvn install:install-file -DgroupId=com.oracle -DartifactId=ojdbc14 -Dversion=10.2 -Dpackaging=jar -Dfile=/projects/TPCCRunner/lib/ojdbc14.jar
        mvn install:install-file -DgroupId=com.informix -DartifactId=ifxjdbc -Dversion=4.0.3 -Dpackaging=jar -Dfile=/projects/TPCCRunner/lib/ifxjdbc.jar
        mvn install:install-file -DgroupId=com.mysql -DartifactId=mysql-connector-java -Dversion=5.1.7 -Dpackaging=jar -Dfile=/projects/TPCCRunner/lib/mysql-connector-java.jar
        mvn install:install-file -DgroupId=com.microsoft -DartifactId=sqljdbc4 -Dversion=3.0 -Dpackaging=jar -Dfile=/projects/TPCCRunner/lib/sqljdbc4.jar
        mvn install:install-file -DgroupId=com.ibm -DartifactId=db2jcc4 -Dversion=10.1 -Dpackaging=jar -Dfile=/projects/TPCCRunner/lib/db2jcc4.jar
        mvn install:install-file -DgroupId=com.dm -DartifactId=Dm7JdbcDriver17 -Dversion=1.0.0 -Dpackaging=jar -Dfile=/projects/TPCCRunner/lib/Dm7JdbcDriver17.jar
    
    2. Build the project, output to 'target'
        
        mvn clean install -f /projects/TPCCRunner -Dmaven.test.skip=true



RUN:

    Goto /projects/TPCCRunner/target.
    For each type of database, following the corresponding steps.

    Please make the following prepares:
        - Set the connect url, user and password in the loader and slave properties files
        - Set the master-slave connect port (masterPort, default 27891) in the properties files, and configure firewall exceptions
        - If you use other versions JDBC driver, please replace java classpath with: java -cp TPCCRunner-1.1.jar:lib/somejdbc.jar


DB2:
   
	1. Create Database
	
	2. Create Table
		
		db2batch -d <database> -f sql/example/db2/create_table.sql
	
	3. Load Data

		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Loader conf/example/db2/loader.properties

	4. Create index
		
		db2batch -d <database> -f sql/example/db2/create_index.sql

	5. Run Master
		
                java -cp TPCCRunner-full.jar wyh.TPCCRunner.Master conf/example/db2/master.properties

    6. Run Slaves on Clients

                java -cp TPCCRunner-full.jar wyh.TPCCRunner.Slave conf/example/db2/slave1.properties
                java -cp TPCCRunner-full.jar wyh.TPCCRunner.Slave conf/example/db2/slave2.properties

MySQL:

	1. Create Database
		
		mysql -uroot -p<password> -vvv -n < sql/example/mysql/create_database.sql

	2. Create Table

		mysql -uroot -p<password> -vvv -n < sql/example/mysql/create_table.sql

	3. Load Data
		
		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Loader conf/example/mysql/loader.properties

	4. Create index

		mysql -uroot -p<password> -vvv -n < sql/example/mysql/create_index.sql

	5. Run Master

		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Master conf/example/mysql/master.properties

	6. Run Slaves on Clients

		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Slave conf/example/mysql/slave1.properties
		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Slave conf/example/mysql/slave2.properties


SQLServer:

	1. Create Database

		sqlcmd -e -p 1 -y 30 -Y 30 -i sql\example\sqlserver\create_database.sql

	2. Create User

		sqlcmd -e -p 1 -y 30 -Y 30 -i sql\example\sqlserver\create_user.sql

	3. Create Tables

		sqlcmd -e -p 1 -y 30 -Y 30 -i sql\example\sqlserver\create_table.sql
		
	4. Load Data
		
		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Loader conf\example\sqlserver\loader.properties

	5. Create index

		sqlcmd -e -p 1 -y 30 -Y 30 -i sql\example\sqlserver\create_index.sql

	6. Run Master

		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Master conf\example\sqlserver\master.properties

	7. Run Slaves on Clients

		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Slave conf\example\sqlserver\slave1.properties
		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Slave conf\example\sqlserver\slave2.properties


Oracle:

	1. Create Tablespace (please change the data file path)

		sqlplus / as sysdba @sql/example/oracle/create_tablespace.sql
		
	2. Create User

		sqlplus / as sysdba @sql/example/oracle/create_user.sql

	3. Create Tables

		sqlplus user1/pswd @sql/example/oracle/create_table.sql

	4. Load Data
		
		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Loader conf/example/oracle/loader.properties

	5. Create index

		sqlplus user1/pswd @sql/example/oracle/create_index.sql

	6. Run Master

		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Master conf/example/oracle/master.properties

	7. Run Slaves on Clients

		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Slave conf/example/oracle/slave1.properties
		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Slave conf/example/oracle/slave2.properties

Informix:

	1. Create dbspace

		onspaces -c -d data1dbs -p $INFORMIXDIR/data/data1dbs -o 0 -s `cat /proc/partitions | awk '/sdc/{printf "%d000",$3/1000}'` -ef 1024 -en 8192 -k 4
		printf "\n" | ontape -s -L 0

	2. Create Database

		dbaccess - sql/example/informix/create_database.sql

	3. Create Tables

		dbaccess data1 sql/example/informix/create_table.sql
		
	4. Load Data
		
		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Loader conf/example/informix/loader.properties

	5. Create index

		dbaccess data1 sql/example/informix/create_index.sql

	6. Run Master

		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Master conf/example/informix/master.properties

	7. Run Slaves on Clients

		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Slave conf/example/informix/slave1.properties
		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Slave conf/example/informix/slave2.properties

DaMeng

	1. Create Database
        export PATH=$PATH:$DM_HOME/bin:$DM_HOME/jdk/bin
		isql
		SQL>login
		server name:localhost
		user name:sysdba
		password:
		port:12345

		SQL>create database tpcc datafile '/dmdb/data/tpcc.dbf' size 1024;
		SQL>set current database tpcc;

	2. Create User

		SQL>create login user1 identified by "pswd" default database tpcc role sys_admin;
		SQL>create user user1 related by user1;
		SQL>grant dba to user1;

	3. Create Tables

		isql localhost user1 pswd 12345 tpcc sql/example/dm/create_table.sql

	4. Load Data
		
		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Loader conf/example/dm/loader.properties

	5. Create index

		isql localhost user1 pswd 12345 tpcc sql/example/dm/create_index.sql

	6. Run Master

		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Master conf/example/dm/master.properties

	7. Run Slaves on Clients

		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Slave conf/example/dm/slave1.properties
		java -cp TPCCRunner-full.jar wyh.TPCCRunner.Slave conf/example/dm/slave2.properties
