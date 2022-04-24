@ECHO OFF
TITLE MindowsDownloader
:START
TIMEOUT /T 1 /NOBREAK>nul
for /f %%i in (link.txt) do set link=%%i>nul
aria2c.exe -s 8 %link% | find "download completed."
if not "%errorlevel%"=="0" goto START
echo.下载完成>下载完成
EXIT