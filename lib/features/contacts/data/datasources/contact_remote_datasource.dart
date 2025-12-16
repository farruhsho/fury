import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/contact_model.dart';

class ContactRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ContactRemoteDatasource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  Stream<List<ContactModel>> getContacts() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('contacts')
        .where('isBlocked', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ContactModel.fromFirestore(doc)).toList();
    });
  }

  Future<List<ContactModel>> searchUsers(String query) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    // Search by username
    final usernameQuery = await _firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query.toLowerCase())
        .where('username', isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
        .limit(20)
        .get();

    // Search by phone number
    final phoneQuery = await _firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: query)
        .limit(20)
        .get();

    final users = <ContactModel>[];
    final seenIds = <String>{};

    for (final doc in [...usernameQuery.docs, ...phoneQuery.docs]) {
      if (doc.id != userId && !seenIds.contains(doc.id)) {
        seenIds.add(doc.id);
        final data = doc.data();
        users.add(ContactModel(
          id: doc.id,
          userId: doc.id,
          displayName: data['displayName'] as String? ?? 'Unknown',
          phoneNumber: data['phoneNumber'] as String,
          username: data['username'] as String?,
          avatarUrl: data['avatarUrl'] as String?,
          bio: data['bio'] as String?,
          isOnline: data['isOnline'] as bool? ?? false,
          lastSeen: data['lastSeen'] != null
              ? (data['lastSeen'] as Timestamp).toDate()
              : null,
        ));
      }
    }

    return users;
  }

  Future<void> addContact(String contactUserId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    // Get contact user data
    final userDoc = await _firestore.collection('users').doc(contactUserId).get();
    if (!userDoc.exists) {
      throw const ServerException(message: 'User not found');
    }

    final userData = userDoc.data()!;

    // Add to contacts
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('contacts')
        .doc(contactUserId)
        .set({
      'userId': contactUserId,
      'displayName': userData['displayName'],
      'phoneNumber': userData['phoneNumber'],
      'username': userData['username'],
      'avatarUrl': userData['avatarUrl'],
      'bio': userData['bio'],
      'isBlocked': false,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeContact(String contactId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('contacts')
        .doc(contactId)
        .delete();
  }

  Future<void> blockContact(String contactId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('contacts')
        .doc(contactId)
        .update({'isBlocked': true});
  }

  Future<void> unblockContact(String contactId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('contacts')
        .doc(contactId)
        .update({'isBlocked': false});
  }

  Future<List<ContactModel>> getBlockedContacts() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('contacts')
        .where('isBlocked', isEqualTo: true)
        .get();

    return snapshot.docs.map((doc) => ContactModel.fromFirestore(doc)).toList();
  }

  Future<List<ContactModel>> syncPhoneContacts(List<String> phoneNumbers) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw const AuthException(message: 'User not authenticated');

    final users = <ContactModel>[];

    // Query users by phone numbers (in batches of 10 due to Firestore 'in' limit)
    for (var i = 0; i < phoneNumbers.length; i += 10) {
      final batch = phoneNumbers.skip(i).take(10).toList();
      final snapshot = await _firestore
          .collection('users')
          .where('phoneNumber', whereIn: batch)
          .get();

      for (final doc in snapshot.docs) {
        if (doc.id != userId) {
          final data = doc.data();
          users.add(ContactModel(
            id: doc.id,
            userId: doc.id,
            displayName: data['displayName'] as String? ?? 'Unknown',
            phoneNumber: data['phoneNumber'] as String,
            username: data['username'] as String?,
            avatarUrl: data['avatarUrl'] as String?,
            bio: data['bio'] as String?,
            isOnline: data['isOnline'] as bool? ?? false,
            lastSeen: data['lastSeen'] != null
                ? (data['lastSeen'] as Timestamp).toDate()
                : null,
          ));
        }
      }
    }

    return users;
  }
}
