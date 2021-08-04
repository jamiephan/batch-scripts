@echo off
echo Checking SSH...
ssh >nul 2>&1
if %errorlevel% neq 255 goto nossh

:start
cls
set /p "host=Enter the user@host info: "
set /p "port=Enter the port number: "

ssh -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p %port% %host%

pause
goto start

:nossh
cls
echo [31mError: SSH is not installed in this system.
echo [0m
echo Press any key to close this script...
pause > nul
