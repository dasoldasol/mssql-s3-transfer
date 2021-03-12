@echo off
for /f %%a in ('D:\bems-to-s3\yesterday.bat') do set "ystd=%%a"
set year=%ystd:~0,4%
set mm=%ystd:~4,2%
set dd=%ystd:~-2%
sqlcmd -S localhost -d iBems_SU -W -Q "SET NOCOUNT ON; SELECT * FROM ((SELECT SiteId, FacilityCode, PropertyId FROM iBems_SU.dbo.BemsMonitoringPointHistory15min WHERE SiteId = 1 AND CreatedDateTime between CONCAT(CONVERT(char(10), dateadd(day, -1, getdate()), 23), ' 06:00') and CONCAT(CONVERT(char(10), dateadd(day, -0, getdate()), 23), ' 05:59') GROUP BY SiteId, FacilityCode, PropertyId) A INNER JOIN ( SELECT * FROM iBems_SU.dbo.BemsMonitoringPointHistory15min WHERE SiteId = 1 AND CreatedDateTime between CONCAT(CONVERT(char(10), dateadd(day, -1, getdate()), 23), ' 06:00') and CONCAT(CONVERT(char(10), dateadd(day, -0, getdate()), 23), ' 05:59')) B ON A.SiteId = B.SiteId AND A.FacilityCode = B.FacilityCode  AND A.PropertyId = B.PropertyId)" -s ", " -o "C:\Users\Temp\%ystd%_BemsMonitoringPointHistory15min.csv"
aws s3 cp "C:\Users\Temp\%ystd%_BemsMonitoringPointHistory15min.csv" s3://hdci-ambt-raw/dev/bems/db=ambt_file/tb=bemsmonitoringpointhistory15min/year=%year%/month=%mm%/day=%dd%/