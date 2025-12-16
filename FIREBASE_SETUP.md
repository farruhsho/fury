# Firebase Phone Authentication Setup

## Проблема: `operation-not-allowed`

Эта ошибка возникает когда Phone Authentication не включена в Firebase Console.

## ✅ Решение 1: Включить Phone Auth в Firebase Console

### Шаг 1: Откройте Firebase Console
1. Перейдите на https://console.firebase.google.com
2. Выберите ваш проект (или создайте новый)

### Шаг 2: Включите Phone Authentication
1. В левом меню выберите **Authentication**
2. Перейдите на вкладку **Sign-in method**
3. Найдите **Phone** в списке провайдеров
4. Нажмите на **Phone**
5. Переключите тумблер **Enable** в положение ON
6. Нажмите **Save**

### Шаг 3: Настройте Test Phone Numbers (для разработки)
Для тестирования без реальных SMS:

1. В разделе **Authentication** → **Sign-in method**
2. Прокрутите вниз до раздела **Phone numbers for testing**
3. Нажмите **Add phone number**
4. Добавьте тестовые номера:
   - Номер: `+1234567890`
   - Код: `123456`
   - Добавьте еще несколько для удобства

**Важно:** Эти номера НЕ будут отправлять реальные SMS, но будут работать в приложении!

### Шаг 4: Обновите firebase_options.dart (если нужно)
Если вы создали новый проект Firebase:

```bash
# Установите Firebase CLI (если еще не установлен)
npm install -g firebase-tools

# Войдите в Firebase
firebase login

# Настройте проект
flutterfire configure
```

Выберите ваш Firebase проект и платформы (Android, iOS, Web, Windows, macOS).

---

## 🧪 Решение 2: Использовать Mock Authentication (для разработки)

Если вы хотите разрабатывать без настройки Firebase, можно использовать mock authentication.

### Создайте переменную окружения для dev mode:

**lib/core/config/app_config.dart:**
```dart
class AppConfig {
  // Режим разработки - использовать mock auth без Firebase
  static const bool isDevelopmentMode = true; // Измените на false для продакшена

  // Mock credentials для тестирования
  static const String mockPhoneNumber = '+1234567890';
  static const String mockOTPCode = '123456';

  // Firebase settings
  static const bool useFirebaseAuth = !isDevelopmentMode;
}
```

### Обновите AuthRemoteDatasource:

Добавьте проверку dev mode в методы аутентификации.

---

## 🚀 Решение 3: Быстрый старт (рекомендуется)

### Используйте тестовые номера Firebase:

1. **Включите Phone Auth** в Firebase Console (см. выше)
2. **Добавьте тестовые номера:**
   - `+1234567890` → код `123456`
   - `+9876543210` → код `654321`
   - `+1111111111` → код `111111`

3. **В приложении используйте эти номера:**
   - Введите `+1234567890`
   - Введите код `123456`
   - Вы войдете без реальной отправки SMS!

**Преимущества:**
- ✅ Работает без реальных SMS
- ✅ Не тратит деньги на SMS
- ✅ Быстрое тестирование
- ✅ Не нужно настраивать телефонные номера

**Недостатки:**
- ⚠️ Только для разработки
- ⚠️ Нужно помнить коды

---

## 📱 Решение 4: Настройка для Production

Для продакшн приложения:

### Android (для реальных SMS):

1. **SHA-1 fingerprint:**
   ```bash
   # Debug keystore
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

   # Release keystore (замените пути на свои)
   keytool -list -v -keystore path/to/your/release.keystore -alias your-alias
   ```

2. **Добавьте SHA-1 в Firebase:**
   - Firebase Console → Project Settings → Your apps → Android app
   - Добавьте SHA-1 fingerprint

3. **Скачайте google-services.json:**
   - Firebase Console → Project Settings → Download google-services.json
   - Поместите в `android/app/google-services.json`

### iOS (для реальных SMS):

1. **APNs Authentication Key:**
   - Apple Developer → Keys → Create new key
   - Enable APNs
   - Download .p8 file

2. **Загрузите в Firebase:**
   - Firebase Console → Project Settings → Cloud Messaging → iOS app configuration
   - Upload APNs Authentication Key

3. **App ID capabilities:**
   - Apple Developer → Identifiers → Your App ID
   - Enable "Push Notifications"

### Web (reCAPTCHA):

1. **reCAPTCHA автоматически настроен** в Firebase

2. **Добавьте домен в authorized domains:**
   - Firebase Console → Authentication → Settings → Authorized domains
   - Добавьте ваш домен (например, `localhost` для разработки)

---

## 🔧 Проверка настройки:

