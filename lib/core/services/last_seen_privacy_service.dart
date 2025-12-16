import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Service for managing Last Seen privacy settings
class LastSeenPrivacyService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  LastSeenPrivacyService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Set last seen privacy setting
  Future<void> setLastSeenPrivacy(LastSeenPrivacy privacy) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).update({
      'lastSeenPrivacy': privacy.name,
    });

    print('👁️ [PRIVACY] Last seen set to: ${privacy.name}');
  }

  /// Get current last seen privacy setting
  Future<LastSeenPrivacy> getLastSeenPrivacy() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return LastSeenPrivacy.everyone;

    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return LastSeenPrivacy.everyone;

    final data = doc.data();
    final privacyString = data?['lastSeenPrivacy'] as String?;
    
    return LastSeenPrivacy.values.firstWhere(
      (p) => p.name == privacyString,
      orElse: () => LastSeenPrivacy.everyone,
    );
  }

  /// Check if user can see another user's last seen
  Future<bool> canSeeLastSeen(String targetUserId) async {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) return false;

    // Get target user's privacy setting
    final doc = await _firestore.collection('users').doc(targetUserId).get();
    if (!doc.exists) return false;

    final data = doc.data();
    final privacyString = data?['lastSeenPrivacy'] as String?;
    final privacy = LastSeenPrivacy.values.firstWhere(
      (p) => p.name == privacyString,
      orElse: () => LastSeenPrivacy.everyone,
    );

    switch (privacy) {
      case LastSeenPrivacy.everyone:
        return true;
      case LastSeenPrivacy.contacts:
        // Check if current user is in target's contacts
        final contactsDoc = await _firestore
            .collection('users')
            .doc(targetUserId)
            .collection('contacts')
            .doc(currentUserId)
            .get();
        return contactsDoc.exists;
      case LastSeenPrivacy.nobody:
        return false;
    }
  }

  /// Get last seen for a user (respecting privacy)
  Future<DateTime?> getLastSeen(String userId) async {
    final canSee = await canSeeLastSeen(userId);
    if (!canSee) return null;

    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return null;

    final data = doc.data();
    final lastSeen = data?['lastSeen'];
    
    if (lastSeen == null) return null;
    if (lastSeen is Timestamp) return lastSeen.toDate();
    if (lastSeen is String) return DateTime.tryParse(lastSeen);
    
    return null;
  }

  /// Set profile photo privacy
  Future<void> setProfilePhotoPrivacy(LastSeenPrivacy privacy) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).update({
      'profilePhotoPrivacy': privacy.name,
    });
  }

  /// Set about/bio privacy
  Future<void> setAboutPrivacy(LastSeenPrivacy privacy) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).update({
      'aboutPrivacy': privacy.name,
    });
  }
}

enum LastSeenPrivacy {
  everyone,
  contacts,
  nobody,
}

extension LastSeenPrivacyExtension on LastSeenPrivacy {
  String get label {
    switch (this) {
      case LastSeenPrivacy.everyone:
        return 'Everyone';
      case LastSeenPrivacy.contacts:
        return 'My contacts';
      case LastSeenPrivacy.nobody:
        return 'Nobody';
    }
  }

  String get description {
    switch (this) {
      case LastSeenPrivacy.everyone:
        return 'Anyone can see your last seen';
      case LastSeenPrivacy.contacts:
        return 'Only your contacts can see';
      case LastSeenPrivacy.nobody:
        return 'Your last seen is hidden';
    }
  }
}
