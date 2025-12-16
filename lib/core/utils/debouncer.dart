import 'dart:async';
import 'package:flutter/foundation.dart';

/// Debouncer utility for delaying function execution
class Debouncer {
  final Duration delay;
  Timer? _timer;
  
  Debouncer({required this.delay});
  
  /// Run the action after the delay
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
  
  /// Cancel the pending action
  void cancel() {
    _timer?.cancel();
  }
  
  /// Dispose the debouncer
  void dispose() {
    _timer?.cancel();
  }
}

/// Throttler utility for limiting function execution frequency
class Throttler {
  final Duration duration;
  Timer? _timer;
  bool _isReady = true;
  
  Throttler({required this.duration});
  
  /// Run the action if ready
  void run(VoidCallback action) {
    if (_isReady) {
      _isReady = false;
      action();
      _timer = Timer(duration, () {
        _isReady = true;
      });
    }
  }
  
  /// Dispose the throttler
  void dispose() {
    _timer?.cancel();
  }
}
