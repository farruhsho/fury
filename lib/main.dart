import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'app/app.dart';
import 'core/config/app_config.dart';
import 'core/di/injection_container.dart' as di;

/// Entry point of the Fury Chat application
///
/// This function initializes all required services before running the app:
/// 1. Flutter bindings
/// 2. Firebase services
/// 3. Dependency injection (GetIt)
/// 4. System UI configuration
Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Print app configuration (only in development)
  AppConfig.printConfig();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configure Firestore for offline-first experience
  // This enables local caching so users can access chats/messages without network
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: 100 * 1024 * 1024, // 100 MB cache
  );

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize dependency injection container
  // This registers all services, repositories, use cases, and BLoCs
  await di.init();

  // Set preferred system UI overlay style (for dark theme)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,  // Light icons for dark background
      systemNavigationBarColor: Color(0xFF0B141A),  // WhatsApp dark
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Set preferred orientations (portrait only for better UX)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Run the app
  runApp(const FuryChatApp());
}
