@echo off
title voyager.bat
echo Administrator
cacls.exe "%SystemDrive%\System Volume Information" >nul 2>nul
if %errorlevel%==0 goto Admin
if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"
echo Set RequestUAC = CreateObject^("Shell.Application"^)>"%temp%\getadmin.vbs"
echo RequestUAC.ShellExecute "%~s0","","","runas",1 >>"%temp%\getadmin.vbs"
echo WScript.Quit >>"%temp%\getadmin.vbs"
"%temp%\getadmin.vbs" /f
if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"
exit

:Admin
echo Administrator success
SC stop voyager

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

taskkill /fi "windowtitle eq 选择管理员:  voyager_temp.bat" 
taskkill /fi "windowtitle eq 管理员:  voyager_temp.bat" 
taskkill /fi "windowtitle eq voyager_temp.bat" 

taskkill /f /im "voyager.exe"

cd /d %~dp0
del /f /q  "%~dp0voyager.log"
del /f /q  "%~dp0voyagerPrimaryKeys.txt"
rd /s/q "C:\voyagerData"
rd /s/q "%~dp0voyagerData"
del /f /q  "%~dp0error.log"
del /f /q "%~dp0events.log"
del /f /q "%~dp0InstallUtil.InstallLog"
del /f /q "%~dp0voyagerService.InstallLog"
del /f /q "%~dp0voyagerService.InstallState"
del /f /q "C:\voyager.bat"
del /f /q "%temp%\voyager.bat"
reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v voyager /f
SC delete voyager
pause
taskkill /im cmd.exe /f
