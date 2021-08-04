@echo off
:start
set /p input=
set "input=%input:\=/%"
echo.
echo %input%
pause > nul
cls
goto start