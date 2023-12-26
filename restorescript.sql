USE master
GO
ALTER DATABASE test SET  SINGLE_USER WITH ROLLBACK IMMEDIATE;

DECLARE @dbname VARCHAR(50) -- database name 
DECLARE @file_path VARCHAR(256) -- path
 
--Set the file for the backup file to be used for recovery
--還原檔所在目錄

SET @file_path = 'D:\DB_Backup\tgk_20231226_141454.BAK' -- ensure this file exists on your machine 
--SET @file_path  = 'D:\DBBackup\TEST\tgk_20231226_083000.BAK' 
--set the name for the database to be recovered, this should match the first part of the backup file
--要還原的DB NAME

SET @dbname = 'test'
 
RESTORE DATABASE @dbname FROM DISK = @file_path WITH REPLACE, RECOVERY;

USE master
GO
ALTER DATABASE test SET  MULTI_USER ;