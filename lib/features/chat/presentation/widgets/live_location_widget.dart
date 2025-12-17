import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';

/// Live location sharing widget with duration options (15min, 1h, 8h)
class LiveLocationWidget extends StatefulWidget {
  final String chatId;
  final String? existingShareId;
  final VoidCallback? onClose;

  const LiveLocationWidget({
    super.key,
    required this.chatId,
    this.existingShareId,
    this.onClose,
  });

  @override
  State<LiveLocationWidget> createState() => _LiveLocationWidgetState();
}

class _LiveLocationWidgetState extends State<LiveLocationWidget> {
  Position? _currentPosition;
  StreamSubscription<Position>? _positionSubscription;
  Timer? _expiryTimer;
  bool _isSharing = false;
  Duration? _remainingTime;
  String? _shareId;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    if (widget.existingShareId != null) {
      _shareId = widget.existingShareId;
      _isSharing = true;
      _startTracking();
    }
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _expiryTimer?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) {
        setState(() => _currentPosition = position);
      }
    } catch (e) {
      print('❌ [LOCATION] Error getting location: $e');
    }
  }

  void _startTracking() {
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
      ),
    ).listen((position) {
      if (mounted) {
        setState(() => _currentPosition = position);
        _updateFirestoreLocation(position);
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(position.latitude, position.longitude),
          ),
        );
      }
    });
  }

  Future<void> _startSharing(Duration duration) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null || _currentPosition == null) return;

    final endTime = DateTime.now().add(duration);

    // Create live location share in Firestore
    final docRef = await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('liveLocations')
        .add({
      'userId': userId,
      'startTime': FieldValue.serverTimestamp(),
      'endTime': Timestamp.fromDate(endTime),
      'latitude': _currentPosition!.latitude,
      'longitude': _currentPosition!.longitude,
      'isActive': true,
    });

    _shareId = docRef.id;
    _startTracking();

    // Start expiry countdown
    _remainingTime = duration;
    _expiryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime != null) {
        if (_remainingTime!.inSeconds <= 0) {
          _stopSharing();
        } else {
          if (mounted) {
            setState(() {
              _remainingTime = _remainingTime! - const Duration(seconds: 1);
            });
          }
        }
      }
    });

    if (mounted) {
      setState(() => _isSharing = true);
    }
  }

  Future<void> _updateFirestoreLocation(Position position) async {
    if (_shareId == null) return;

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('liveLocations')
        .doc(_shareId)
        .update({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _stopSharing() async {
    _positionSubscription?.cancel();
    _expiryTimer?.cancel();

    if (_shareId != null) {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(widget.chatId)
          .collection('liveLocations')
          .doc(_shareId)
          .update({'isActive': false});
    }

    if (mounted) {
      setState(() {
        _isSharing = false;
        _remainingTime = null;
        _shareId = null;
      });
    }

    widget.onClose?.call();
  }

  void _openInMaps() {
    if (_currentPosition == null) return;
    final url = 'https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude},${_currentPosition!.longitude}';
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    }
    return '${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  _isSharing ? Icons.location_on : Icons.location_searching,
                  color: _isSharing ? Colors.green : AppColors.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _isSharing ? 'Sharing Live Location' : 'Share Live Location',
                    style: AppTypography.h3,
                  ),
                ),
                if (_isSharing && _remainingTime != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _formatDuration(_remainingTime!),
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Map Preview
          if (_currentPosition != null)
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              clipBehavior: Clip.antiAlias,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                  ),
                  zoom: 15,
                ),
                onMapCreated: (controller) => _mapController = controller,
                markers: {
                  Marker(
                    markerId: const MarkerId('currentLocation'),
                    position: LatLng(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude,
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure,
                    ),
                  ),
                },
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),
            )
          else
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),

          const SizedBox(height: 16),

          // Actions
          if (_isSharing)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _openInMaps,
                      icon: const Icon(Icons.map),
                      label: const Text('Open in Maps'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _stopSharing,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.stop),
                      label: const Text('Stop Sharing'),
                    ),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Share for:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildDurationButton('15 min', const Duration(minutes: 15)),
                      const SizedBox(width: 8),
                      _buildDurationButton('1 hour', const Duration(hours: 1)),
                      const SizedBox(width: 8),
                      _buildDurationButton('8 hours', const Duration(hours: 8)),
                    ],
                  ),
                ],
              ),
            ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDurationButton(String label, Duration duration) {
    return Expanded(
      child: ElevatedButton(
        onPressed: _currentPosition != null
            ? () => _startSharing(duration)
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(label),
      ),
    );
  }
}

/// Widget to display other user's live location
class LiveLocationViewer extends StatelessWidget {
  final String chatId;
  final String shareId;

  const LiveLocationViewer({
    super.key,
    required this.chatId,
    required this.shareId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('liveLocations')
          .doc(shareId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const SizedBox.shrink();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final lat = data['latitude'] as double;
        final lng = data['longitude'] as double;
        final isActive = data['isActive'] as bool? ?? false;
        final endTime = (data['endTime'] as Timestamp?)?.toDate();

        if (!isActive) {
          return const Chip(
            label: Text('Location sharing ended'),
            backgroundColor: Colors.grey,
          );
        }

        return GestureDetector(
          onTap: () {
            final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
            launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on, color: Colors.green),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Live Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    if (endTime != null)
                      Text(
                        'Ends ${_formatEndTime(endTime)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green.shade700,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 8),
                const Icon(Icons.open_in_new, size: 16, color: Colors.green),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatEndTime(DateTime endTime) {
    final diff = endTime.difference(DateTime.now());
    if (diff.isNegative) return 'soon';
    if (diff.inHours > 0) return 'in ${diff.inHours}h ${diff.inMinutes % 60}m';
    if (diff.inMinutes > 0) return 'in ${diff.inMinutes}m';
    return 'in ${diff.inSeconds}s';
  }
}