### Проверьте firebase_options.dart:

Убедитесь, что файл содержит правильные API ключи:

```dart
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      // ...
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR-API-KEY',
    appId: 'YOUR-APP-ID',
    messagingSenderId: 'YOUR-SENDER-ID',
    projectId: 'YOUR-PROJECT-ID',
    // ...
  );
}
```

### Проверьте статус в коде:

Добавьте логирование в AuthRemoteDatasource:

```dart
Future<void> sendOTP(String phoneNumber) async {
  try {
    print('🔵 Отправка OTP на номер: $phoneNumber');
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) {
        print('✅ Автоматическая верификация завершена');
      },
      verificationFailed: (error) {
        print('❌ Ошибка верификации: ${error.code} - ${error.message}');
      },
      codeSent: (verificationId, forceResendingToken) {
        print('✅ Код отправлен. ID: $verificationId');
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print('⏱️ Тайм-аут автоматической верификации');
      },
    );
  } catch (e) {
    print('💥 Исключение при отправке OTP: $e');
    rethrow;
  }
}
```

---

## 🎯 Быстрая настройка (5 минут):

### Вариант A: С Firebase (рекомендуется)

1. ✅ Откройте Firebase Console
2. ✅ Authentication → Sign-in method → Phone → Enable
3. ✅ Добавьте тестовый номер: `+1234567890` → код `123456`
4. ✅ Запустите приложение: `flutter run`
5. ✅ Войдите с номером `+1234567890` и кодом `123456`

**Готово!** Приложение работает без реальных SMS.

### Вариант B: Без Firebase (dev mode)

Создайте файл с mock данными и обновите datasource для использования mock auth в dev режиме.

---

## 📋 Checklist:

### Минимальная настройка (для разработки):
- [ ] Firebase проект создан
- [ ] Phone Authentication включена в Console
- [ ] Тестовые номера добавлены
- [ ] `firebase_options.dart` содержит правильные ключи
- [ ] Приложение запускается без ошибок

### Полная настройка (для production):
- [ ] Phone Authentication включена
- [ ] Android: SHA-1 fingerprint добавлен
- [ ] Android: google-services.json скачан
- [ ] iOS: APNs ключ загружен
- [ ] iOS: Push Notifications включены
- [ ] Web: Authorized domains настроены
- [ ] Firestore Security Rules настроены
- [ ] Firebase Storage Rules настроены
- [ ] Firebase Messaging настроен
- [ ] Billing включен (для SMS в production)

---

## ❗ Важные замечания:

### Для Web платформы:
Firebase Phone Auth на Web требует reCAPTCHA. По умолчанию работает только в браузере (не в mobile web view).

### Для Windows/macOS/Linux:
Phone Auth **НЕ поддерживается** напрямую. Используйте:
- Тестовые номера Firebase (как обходной путь)
- Или альтернативную аутентификацию (Email/Password, Google Sign-In)

### Стоимость SMS:
- Первые 10,000 верификаций/месяц - **бесплатно**
- Далее: ~$0.01-0.06 за SMS (зависит от страны)
- Тестовые номера **не тратят лимиты**

---

## 🆘 Troubleshooting:

### Ошибка: "operation-not-allowed"
**Решение:** Включите Phone Authentication в Firebase Console

### Ошибка: "invalid-phone-number"
**Решение:** Используйте международный формат: `+[country_code][number]`
Примеры: `+79991234567` (Россия), `+998901234567` (Узбекистан)

### Ошибка: "too-many-requests"
**Решение:**
- Подождите несколько минут
- Используйте тестовые номера
- Очистите кеш Firebase Auth

### SMS не приходят:
**Решение:**
1. Проверьте Firebase Billing (платежи включены?)
2. Проверьте SHA-1 fingerprint (Android)
3. Проверьте APNs ключ (iOS)
4. Используйте тестовые номера для разработки

### Приложение не запускается:
**Решение:**
```bash
flutter clean
flutter pub get
flutter run
```

---

## 📚 Полезные ссылки:

- [Firebase Phone Auth Documentation](https://firebase.google.com/docs/auth/flutter/phone-auth)
- [Firebase Console](https://console.firebase.google.com)
- [FlutterFire CLI](https://firebase.flutter.dev/docs/cli)
- [Phone Auth для Web](https://firebase.google.com/docs/auth/web/phone-auth)

---

## 💡 Рекомендация для начала:

**Используйте тестовые номера Firebase!**

Это самый быстрый способ начать разработку:
1. 5 минут на настройку
2. Бесплатно
3. Без реальных SMS
4. Работает на всех платформах

Когда будете готовы к production → настройте реальные SMS.

