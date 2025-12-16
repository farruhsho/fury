import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Service for muting chats
class ChatMuteService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ChatMuteService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Mute a chat
  Future<void> muteChat({
    required String chatId,
    Duration? duration, // null = forever
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    DateTime? muteUntil;
    if (duration != null) {
      muteUntil = DateTime.now().add(duration);
    }

    await _firestore.collection('users').doc(userId).update({
      'mutedChats': FieldValue.arrayUnion([chatId]),
      if (muteUntil != null) 'muteSettings.$chatId': muteUntil.toIso8601String(),
    });

    print('🔇 [MUTE] Chat muted: $chatId');
  }

  /// Unmute a chat
  Future<void> unmuteChat(String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).update({
      'mutedChats': FieldValue.arrayRemove([chatId]),
      'muteSettings.$chatId': FieldValue.delete(),
    });

    print('🔇 [MUTE] Chat unmuted: $chatId');
  }

  /// Check if chat is muted
  Future<bool> isMuted(String chatId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return false;

    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return false;

    final data = doc.data();
    final mutedChats = List<String>.from(data?['mutedChats'] ?? []);
    
    if (!mutedChats.contains(chatId)) return false;

    // Check if mute has expired
    final muteSettings = data?['muteSettings'] as Map<String, dynamic>?;
    if (muteSettings != null && muteSettings[chatId] != null) {
      final muteUntil = DateTime.tryParse(muteSettings[chatId] as String);
      if (muteUntil != null && muteUntil.isBefore(DateTime.now())) {
        // Mute expired, unmute
        await unmuteChat(chatId);
        return false;
      }
    }

    return true;
  }

  /// Toggle mute status
  Future<bool> toggleMute(String chatId) async {
    final isMutedNow = await isMuted(chatId);
    
    if (isMutedNow) {
      await unmuteChat(chatId);
      return false;
    } else {
      await muteChat(chatId: chatId);
      return true;
    }
  }

  /// Get list of muted chats
  Future<List<String>> getMutedChats() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return [];

    final data = doc.data();
    return List<String>.from(data?['mutedChats'] ?? []);
  }

  /// Listen to muted chats
  Stream<List<String>> listenToMutedChats() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) return <String>[];
      return List<String>.from(snapshot.data()?['mutedChats'] ?? []);
    });
  }
}

/// Mute duration options
enum MuteDuration {
  oneHour,
  eightHours,
  oneDay,
  sevenDays,
  forever,
}

extension MuteDurationExtension on MuteDuration {
  Duration? get duration {
    switch (this) {
      case MuteDuration.oneHour:
        return const Duration(hours: 1);
      case MuteDuration.eightHours:
        return const Duration(hours: 8);
      case MuteDuration.oneDay:
        return const Duration(days: 1);
      case MuteDuration.sevenDays:
        return const Duration(days: 7);
      case MuteDuration.forever:
        return null;
    }
  }

  String get label {
    switch (this) {
      case MuteDuration.oneHour:
        return '1 hour';
      case MuteDuration.eightHours:
        return '8 hours';
      case MuteDuration.oneDay:
        return '1 day';
      case MuteDuration.sevenDays:
        return '1 week';
      case MuteDuration.forever:
        return 'Forever';
    }
  }
}
