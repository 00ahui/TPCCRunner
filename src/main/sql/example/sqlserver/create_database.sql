
EXEC sp_configure 'recovery interval (min)',60
RECONFIGURE
EXEC sp_configure
GO

CREATE DATABASE tpcc ON  PRIMARY
( NAME = N'tpcc01', FILENAME = N'C:\tpcc\data\tpcc01.mdf' , 
  SIZE = 20480000KB , FILEGROWTH = 51200KB ),
( NAME = N'tpcc02', FILENAME = N'C:\tpcc\data\tpcc02.ndf' , 
  SIZE = 20480000KB , FILEGROWTH = 51200KB ),
( NAME = N'tpcc03', FILENAME = N'C:\tpcc\data\tpcc03.ndf' , 
  SIZE = 20480000KB , FILEGROWTH = 51200KB ),
( NAME = N'tpcc04', FILENAME = N'C:\tpcc\data\tpcc04.ndf' , 
  SIZE = 20480000KB , FILEGROWTH = 51200KB ),
( NAME = N'tpcc05', FILENAME = N'C:\tpcc\data\tpcc05.ndf' , 
  SIZE = 20480000KB , FILEGROWTH = 51200KB ),
( NAME = N'tpcc06', FILENAME = N'C:\tpcc\data\tpcc06.ndf' , 
  SIZE = 20480000KB , FILEGROWTH = 51200KB ),
( NAME = N'tpcc07', FILENAME = N'C:\tpcc\data\tpcc07.ndf' , 
  SIZE = 20480000KB , FILEGROWTH = 51200KB ),
( NAME = N'tpcc08', FILENAME = N'C:\tpcc\data\tpcc08.ndf' , 
  SIZE = 20480000KB , FILEGROWTH = 51200KB )
LOG ON 
( NAME = N'tpcclog', FILENAME = N'C:\tpcc\log\tpcc.ldf' , 
  SIZE = 20480000KB , FILEGROWTH = 10%)
GO

EXEC sp_helpdb tpcc
GO

ALTER DATABASE tpcc SET AUTO_CREATE_STATISTICS OFF WITH NO_WAIT
ALTER DATABASE tpcc SET AUTO_UPDATE_STATISTICS OFF WITH NO_WAIT
ALTER DATABASE tpcc SET RECOVERY SIMPLE WITH NO_WAIT
GO

EXEC sp_dboption tpcc
GO
