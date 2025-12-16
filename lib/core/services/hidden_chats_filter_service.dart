import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Service for managing hidden chats filter in chat list
class HiddenChatsFilterService {
  final _firestore = FirebaseFirestore.instance;
  StreamSubscription? _subscription;
  Set<String> _hiddenChatIds = {};

  /// Stream of hidden chat IDs
  Stream<Set<String>> get hiddenChatIdsStream {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return Stream.value({});

    return _firestore
        .collection('users')
        .doc(userId)
        .collection('settings')
        .doc('hidden_chats')
        .snapshots()
        .map((doc) {
      if (!doc.exists) return <String>{};
      final data = doc.data();
      final chatIds = data?['chatIds'] as List? ?? [];
      return Set<String>.from(chatIds.cast<String>());
    });
  }

  /// Get current hidden chat IDs
  Future<Set<String>> getHiddenChatIds() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return {};

    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('settings')
        .doc('hidden_chats')
        .get();

    if (!doc.exists) return {};
    final data = doc.data();
    final chatIds = data?['chatIds'] as List? ?? [];
    return Set<String>.from(chatIds.cast<String>());
  }

  /// Check if a chat is hidden
  bool isChatHidden(String chatId) => _hiddenChatIds.contains(chatId);

  /// Start listening for hidden chats changes
  void startListening() {
    _subscription = hiddenChatIdsStream.listen((ids) {
      _hiddenChatIds = ids;
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}

/// Extension to filter chat lists
extension ChatListFilter on List<dynamic> {
  /// Filter out hidden chats
  List<T> excludeHidden<T>(Set<String> hiddenIds, String Function(T) getChatId) {
    return where((item) => !hiddenIds.contains(getChatId(item as T))).toList().cast<T>();
  }
}
