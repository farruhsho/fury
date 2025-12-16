import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'contact_model.freezed.dart';
part 'contact_model.g.dart';

@freezed
class ContactModel with _$ContactModel {
  const factory ContactModel({
    required String id,
    required String userId,
    required String displayName,
    required String phoneNumber,
    String? username,
    String? avatarUrl,
    String? bio,
    @Default(false) bool isOnline,
    DateTime? lastSeen,
    @Default(false) bool isBlocked,
    DateTime? addedAt,
  }) = _ContactModel;

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);

  factory ContactModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ContactModel(
      id: doc.id,
      userId: data['userId'] as String,
      displayName: data['displayName'] as String,
      phoneNumber: data['phoneNumber'] as String,
      username: data['username'] as String?,
      avatarUrl: data['avatarUrl'] as String?,
      bio: data['bio'] as String?,
      isOnline: data['isOnline'] as bool? ?? false,
      lastSeen: data['lastSeen'] != null
          ? (data['lastSeen'] as Timestamp).toDate()
          : null,
      isBlocked: data['isBlocked'] as bool? ?? false,
      addedAt: data['addedAt'] != null
          ? (data['addedAt'] as Timestamp).toDate()
          : null,
    );
  }
}
