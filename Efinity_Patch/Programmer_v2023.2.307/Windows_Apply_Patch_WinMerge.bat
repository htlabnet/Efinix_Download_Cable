
@echo off
cd /d %~dp0


set TARGET_FOLDER=C:\Efinity\Programmer\2023.2\pgm\bin\efx_pgm
set PATCH_COMMAND=C:\Program Files\WinMerge\Commands\GnuWin32\bin\patch.exe


rem ###### Running a command as Administrator ######
net session >NUL 2>nul
if %errorlevel% neq 0 (
 @powershell start-process '"%~0"' -verb runas
 exit
)
rem ###### Running a command as Administrator ######

if not exist "%PATCH_COMMAND%" (
 echo Patch command ^(WinMerge^) does not exist^!
 pause
 exit
)

if not exist "%TARGET_FOLDER%\usb_resolver.py" (
 echo Efinity file does not exist^!
 pause
 exit
)

if exist "%TARGET_FOLDER%\usb_resolver.py.orig" (
 echo Patch file has already been applied^!
 pause
 exit
)

xcopy /I "%~dp0efx_hw_common\boards" "%TARGET_FOLDER%\efx_hw_common\boards"
"%PATCH_COMMAND%" -b "%TARGET_FOLDER%\usb_resolver.py" ".\usb_resolver.py.diff"

pause
