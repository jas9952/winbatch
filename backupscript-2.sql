-- source: https://www.MSSQLTips.com

--declare variables
DECLARE @dbname VARCHAR(50) -- database name 
DECLARE @file_path VARCHAR(256) -- path 
DECLARE @file_name VARCHAR(256) -- 
DECLARE @file_date VARCHAR(20) -- used for filename

--set path for the backup file
--遠端備份目錄
--SET @file_path = 'D:\DBBackup\TEST\' -- ensure this directory exists on your machine
--本地目錄
SET @file_path = 'D:\DB_Backup\' -- ensure this directory exists on your machine

SELECT @file_date = CONVERT(VARCHAR(20),GETDATE(),112) + '_' + REPLACE(CONVERT(VARCHAR(20),GETDATE(),108),':','')

--declare the cursor 

DECLARE db_cursor CURSOR READ_ONLY FOR 
SELECT name 
FROM master.sys.databases 
--遠端備份資料庫名稱(tgk)
WHERE name  IN ('tgk')  -- exclude these databases
AND state = 0 -- database is online
AND is_in_standby = 0 -- database is not read only for log shipping

--open cursor
OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @dbname

WHILE @@FETCH_STATUS = 0
BEGIN
   --set file names based on the database name and datetime when the backup was made
   SET @file_name = @file_path + @dbname + '_' + @file_date + '.BAK'

   --create backup
   BACKUP DATABASE @dbname TO DISK = @file_name WITH INIT, COMPRESSION

   --fetch the next database on the server instance
   FETCH NEXT FROM db_cursor INTO @dbname
END

--close cursor
CLOSE db_cursor
DEALLOCATE db_cursor







