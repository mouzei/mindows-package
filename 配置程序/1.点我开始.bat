@ECHO OFF
mode con cols=66 lines=30
TITLE Mindows���������ó���
ECHO.������...
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
ECHO.                     ��ӭʹ��Mindows�����䣡
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.��������δ���ã����潫������Ļ���������Ӧ�����ļ���
ECHO.
ECHO.��������Ϊʶ����ͣ����漰ˢ����
ECHO.
ECHO.1.�Զ�ʶ�����(Ĭ��)   2.�ֶ�ѡ�����
ECHO.
set choice=1
set /p choice= �������ְ�Enter������
if "%choice%"=="2" goto CHOOSE
ECHO.
ECHO.�뽫�豸�ػ�������Fastbootģʽ���������������ӵ��ԡ�
:START-2
set choice_syxz=Fastboot
call chkconnect_syxz.bat %choice_syxz%
if not "%result_syxz%"=="1" goto START-2
.\fastboot.exe getvar product 2>product.txt
set model=blank
find "chiron" "product.txt" 1>nul 2>nul
if "%errorlevel%"=="0" set model=MIX2& ECHO.��⵽��Ļ���ΪMIX2�� & goto MAIN
find "polaris" "product.txt" 1>nul 2>nul
if "%errorlevel%"=="0" set model=MIX2S& ECHO.��⵽��Ļ���ΪMIX2S�� & goto MAIN
find "perseus" "product.txt" 1>nul 2>nul
if "%errorlevel%"=="0" set model=MIX3& ECHO.��⵽��Ļ���ΪMIX3�� & goto MAIN
find "siris" "product.txt" 1>nul 2>nul
if "%errorlevel%"=="0" set model=MI6& ECHO.��⵽��Ļ���ΪMI6�� & goto MAIN
ECHO.�Ҳ�������������豸�����ð�����������˳���
pause>nul
EXIT

:CHOOSE
CLS
ECHO.
ECHO.Ŀǰ������Ļ������£���ѡ����Ļ��ͣ�
ECHO.
ECHO.1.MIX2
ECHO.2.MIX2S
ECHO.3.MIX3
ECHO.4.MI6
::ECHO.A.û���ҵĻ���
ECHO.
set choice=blank
set /p choice= �������ְ�Enter������
if "%choice%"=="1" set model=MIX2& set program=Mindows-MSM-NONAB& goto MAIN
if "%choice%"=="2" set model=MIX2S& set program=Mindows-MSM-NONAB& goto MAIN
if "%choice%"=="3" set model=MIX3& set program=Mindows-MSM-NONAB& goto MAIN
if "%choice%"=="4" set model=MI6& set program=Mindows-MSM-NONAB& goto MAIN
::if "%choice%"=="A" goto FORERUNNER
::if "%choice%"=="a" goto FORERUNNER
goto CHOOSE

:MAIN
ECHO.
ECHO.��������ԶϿ��豸���ȴ�������ɡ�
ECHO.
rd /s /Q downloading 1>nul 2>nul
md downloading 1>nul 2>nul
md program 1>nul 2>nul
move 7z.exe program
move 7z.dll program
ECHO.����׼������...
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
ECHO.�������������������ĵȴ�...
ECHO.
ECHO.ע�⣺�رմ˴��ں����س�����Ȼ������ں�̨���������ֹͣ���أ������´�һ���ٹرգ�������Զ��������ؽ��̡�
ECHO.
ECHO.����ɣ�%num3% / 9
if not "%num3%"=="9" goto MAIN-WAIT
ECHO.������ɣ�
cd program
ECHO.���ڽ�ѹ...
7z.exe x "%program%.7z.001" -y
ECHO.��ѹ��ɣ�
ECHO.�����ļ�...
del %program%.7z.*
del 7z.exe
del 7z.dll
cd %~dp0\
rd /s /Q downloading
if not "%errorlevel%"=="0" ECHO.ɾ��downloading�ļ��г��������г�������ռ�ô��ļ��У����ֶ�ɾ��Ȼ������������� & pause>nul
goto MODEL

:main-move
if exist downloading\%num1%\������� move downloading\%num1%\%program%.7z.%num1% program\>nul & rd /s /Q downloading\%num1% & set /a num3+=1
goto :eof


:MODEL
md downloading
CLS
ECHO.
ECHO.����׼������...
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
ECHO.��������%model%���ð��������ĵȴ�...
ECHO.
ECHO.ע�⣺�رմ˴��ں����س�����Ȼ������ں�̨���������ֹͣ���أ������´�һ���ٹرգ�������Զ��������ؽ��̡�
ECHO.
ECHO.����ɣ�%num3% / 9
if not "%num3%"=="9" goto MODEL-WAIT
ECHO.������ɣ�
cd program\bin
ECHO.���ڽ�ѹ...
7z.exe x "%model%.7z.001" -y
ECHO.��ѹ��ɣ�
ECHO.�����ļ�...
del %model%.7z.*
cd %~dp0\
del *.exe
del *.dll
del *.txt
rd /s /Q downloading
ren program Mindows������-%model%
msg %username% "������������ɣ����������ʹ���ˡ�"
del *.bat
pause>nul
EXIT

:model-move
if exist downloading\%num1%\������� move downloading\%num1%\%model%.7z.%num1% program\bin\>nul & rd /s /Q downloading\%num1% & set /a num3+=1
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
ECHO.                    Mindows������-�����߼ƻ�
ECHO.
ECHO.=---------------------------------------------------------------=
ECHO.
ECHO.���ڻ����ڶ࣬
ECHO.
ECHO.
pause

