import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Service for Picture-in-Picture mode during calls
/// 
/// Enables users to minimize the call screen while continuing
/// the call in a floating window. Currently supports Android only.
class PictureInPictureService {
  static final PictureInPictureService _instance = 
      PictureInPictureService._internal();
  
  factory PictureInPictureService() => _instance;
  
  PictureInPictureService._internal();

  static const MethodChannel _channel = MethodChannel('fury_chat/pip');
  
  bool _isPipAvailable = false;
  bool _isPipActive = false;
  
  /// Whether PiP mode is available on this device
  bool get isPipAvailable => _isPipAvailable;
  
  /// Whether PiP mode is currently active  
  bool get isPipActive => _isPipActive;
  
  /// Initialize the PiP service and check availability
  Future<void> initialize() async {
    if (kIsWeb) {
      _isPipAvailable = false;
      return;
    }
    
    try {
      if (Platform.isAndroid) {
        _isPipAvailable = await _channel.invokeMethod('isPipAvailable') ?? false;
        debugPrint('📺 [PIP] Available: $_isPipAvailable');
      } else if (Platform.isIOS) {
        // iOS uses native PiP for video playback, handled differently
        _isPipAvailable = false; // For now, iOS not supported
      } else {
        _isPipAvailable = false;
      }
    } catch (e) {
      debugPrint('❌ [PIP] Failed to check availability: $e');
      _isPipAvailable = false;
    }
  }
  
  /// Enter Picture-in-Picture mode
  /// 
  /// Returns true if PiP mode was successfully entered
  Future<bool> enterPip({
    int? width,
    int? height,
    double? aspectRatio,
  }) async {
    if (!_isPipAvailable || kIsWeb) return false;
    
    try {
      final params = <String, dynamic>{
        'width': width ?? 200,
        'height': height ?? 300,
        'aspectRatio': aspectRatio ?? (width != null && height != null 
            ? width / height 
            : 2 / 3),
      };
      
      _isPipActive = await _channel.invokeMethod('enterPip', params) ?? false;
      debugPrint('📺 [PIP] Entered: $_isPipActive');
      return _isPipActive;
    } catch (e) {
      debugPrint('❌ [PIP] Failed to enter: $e');
      return false;
    }
  }
  
  /// Exit Picture-in-Picture mode
  Future<bool> exitPip() async {
    if (!_isPipActive || kIsWeb) return true;
    
    try {
      final result = await _channel.invokeMethod('exitPip') ?? true;
      _isPipActive = !result;
      debugPrint('📺 [PIP] Exited: $result');
      return result;
    } catch (e) {
      debugPrint('❌ [PIP] Failed to exit: $e');
      return false;
    }
  }
  
  /// Check if currently in PiP mode
  Future<bool> isInPipMode() async {
    if (kIsWeb || !_isPipAvailable) return false;
    
    try {
      _isPipActive = await _channel.invokeMethod('isInPipMode') ?? false;
      return _isPipActive;
    } catch (e) {
      return false;
    }
  }
  
  /// Set PiP mode listener
  void setPipModeListener(void Function(bool isInPip) listener) {
    if (kIsWeb) return;
    
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onPipModeChanged') {
        final isInPip = call.arguments as bool? ?? false;
        _isPipActive = isInPip;
        listener(isInPip);
      }
      return null;
    });
  }
  
  /// Update PiP source rect (Android)
  Future<void> setSourceRect({
    required double left,
    required double top,
    required double right,
    required double bottom,
  }) async {
    if (!_isPipAvailable || kIsWeb) return;
    
    try {
      await _channel.invokeMethod('setSourceRect', {
        'left': left,
        'top': top,
        'right': right,
        'bottom': bottom,
      });
    } catch (e) {
      debugPrint('❌ [PIP] Failed to set source rect: $e');
    }
  }
  
  /// Configure auto-enter PiP when navigating away
  Future<void> setAutoEnterEnabled(bool enabled) async {
    if (!_isPipAvailable || kIsWeb) return;
    
    try {
      await _channel.invokeMethod('setAutoEnterEnabled', enabled);
    } catch (e) {
      debugPrint('❌ [PIP] Failed to set auto-enter: $e');
    }
  }
}

/// A mixin for StatefulWidgets that need PiP support
mixin PipSupportMixin<T extends StatefulWidget> {
  final PictureInPictureService _pipService = PictureInPictureService();
  bool _wasInPip = false;
  
  /// Initialize PiP for this widget
  Future<void> initializePip() async {
    await _pipService.initialize();
    _pipService.setPipModeListener(_onPipModeChanged);
  }
  
  /// Called when PiP mode changes
  void _onPipModeChanged(bool isInPip) {
    if (_wasInPip != isInPip) {
      _wasInPip = isInPip;
      onPipModeChanged(isInPip);
    }
  }
  
  /// Override to handle PiP mode changes
  void onPipModeChanged(bool isInPip);
  
  /// Enter PiP mode
  Future<bool> enterPip() => _pipService.enterPip();
  
  /// Exit PiP mode
  Future<bool> exitPip() => _pipService.exitPip();
  
  /// Whether PiP is available
  bool get isPipAvailable => _pipService.isPipAvailable;
  
  /// Whether currently in PiP
  bool get isInPip => _pipService.isPipActive;
}
