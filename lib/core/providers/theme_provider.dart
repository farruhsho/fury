import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../services/local_storage_service.dart';

/// Theme provider for managing dark/light mode
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;  // Default to dark for WhatsApp style
  LocalStorageService? _storageService;
  bool _isInitialized = false;
  
  ThemeMode get themeMode => _themeMode;
  
  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      return SchedulerBinding.instance.platformDispatcher.platformBrightness == 
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      _storageService = LocalStorageService();
      await _storageService!.init();
      _isInitialized = true;
      
      final savedTheme = _storageService!.getThemeMode();
      
      if (savedTheme != null) {
        switch (savedTheme) {
          case 'dark':
            _themeMode = ThemeMode.dark;
            break;
          case 'light':
            _themeMode = ThemeMode.light;
            break;
          default:
            _themeMode = ThemeMode.system;
        }
        notifyListeners();
      }
    } catch (e) {
      // Use system theme if loading fails
      _themeMode = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    
    if (_isInitialized && _storageService != null) {
      try {
        String themeString;
        switch (mode) {
          case ThemeMode.dark:
            themeString = 'dark';
            break;
          case ThemeMode.light:
            themeString = 'light';
            break;
          case ThemeMode.system:
            themeString = 'system';
            break;
        }
        
        await _storageService!.saveThemeMode(themeString);
      } catch (e) {
        // Ignore storage errors
      }
    }
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      setThemeMode(ThemeMode.light);
    } else {
      setThemeMode(ThemeMode.dark);
    }
  }

  void setDarkMode(bool dark) {
    setThemeMode(dark ? ThemeMode.dark : ThemeMode.light);
  }

  void useSystemTheme() {
    setThemeMode(ThemeMode.system);
  }
}

