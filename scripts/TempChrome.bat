@echo off

title Tempoary Chrome Profile Launcher

rem set "debug=1"
set "debug=0"

if not "%debug%" == "1" (
	if not "%1"=="Opened_Via_PS" (
		rem No args passed
		pushd %~dp0
		rem start /MIN "" "%cd%\%~n0%~x0" Opened_Via_Start_Cmd
		powershell.exe -NoLogo -NoProfile -WindowStyle Hidden -NonInteractive -ExecutionPolicy Bypass -Command ^
		"(New-Object -ComObject WScript.Shell).Run('\"%cd%\%~n0%~x0\" Opened_Via_PS', 0,  'false')" > nul
		popd
		exit /B
	)
)

set "temp_prof_dir=ChromeTempProfile_%random%%random%%random%%random%%random%"
set "temp_prof_location=%temp%"
set "chrome_exe=C:\Program Files\Google\Chrome\Application\chrome.exe"

rem Chrome Settings

rem Set the starting url for chrome page, seperate by spacebar for multiple pages
set "homepage=https://www.google.com"



set temp_prof_path="%temp_prof_location%\%temp_prof_dir%"

mkdir "%temp_prof_path%"

echo.
echo.
echo.
echo +--------------------------------------------------------------------+
echo ^|                     DO NOT CLOSE THIS WINDOW                       ^|
echo +--------------------------------------------------------------------+
echo ^|The tempoary Chrome profile will be deleted after Chrome is closed, ^|
echo ^|           which requires this window to stay open.                 ^|
echo +--------------------------------------------------------------------+
echo.
echo The tempoary Chrome profile location is:
echo %temp_prof_path%


rem ======== Adblock Extension =========
rem curl -sL https://chrome-extension-downloader.com/9171ae26049decc027d535a31e6003e7/cfhdojbkjhnklbpkdaibdccddilifddb.crx %temp_prof_path%\_adblockplus\adb.zip
rem powershell.exe -NoLogo -NoProfile -WindowStyle Hidden -NonInteractive -ExecutionPolicy Bypass -Command ^
		rem "Expand-Archive -Force \"%temp_prof_path%\_adblockplus\adb.zip\" \"%temp_prof_path%\_adblockplus\"" > nul 

"%chrome_exe%" %homepage% ^
	--no-crash-upload ^
	--no-default-browser-check ^
	--no-first-run ^
	--disable-sync ^
	--disable-component-extensions-with-background-pages ^
	--disable-background-mode ^
	--/prefetch:1 ^
	--start-maximized ^
	--user-data-dir=%temp_prof_path%


rem "%chrome_exe%" %homepage% --no-crash-upload --no-default-browser-check --load-extension="%temp%/a" --no-first-run --disable-sync --disable-component-extensions-with-background-pages --disable-background-mode --/prefetch:1 --start-maximized --user-data-dir=%temp_prof_path%
rem "%chrome_exe%" %homepage% --no-first-run --disable-background-mode --start-maximized --disable-extensions --user-data-dir=%temp_prof_path%

timeout /T 1 > NUL

echo Deleting Chrome Temp Profile...
rmdir /Q /S "%temp_prof_path%"
echo Deleted Chrome Temp Profile
rem msg * Deleted Chrome Temp Profile (%temp_prof_path%)

if not "%debug%" == "1" (
	exit /B
)

pause

exit /b