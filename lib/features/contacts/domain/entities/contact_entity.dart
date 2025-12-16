import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_entity.freezed.dart';

@freezed
class ContactEntity with _$ContactEntity {
  const factory ContactEntity({
    required String id,
    required String userId,
    required String displayName,
    required String phoneNumber,
    String? username,
    String? avatarUrl,
    String? bio,
    bool? isOnline,
    DateTime? lastSeen,
    bool? isBlocked,
    DateTime? addedAt,
  }) = _ContactEntity;
}
