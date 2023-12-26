@echo off
set DB_NAME=tgk
set BACKUP_DIR=D:\DBBackup\TEST
set DAYS_TO_KEEP=0
echo Starting backup of %DB_NAME% database...
sqlcmd -S 192.168.52.216,1400 -U UFPDDELH -P 58008368 -Q "BACKUP DATABASE %DB_NAME% TO DISK='%BACKUP_DIR%\%DB_NAME%_%date:/=-%_%time::=-%.bak' WITH INIT, COMPRESSION"
if %ERRORLEVEL% neq 0 (
    echo Backup failed with error code %ERRORLEVEL%.
    eventcreate /T ERROR /L APPLICATION /ID 100 /D "SQL Server backup failed with error code %ERRORLEVEL%."
    goto end
)

echo Script complete.
