import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_model.dart';
import '../../domain/entities/chat_entity.dart' show ChatType;

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel({
    required String id,
    required ChatType type,
    required List<String> participantIds,
    required Map<String, ParticipantInfo> participants,
    String? name,  // Direct name field for group chats (from Firestore root)
    String? avatarUrl,  // Direct avatar field for group chats (from Firestore root)
    MessageModel? lastMessage,
    @Default({}) Map<String, int> unreadCounts,
    @Default({}) Map<String, String> lastReadTimestamps,
    @Default({}) Map<String, bool> typingStatus,
    @Default({}) Map<String, bool> mutedBy,
    @Default({}) Map<String, String> pinnedBy,
    @Default({}) Map<String, String> archivedBy,
    GroupInfoModel? groupInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? draftMessage,
    @Default([]) List<String> pinnedMessageIds,
    EncryptionInfo? encryptionInfo,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) => 
      _$ChatModelFromJson(json);
      
  factory ChatModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    print('🔍 [CHAT_MODEL] Parsing chat ${doc.id}');
    print('🔍 [CHAT_MODEL] Raw data keys: ${data.keys.toList()}');
    
    // Helper function to parse date that might be Timestamp or String
    String? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate().toIso8601String();
      if (value is String) return value;
      return null;
    }
    
    // Parse chat type safely
    ChatType parsedType = ChatType.private;
    final typeStr = data['type'] as String?;
    if (typeStr != null) {
      switch (typeStr.toLowerCase()) {
        case 'group':
          parsedType = ChatType.group;
          break;
        case 'channel':
          parsedType = ChatType.channel;
          break;
        default:
          parsedType = ChatType.private;
      }
    }
    print('🔍 [CHAT_MODEL] Parsed type: $parsedType');
    
    // Parse participants safely
    final participantsRaw = data['participants'] as Map<String, dynamic>? ?? {};
    final participants = <String, Map<String, dynamic>>{};
    for (final entry in participantsRaw.entries) {
      if (entry.value is Map<String, dynamic>) {
        final participant = Map<String, dynamic>.from(entry.value);
        // Convert lastSeen Timestamp if present
        if (participant['lastSeen'] is Timestamp) {
          participant['lastSeen'] = (participant['lastSeen'] as Timestamp).toDate().toIso8601String();
        }
        if (participant['joinedAt'] is Timestamp) {
          participant['joinedAt'] = (participant['joinedAt'] as Timestamp).toDate().toIso8601String();
        }
        participants[entry.key] = participant;
      }
    }
    print('🔍 [CHAT_MODEL] Parsed ${participants.length} participants');
    
    // Parse lastMessage safely
    Map<String, dynamic>? lastMessageData;
    if (data['lastMessage'] is Map<String, dynamic>) {
      lastMessageData = Map<String, dynamic>.from(data['lastMessage']);
      if (lastMessageData['createdAt'] is Timestamp) {
        lastMessageData['createdAt'] = (lastMessageData['createdAt'] as Timestamp).toDate().toIso8601String();
      }
      if (lastMessageData['editedAt'] is Timestamp) {
        lastMessageData['editedAt'] = (lastMessageData['editedAt'] as Timestamp).toDate().toIso8601String();
      }
      if (lastMessageData['deletedAt'] is Timestamp) {
        lastMessageData['deletedAt'] = (lastMessageData['deletedAt'] as Timestamp).toDate().toIso8601String();
      }
      final textPreview = lastMessageData['text']?.toString() ?? 'no text';
      print('🔍 [CHAT_MODEL] Has lastMessage: ${textPreview.length > 20 ? textPreview.substring(0, 20) : textPreview}...');
    }
    
    // Parse groupInfo safely
    Map<String, dynamic>? groupInfoData;
    if (data['groupInfo'] is Map<String, dynamic>) {
      groupInfoData = Map<String, dynamic>.from(data['groupInfo']);
      if (groupInfoData['createdAt'] is Timestamp) {
        groupInfoData['createdAt'] = (groupInfoData['createdAt'] as Timestamp).toDate().toIso8601String();
      }
      if (groupInfoData['inviteLinkExpiry'] is Timestamp) {
        groupInfoData['inviteLinkExpiry'] = (groupInfoData['inviteLinkExpiry'] as Timestamp).toDate().toIso8601String();
      }
      print('🔍 [CHAT_MODEL] Has groupInfo: ${groupInfoData['name']}');
    }
    
    try {
      return ChatModel.fromJson({
        ...data,
        'id': doc.id,
        'type': parsedType.name,
        'participants': participants,
        'lastMessage': lastMessageData,
        'groupInfo': groupInfoData,
        'createdAt': parseDate(data['createdAt']),
        'updatedAt': parseDate(data['updatedAt']),
      });
    } catch (e, stackTrace) {
      print('❌ [CHAT_MODEL] Error parsing chat ${doc.id}: $e');
      print('❌ [CHAT_MODEL] Stack trace: $stackTrace');
      rethrow;
    }
  }
}

@freezed
class ParticipantInfo with _$ParticipantInfo {
  const factory ParticipantInfo({
    required String userId,
    required String displayName,
    String? avatarUrl,
    String? phoneNumber,
    @Default(false) bool isOnline,
    DateTime? lastSeen,
    @Default(GroupRole.member) GroupRole role,
    DateTime? joinedAt,
    String? addedBy,
  }) = _ParticipantInfo;

  factory ParticipantInfo.fromJson(Map<String, dynamic> json) => 
      _$ParticipantInfoFromJson(json);
}

@freezed
class GroupInfoModel with _$GroupInfoModel {
  const factory GroupInfoModel({
    required String name,
    String? description,
    String? avatarUrl,
    required String createdBy,
    required DateTime createdAt,
    @Default(GroupSettings()) GroupSettings settings,
    String? inviteLink,
    DateTime? inviteLinkExpiry,
  }) = _GroupInfoModel;

  factory GroupInfoModel.fromJson(Map<String, dynamic> json) => 
      _$GroupInfoModelFromJson(json);
}

@freezed
class GroupSettings with _$GroupSettings {
  const factory GroupSettings({
    @Default(true) bool membersCanAddMembers,
    @Default(true) bool membersCanEditInfo,
    @Default(true) bool membersCanSendMessages,
    @Default(false) bool approvalRequired,
    @Default(256) int maxMembers,
  }) = _GroupSettings;

  factory GroupSettings.fromJson(Map<String, dynamic> json) => 
      _$GroupSettingsFromJson(json);
}

enum GroupRole {
  @JsonValue('owner')
  owner,
  @JsonValue('admin')
  admin,
  @JsonValue('member')
  member,
}

@freezed
class EncryptionInfo with _$EncryptionInfo {
  const factory EncryptionInfo({
    required String sessionId,
    required String publicKey,
    DateTime? keyRotatedAt,
    @Default(true) bool isEnabled,
  }) = _EncryptionInfo;

  factory EncryptionInfo.fromJson(Map<String, dynamic> json) => 
      _$EncryptionInfoFromJson(json);
}
