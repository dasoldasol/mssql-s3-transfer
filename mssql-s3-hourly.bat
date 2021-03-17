@echo off
for /f %%a in ('D:\bems-to-s3\yesterday.bat') do set "ystd=%%a"
set year=%ystd:~0,4%
set mm=%ystd:~4,2%
set dd=%ystd:~-2%
sqlcmd -S localhost -d iBems_SU -W -Q "SET NOCOUNT ON; SELECT * FROM iBems_SU.dbo.BemsMonitoringPointHistoryHourly WHERE SiteId=1 AND CreatedDateTime between CONCAT(CONVERT(char(10), dateadd(day, -1, getdate()), 23), ' 06:00') and CONCAT(CONVERT(char(10), dateadd(day, -0, getdate()), 23), ' 05:59')" -s ", " -o "D:\bems-to-s3\backup\%ystd%_BemsMonitoringPointHistoryHourly.csv"
aws s3 cp "D:\bems-to-s3\backup\%ystd%_BemsMonitoringPointHistoryHourly.csv" s3://hdci-ambt-raw/dev/bems/db=ambt_file/tb=bemsmonitoringpointhistoryhourly/year=%year%/month=%mm%/day=%dd%/