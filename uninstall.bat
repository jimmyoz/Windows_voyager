@echo off
set port=1633
for /f "tokens=1-5" %%i in ('netstat -ano^|findstr ":%port%"') do ( 
echo %%i %%j %%k %%l %%m

if "%%m" NEQ "" (
TASKKILL /PID %%m /F
)

)

taskkill /fi "windowtitle eq 选择管理员:  voyager.bat" 
taskkill /fi "windowtitle eq 管理员:  voyager.bat" 
taskkill /fi "windowtitle eq voyager.bat" 

taskkill /fi "windowtitle eq 选择管理员:  voyager_startup.bat" 
taskkill /fi "windowtitle eq 管理员:  voyager_startup.bat" 
taskkill /fi "windowtitle eq voyager_startup.bat" 

del /f /q  %~dp0voyager.log
del /f /q  %~dp0voyagerPrimaryKeys.txt
rd /s/q "C:\voyagerdata"
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v voyager /f
