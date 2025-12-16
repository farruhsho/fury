@echo off
echo Building Fury for all platforms...
echo.

echo [1/4] Building Android APK...
call flutter build apk
if %errorlevel% neq 0 (
    echo Error building Android APK
    pause
    exit /b %errorlevel%
)
echo Android APK built successfully!
echo.

echo [2/4] Building Web...
call flutter build web
if %errorlevel% neq 0 (
    echo Error building Web
    pause
    exit /b %errorlevel%
)
echo Web built successfully!
echo.

echo [3/4] Building Windows...
call flutter build windows
if %errorlevel% neq 0 (
    echo Error building Windows
    pause
    exit /b %errorlevel%
)
echo Windows built successfully!
echo.

echo [4/4] All builds completed!
echo.
echo Build locations:
echo - Android APK: build\app\outputs\flutter-apk\app-release.apk
echo - Web: build\web\
echo - Windows: build\windows\x64\runner\Release\
echo.
pause
