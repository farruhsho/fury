import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Service to track network connectivity status
class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  final _connectivityController = StreamController<bool>.broadcast();
  
  bool _isOnline = true;
  StreamSubscription<ConnectivityResult>? _subscription;

  /// Whether the device currently has network connectivity
  bool get isOnline => _isOnline;

  /// Stream of connectivity status changes (true = online, false = offline)
  Stream<bool> get connectivityStream => _connectivityController.stream;

  /// Initialize the connectivity service and start monitoring
  Future<void> initialize() async {
    // Check initial connectivity
    final result = await _connectivity.checkConnectivity();
    _updateConnectivity(result);

    // Listen for changes
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectivity);
  }

  void _updateConnectivity(ConnectivityResult result) {
    final wasOnline = _isOnline;
    _isOnline = result != ConnectivityResult.none;
    
    if (wasOnline != _isOnline) {
      debugPrint('📶 [CONNECTIVITY] Status changed: ${_isOnline ? "ONLINE" : "OFFLINE"}');
      _connectivityController.add(_isOnline);
    }
  }

  /// Check current connectivity
  Future<bool> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectivity(result);
    return _isOnline;
  }

  /// Dispose the service
  void dispose() {
    _subscription?.cancel();
    _connectivityController.close();
  }
}

