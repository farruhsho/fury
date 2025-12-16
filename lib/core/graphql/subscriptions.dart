/// GraphQL Subscriptions for real-time updates
abstract class GraphQLSubscriptions {
  // Message Subscriptions
  static const String onMessageReceived = r'''
    subscription OnMessageReceived($chatId: ID!) {
      messageReceived(chatId: $chatId) {
        id
        chatId
        senderId
        content
        type
        status
        replyTo {
          id
          content
          senderId
        }
        reactions {
          emoji
          userId
        }
        attachments {
          id
          type
          url
          name
          size
        }
        createdAt
      }
    }
  ''';

  static const String onMessageUpdated = r'''
    subscription OnMessageUpdated($chatId: ID!) {
      messageUpdated(chatId: $chatId) {
        id
        content
        isEdited
        updatedAt
      }
    }
  ''';

  static const String onMessageDeleted = r'''
    subscription OnMessageDeleted($chatId: ID!) {
      messageDeleted(chatId: $chatId) {
        id
        isDeleted
      }
    }
  ''';

  // Typing Indicator Subscription
  static const String onTypingStatusChanged = r'''
    subscription OnTypingStatusChanged($chatId: ID!) {
      typingStatusChanged(chatId: $chatId) {
        userId
        username
        isTyping
      }
    }
  ''';

  // Presence Subscription
  static const String onUserPresenceChanged = r'''
    subscription OnUserPresenceChanged($userId: ID!) {
      userPresenceChanged(userId: $userId) {
        userId
        isOnline
        lastSeen
      }
    }
  ''';

  // Chat Subscription
  static const String onChatUpdated = r'''
    subscription OnChatUpdated($userId: ID!) {
      chatUpdated(userId: $userId) {
        id
        lastMessage {
          id
          content
          senderId
          createdAt
        }
        unreadCount
        updatedAt
      }
    }
  ''';

  // Message Status Subscription
  static const String onMessageStatusChanged = r'''
    subscription OnMessageStatusChanged($chatId: ID!) {
      messageStatusChanged(chatId: $chatId) {
        id
        status
        updatedAt
      }
    }
  ''';
}
