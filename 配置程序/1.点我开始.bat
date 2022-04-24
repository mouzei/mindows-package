@ECHO OFF
mode con cols=66 lines=30
TITLE Mindows工具箱配置程序
ECHO.清理环境...
taskkill /f /im startdl.exe
taskkill /f /im aria2c.exe
del product.txt
del chkconnect_log.txt
rd /s /Q downloading

:START
COLOR 0A
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                     欢迎使用Mindows工具箱！
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.工具箱尚未配置，下面将根据你的机型下载相应配置文件。
ECHO.
ECHO.这个步骤仅为识别机型，不涉及刷机。
ECHO.
ECHO.1.自动识别机型(默认)   2.手动选择机型
ECHO.
set choice=1
set /p choice= 输入数字按Enter继续：
if "%choice%"=="2" goto CHOOSE
ECHO.
ECHO.请将设备关机，进入Fastboot模式，并用数据线连接电脑。
:START-2
set choice_syxz=Fastboot
call chkconnect_syxz.bat %choice_syxz%
if not "%result_syxz%"=="1" goto START-2
.\fastboot.exe getvar product 2>product.txt
set model=blank
find "chiron" "product.txt" 1>nul 2>nul
if "%errorlevel%"=="0" set model=MIX2& ECHO.检测到你的机型为MIX2。 & goto MAIN
find "polaris" "product.txt" 1>nul 2>nul
if "%errorlevel%"=="0" set model=MIX2S& ECHO.检测到你的机型为MIX2S。 & goto MAIN
find "perseus" "product.txt" 1>nul 2>nul
if "%errorlevel%"=="0" set model=MIX3& ECHO.检测到你的机型为MIX3。 & goto MAIN
find "siris" "product.txt" 1>nul 2>nul
if "%errorlevel%"=="0" set model=MI6& ECHO.检测到你的机型为MI6。 & goto MAIN
ECHO.找不到适用于你的设备的配置包！按任意键退出。
pause>nul
EXIT

:CHOOSE
CLS
ECHO.
ECHO.目前已适配的机型如下，请选择你的机型：
ECHO.
ECHO.1.MIX2
ECHO.2.MIX2S
ECHO.3.MIX3
ECHO.4.MI6
::ECHO.A.没有我的机型
ECHO.
set choice=blank
set /p choice= 输入数字按Enter继续：
if "%choice%"=="1" set model=MIX2& set program=Mindows-MSM-NONAB& goto MAIN
if "%choice%"=="2" set model=MIX2S& set program=Mindows-MSM-NONAB& goto MAIN
if "%choice%"=="3" set model=MIX3& set program=Mindows-MSM-NONAB& goto MAIN
if "%choice%"=="4" set model=MI6& set program=Mindows-MSM-NONAB& goto MAIN
::if "%choice%"=="A" goto FORERUNNER
::if "%choice%"=="a" goto FORERUNNER
goto CHOOSE

:MAIN
ECHO.
ECHO.现在你可以断开设备，等待配置完成。
ECHO.
rd /s /Q downloading 1>nul 2>nul
md downloading 1>nul 2>nul
md program 1>nul 2>nul
move 7z.exe program
move 7z.dll program
ECHO.正在准备下载...
set name=%program%
set num1=001
call :dl
set num1=002
call :dl
set num1=003
call :dl
set num1=004
call :dl
set num1=005
call :dl
set num1=006
call :dl
set num1=007
call :dl
set num1=008
call :dl
set num1=009
call :dl
set num3=0
:MAIN-WAIT
TIMEOUT /T 1 /NOBREAK>nul
set num1=001& call :main-move
set num1=002& call :main-move
set num1=003& call :main-move
set num1=004& call :main-move
set num1=005& call :main-move
set num1=006& call :main-move
set num1=007& call :main-move
set num1=008& call :main-move
set num1=009& call :main-move
CLS
ECHO.
ECHO.正在下载主程序，请耐心等待...
ECHO.
ECHO.注意：关闭此窗口后下载程序仍然会残留在后台，如果你想停止下载，请重新打开一次再关闭，程序会自动结束下载进程。
ECHO.
ECHO.已完成：%num3% / 9
if not "%num3%"=="9" goto MAIN-WAIT
ECHO.下载完成！
cd program
ECHO.正在解压...
7z.exe x "%program%.7z.001" -y
ECHO.解压完成！
ECHO.清理文件...
del %program%.7z.*
del 7z.exe
del 7z.dll
cd %~dp0\
rd /s /Q downloading
if not "%errorlevel%"=="0" ECHO.删除downloading文件夹出错！可能有程序正在占用此文件夹！请手动删除然后按任意键继续。 & pause>nul
goto MODEL

:main-move
if exist downloading\%num1%\下载完成 move downloading\%num1%\%program%.7z.%num1% program\>nul & rd /s /Q downloading\%num1% & set /a num3+=1
goto :eof


:MODEL
md downloading
CLS
ECHO.
ECHO.正在准备下载...
set name=%model%
set num1=001
call :dl
set num1=002
call :dl
set num1=003
call :dl
set num1=004
call :dl
set num1=005
call :dl
set num1=006
call :dl
set num1=007
call :dl
set num1=008
call :dl
set num1=009
call :dl
set num3=0
:MODEL-WAIT
TIMEOUT /T 1 /NOBREAK>nul
set num1=001& call :model-move
set num1=002& call :model-move
set num1=003& call :model-move
set num1=004& call :model-move
set num1=005& call :model-move
set num1=006& call :model-move
set num1=007& call :model-move
set num1=008& call :model-move
set num1=009& call :model-move
CLS
ECHO.
ECHO.正在下载%model%配置包，请耐心等待...
ECHO.
ECHO.注意：关闭此窗口后下载程序仍然会残留在后台，如果你想停止下载，请重新打开一次再关闭，程序会自动结束下载进程。
ECHO.
ECHO.已完成：%num3% / 9
if not "%num3%"=="9" goto MODEL-WAIT
ECHO.下载完成！
cd program\bin
ECHO.正在解压...
7z.exe x "%model%.7z.001" -y
ECHO.解压完成！
ECHO.清理文件...
del %model%.7z.*
cd %~dp0\
del *.exe
del *.dll
del *.txt
rd /s /Q downloading
ren program Mindows工具箱-%model%
msg %username% "工具箱配置完成！你可以正常使用了。"
del *.bat
pause>nul
EXIT

:model-move
if exist downloading\%num1%\下载完成 move downloading\%num1%\%model%.7z.%num1% program\bin\>nul & rd /s /Q downloading\%num1% & set /a num3+=1
goto :eof


:dl
md downloading\%num1%
copy aria2c.exe downloading\%num1%>nul
copy startdl.exe downloading\%num1%>nul
for /f "tokens=1 delims= " %%i in ('findstr "%name%.7z.%num1%" alllink.txt') do echo.%%i>downloading\%num1%\link.txt
cd downloading\%num1%
start startdl.exe
cd %~dp0\
goto :eof




:FORERUNNER
CLS
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.                    Mindows工具箱-先行者计划
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.由于机型众多，
ECHO.
ECHO.
pause

