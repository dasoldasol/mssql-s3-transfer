@echo off
xcopy "C:\Users\Temp\*.*" "D:\bems-to-s3\backup\" /e /k /y
del "C:\Users\Temp\*.csv"