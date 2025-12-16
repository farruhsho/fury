import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/chat_repository.dart';

class EditMessageUseCase {
  final ChatRepository repository;

  EditMessageUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String chatId,
    required String messageId,
    required String newText,
  }) async {
    return await repository.editMessage(
      chatId: chatId,
      messageId: messageId,
      newText: newText,
    );
  }

  /// Pin a message in the chat
  Future<void> pinMessage({
    required String chatId,
    required String messageId,
  }) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({
      'isPinned': true,
      'pinnedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Unpin a message in the chat
  Future<void> unpinMessage({
    required String chatId,
    required String messageId,
  }) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .update({
      'isPinned': false,
      'pinnedAt': FieldValue.delete(),
    });
  }
}
