title voyager.bat
cd  /d %~dp0
reg add  "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v voyager  /d '%~dp0voyager_startup.bat' /f
voyager.exe start --config  voyager-config-053.yaml > %~dp0voyager.log 
pause