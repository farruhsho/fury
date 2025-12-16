#!/bin/bash

echo "Building Fury for all platforms..."
echo ""

# Check OS
OS_TYPE="$(uname -s)"

echo "[1/3] Building Web..."
flutter build web
if [ $? -ne 0 ]; then
    echo "Error building Web"
    exit 1
fi
echo "Web built successfully!"
echo ""

if [ "$OS_TYPE" = "Darwin" ]; then
    echo "[2/3] Building macOS..."
    flutter build macos
    if [ $? -ne 0 ]; then
        echo "Error building macOS"
        exit 1
    fi
    echo "macOS built successfully!"
    echo ""

    echo "[3/3] Building iOS..."
    flutter build ios --no-codesign
    if [ $? -ne 0 ]; then
        echo "Error building iOS"
        exit 1
    fi
    echo "iOS built successfully!"
    echo ""

    echo "All builds completed!"
    echo ""
    echo "Build locations:"
    echo "- Web: build/web/"
    echo "- macOS: build/macos/Build/Products/Release/"
    echo "- iOS: build/ios/iphoneos/"

elif [ "$OS_TYPE" = "Linux" ]; then
    echo "[2/3] Building Linux..."
    flutter build linux
    if [ $? -ne 0 ]; then
        echo "Error building Linux"
        exit 1
    fi
    echo "Linux built successfully!"
    echo ""

    echo "[3/3] Building Android APK..."
    flutter build apk
    if [ $? -ne 0 ]; then
        echo "Error building Android APK"
        exit 1
    fi
    echo "Android APK built successfully!"
    echo ""

    echo "All builds completed!"
    echo ""
    echo "Build locations:"
    echo "- Web: build/web/"
    echo "- Linux: build/linux/x64/release/bundle/"
    echo "- Android APK: build/app/outputs/flutter-apk/app-release.apk"
else
    echo "Unknown OS: $OS_TYPE"
    exit 1
fi

echo ""
