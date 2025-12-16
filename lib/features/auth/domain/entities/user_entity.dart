import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

/// User entity for domain layer
@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    String? email,
    String? phoneNumber,
    String? username,
    String? displayName,
    String? bio,
    String? avatarUrl,
    bool? isOnline,
    DateTime? lastSeen,
  }) = _UserEntity;
}
