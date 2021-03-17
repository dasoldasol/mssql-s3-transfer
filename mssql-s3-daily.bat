@echo off
for /f %%a in ('D:\bems-to-s3\yesterday.bat') do set "ystd=%%a"
set year=%ystd:~0,4%
set mm=%ystd:~4,2%
set dd=%ystd:~-2%
sqlcmd -S localhost -d iBems_SU -W -Q "SET NOCOUNT ON; SELECT * FROM iBems_SU.dbo.BemsMonitoringPointHistoryDaily WHERE SiteId=1 AND CreatedDateTime between CONCAT(CONVERT(char(10), dateadd(day, -1, getdate()), 23), ' 00:00') and CONCAT(CONVERT(char(10), dateadd(day, -1, getdate()), 23), ' 23:59')" -s ", " -o "D:\bems-to-s3\backup\%ystd%_BemsMonitoringPointHistoryDaily.csv"
aws s3 cp "D:\bems-to-s3\backup\%ystd%_BemsMonitoringPointHistoryDaily.csv" s3://hdci-ambt-raw/dev/bems/db=ambt_file/tb=bemsmonitoringpointhistorydaily/year=%year%/month=%mm%/day=%dd%/