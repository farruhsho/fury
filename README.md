# Fury Chat

Профессиональное мессенджер-приложение с real-time чатом, голосовыми/видео звонками и stories.

Flutter мультиплатформенное приложение, которое можно запускать на Android, iOS, Web, Windows, macOS и Linux.

## Требования

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (последняя стабильная версия)
- Для Android: Android Studio с Android SDK
- Для iOS/macOS: Xcode (только на macOS)
- Для Windows: Visual Studio 2022 с C++ desktop development
- Для Web: Chrome или любой современный браузер

## Установка зависимостей

```bash
flutter pub get
```

## Запуск на разных платформах

### Android

#### Через USB подключение:
1. Включите режим разработчика на Android устройстве
2. Включите отладку по USB
3. Подключите устройство к компьютеру
4. Запустите:
```bash
flutter run
```

#### Через эмулятор:
1. Запустите эмулятор Android через Android Studio
2. Запустите:
```bash
flutter run
```

#### Сборка APK:
```bash
flutter build apk
```
APK файл будет находиться в `build/app/outputs/flutter-apk/app-release.apk`

#### Сборка App Bundle (для Google Play):
```bash
flutter build appbundle
```

### Web

#### Запуск в режиме разработки:
```bash
flutter run -d chrome
```

#### Сборка для продакшена:
```bash
flutter build web
```
Файлы будут в папке `build/web/`

#### Локальный веб-сервер:
После сборки можете запустить локальный сервер:
```bash
cd build/web
python -m http.server 8000
```
Затем откройте `http://localhost:8000` в браузере

### Windows

```bash
flutter run -d windows
```

#### Сборка:
```bash
flutter build windows
```
Файлы будут в `build/windows/x64/runner/Release/`

### macOS

```bash
flutter run -d macos
```

#### Сборка:
```bash
flutter build macos
```

### Linux

```bash
flutter run -d linux
```

#### Сборка:
```bash
flutter build linux
```

## Быстрые команды

### Проверка доступных устройств:
```bash
flutter devices
```

### Запуск на конкретном устройстве:
```bash
flutter run -d <device_id>
```

### Hot reload в процессе разработки:
Нажмите `r` в терминале где запущено приложение

### Hot restart:
Нажмите `R` в терминале

### Проверка установки Flutter:
```bash
flutter doctor
```

## Полезные команды

### Очистка кеша:
```bash
flutter clean
flutter pub get
```

### Обновление зависимостей:
```bash
flutter pub upgrade
```

### Анализ кода:
```bash
flutter analyze
```

### Запуск тестов:
```bash
flutter test
```

## Конфигурация для разных окружений

Для разработки с разными окружениями (dev, staging, production) можно использовать:

```bash
flutter run --dart-define=ENV=dev
flutter run --dart-define=ENV=production
```

## Деплой

### Android (Google Play Store)
1. Создайте keystore для подписи:
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. Создайте `android/key.properties`:
```properties
storePassword=<password>
keyPassword=<password>
keyAlias=upload
storeFile=<path-to-keystore>
```

3. Обновите `android/app/build.gradle.kts` для использования keystore

4. Соберите App Bundle:
```bash
flutter build appbundle
```

### Web (Хостинг)
1. Соберите проект:
```bash
flutter build web --release
```

2. Загрузите содержимое `build/web/` на ваш хостинг (Firebase Hosting, Netlify, Vercel, etc.)

#### Пример для Firebase:
```bash
firebase init hosting
firebase deploy
```

### iOS (App Store)
1. Откройте проект в Xcode:
```bash
open ios/Runner.xcworkspace
```

2. Настройте signing в Xcode
3. Соберите:
```bash
flutter build ios --release
```

4. Загрузите через Xcode в App Store Connect

## Отладка

### Просмотр логов:
```bash
flutter logs
```

### Запуск в режиме profile:
```bash
flutter run --profile
```

### Запуск в режиме release:
```bash
flutter run --release
```

## Структура проекта

```
fury/
├── android/          # Android конфигурация
├── ios/              # iOS конфигурация
├── web/              # Web конфигурация
├── windows/          # Windows конфигурация
├── macos/            # macOS конфигурация
├── linux/            # Linux конфигурация
├── lib/              # Исходный код Dart
│   └── main.dart     # Точка входа
├── test/             # Тесты
└── pubspec.yaml      # Зависимости проекта
```

## Известные проблемы

### Deprecated API warnings
Приложение использует некоторые API, помеченные как deprecated в Flutter 3.32+:
- `RadioListTile.groupValue` и `RadioListTile.onChanged` - планируется миграция на `RadioGroup`

Эти warnings не влияют на функциональность приложения и будут исправлены в следующих версиях.

### Временно отключенные функции
Следующие функции временно отключены из-за проблем совместимости с Windows:
- `image_cropper` - обрезка изображений
- `record` - запись аудио
- `agora_rtc_engine` - видео/аудио звонки через Agora

## Поддержка

При проблемах:
1. Запустите `flutter doctor` для диагностики
2. Проверьте [Flutter документацию](https://flutter.dev/docs)
3. Проверьте [GitHub Issues](https://github.com/flutter/flutter/issues)

## Лицензия

Частный проект
