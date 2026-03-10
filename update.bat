@echo off
setlocal
title Techno-Magic Updater
color 0B

echo.
echo  ======================================
echo       Techno-Magic  Updater
echo  ======================================
echo.

set "GIT=%~dp0PortableGit\bin\git.exe"
set "REPO=%~dp0."

if not exist "%GIT%" (
    color 0C
    echo  [ERROR] PortableGit not found!
    echo  Put PortableGit folder next to this script.
    echo.
    pause
    exit /b 1
)

if not exist "%REPO%\.git" (
    color 0C
    echo  [ERROR] Git repo not found in .minecraft!
    echo  Make sure .minecraft is a git repository.
    echo.
    pause
    exit /b 1
)

echo  [....] Checking for updates...
echo.

cd /d "%REPO%"
"%GIT%" fetch origin 2>nul

set "COMMITS=0"
for /f "delims=" %%i in ('"%GIT%" rev-list HEAD..origin/main --count 2^>nul') do set "COMMITS=%%i"

if "%COMMITS%"=="0" (
    color 0A
    echo  [OK] Already up to date!
    echo.
    echo  Press any key to close...
    pause >nul
    exit /b 0
)

echo  [INFO] %COMMITS% new update(s) found
echo.
echo  Updating...
echo  -----------------------------------
"%GIT%" pull origin main
if %errorlevel%==0 (
    color 0A
    echo  -----------------------------------
    echo.
    echo  [OK] Update complete!
) else (
    color 0C
    echo  -----------------------------------
    echo.
    echo  [ERROR] Update failed!
    echo  Try deleting changed files and run again.
)

echo.
echo  Press any key to close...
pause >nul