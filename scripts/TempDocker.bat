@echo off
@setlocal enableextensions enabledelayedexpansion
for /f %%a in ('copy /Z "%~dpf0" nul') do set "CR=%%a"
:start
set "cmd="
set "img="
cls
echo Checking Docker Images...
docker info >nul 2>&1
if %errorlevel% neq 0 goto errorImg
:askImgName
cls
echo Docker Images:
echo [33m 
docker images --format "{{title .Repository}}"
echo [0m
set /p "img=Enter the image name: [36m"
echo [0m
if [%img%] == [] echo [31mError: Empty Image name is not allowed. [0m & goto askImgName

set /p "cmd=Enter the command [blank to use image configured CMD]: [36m"
echo [0m

FOR /F "tokens=* USEBACKQ" %%F IN (`echo %img% ^| tr "[A-Z]" "[a-z]"`) DO (
	SET img_lower=%%F
)
cls
docker run -it --rm %img_lower% %cmd%
echo.
echo Container Exited with Error Code: [32m%errorlevel%[0m
echo Press any key to create a new container....
pause > nul
goto start

:errorImg
cls
echo [31mError: Failed to obtain Docker Images.
echo Is Docker Daemon Running?
echo.
<nul set /p"=Retrying in 3 seconds... !CR!"
ping 127.0.0.1 -n 2 > nul 
<nul set /p"=Retrying in 2 seconds... !CR!"
ping 127.0.0.1 -n 2 > nul 
echo Retrying in 1 seconds...[0m
ping 127.0.0.1 -n 2 > nul 
goto start