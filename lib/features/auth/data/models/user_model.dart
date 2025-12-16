import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    String? email,
    String? phoneNumber,
    String? username,
    String? displayName,
    String? bio,
    String? avatarUrl,
    String? avatarThumbnailUrl,
    @Default(false) bool isOnline,
    DateTime? lastSeen,
    @Default(PrivacySettings()) PrivacySettings privacySettings,
    @Default(NotificationSettings()) NotificationSettings notificationSettings,
    String? pushToken,
    String? voipToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default([]) List<String> blockedUserIds,
    @Default(UserStatus.active) UserStatus status,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => 
      _$UserModelFromJson(json);
  
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    // Convert Firestore Timestamps to ISO 8601 strings for json_serializable
    // The generated fromJson code expects DateTime values as ISO 8601 strings
    final processedData = <String, dynamic>{
      ...data,
      'id': doc.id,
    };
    
    // Handle Timestamp conversions - convert to ISO 8601 strings
    if (data['createdAt'] is Timestamp) {
      processedData['createdAt'] = (data['createdAt'] as Timestamp).toDate().toIso8601String();
    } else if (data['createdAt'] is DateTime) {
      processedData['createdAt'] = (data['createdAt'] as DateTime).toIso8601String();
    }
    if (data['updatedAt'] is Timestamp) {
      processedData['updatedAt'] = (data['updatedAt'] as Timestamp).toDate().toIso8601String();
    } else if (data['updatedAt'] is DateTime) {
      processedData['updatedAt'] = (data['updatedAt'] as DateTime).toIso8601String();
    }
    if (data['lastSeen'] is Timestamp) {
      processedData['lastSeen'] = (data['lastSeen'] as Timestamp).toDate().toIso8601String();
    } else if (data['lastSeen'] is DateTime) {
      processedData['lastSeen'] = (data['lastSeen'] as DateTime).toIso8601String();
    }
    
    return UserModel.fromJson(processedData);
  }
}

/// Extension to add Firestore-specific serialization
extension UserModelFirestore on UserModel {
  /// Convert to JSON with proper nested object serialization for Firestore
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    // Manually serialize nested objects
    json['privacySettings'] = privacySettings.toJson();
    json['notificationSettings'] = notificationSettings.toJson();
    return json;
  }
}

@freezed
class PrivacySettings with _$PrivacySettings {
  const factory PrivacySettings({
    @Default(PrivacyOption.everyone) PrivacyOption lastSeen,
    @Default(PrivacyOption.everyone) PrivacyOption profilePhoto,
    @Default(PrivacyOption.everyone) PrivacyOption about,
    @Default(PrivacyOption.everyone) PrivacyOption status,
    @Default(PrivacyOption.everyone) PrivacyOption groups,
    @Default(true) bool readReceipts,
  }) = _PrivacySettings;
  
  factory PrivacySettings.fromJson(Map<String, dynamic> json) => 
      _$PrivacySettingsFromJson(json);
}

@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    @Default(true) bool enabled,
    @Default(true) bool sound,
    @Default(true) bool vibration,
    @Default(true) bool showPreview,
    @Default(true) bool messageNotifications,
    @Default(true) bool groupNotifications,
    @Default(true) bool callNotifications,
  }) = _NotificationSettings;
  
  factory NotificationSettings.fromJson(Map<String, dynamic> json) => 
      _$NotificationSettingsFromJson(json);
}

enum PrivacyOption {
  @JsonValue('everyone')
  everyone,
  @JsonValue('contacts')
  contacts,
  @JsonValue('nobody')
  nobody,
}

enum UserStatus {
  @JsonValue('active')
  active,
  @JsonValue('suspended')
  suspended,
  @JsonValue('deleted')
  deleted,
}
