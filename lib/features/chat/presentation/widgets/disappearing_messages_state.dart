part of 'disappearing_messages.dart';

/// State for disappearing messages per chat
class DisappearingMessagesState {
  final String chatId;
  final DisappearingDuration duration;
  final DateTime? changedAt;
  final String? changedBy;

  const DisappearingMessagesState({
    required this.chatId,
    this.duration = DisappearingDuration.off,
    this.changedAt,
    this.changedBy,
  });

  DisappearingMessagesState copyWith({
    String? chatId,
    DisappearingDuration? duration,
    DateTime? changedAt,
    String? changedBy,
  }) {
    return DisappearingMessagesState(
      chatId: chatId ?? this.chatId,
      duration: duration ?? this.duration,
      changedAt: changedAt ?? this.changedAt,
      changedBy: changedBy ?? this.changedBy,
    );
  }

  Map<String, dynamic> toJson() => {
    'chatId': chatId,
    'duration': duration.name,
    'changedAt': changedAt?.toIso8601String(),
    'changedBy': changedBy,
  };

  factory DisappearingMessagesState.fromJson(Map<String, dynamic> json) {
    return DisappearingMessagesState(
      chatId: json['chatId'] as String,
      duration: DisappearingDuration.values.byName(
        json['duration'] as String? ?? 'off',
      ),
      changedAt: json['changedAt'] != null
          ? DateTime.parse(json['changedAt'] as String)
          : null,
      changedBy: json['changedBy'] as String?,
    );
  }
}
