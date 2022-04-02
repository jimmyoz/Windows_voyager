title voyager_startup.bat
cd  /d %~dp0
voyager.exe start --config  voyager-config-053.yaml > %~dp0voyager.log
pause 