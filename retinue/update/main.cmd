@echo off
title Flash Collector Hot Update
color 3f

if not exist flash-collector.exe (
    echo Error working directory
    echo %~dp0
    pause
    exit
)
if "%1" == "" (
    echo Empty argument
    pause
    exit
)

echo Waiting for main program evacuation...
pause
@ping 127.0.0.1 -n 2 >nul
TASKKILL /F /IM flash-collector.exe /T >nul

xcopy /s /r /y .\UPDATE-TEMP\update\* .\
.\retinue\update\rcedit-x64.exe flash-collector.exe --set-file-version "%1%"
.\retinue\update\rcedit-x64.exe flash-collector.exe --set-product-version "%1%"

echo Flash Collector updated successfully
@ping 127.0.0.1 -n 3 >nul
del /f /q main.cmd
del /f /q "%0"
