/// GraphQL Mutations
abstract class GraphQLMutations {
  // Auth Mutations
  static const String sendOTP = r'''
    mutation SendOTP($phoneNumber: String!) {
      sendOTP(phoneNumber: $phoneNumber) {
        success
        message
        verificationId
      }
    }
  ''';

  static const String verifyOTP = r'''
    mutation VerifyOTP($phoneNumber: String!, $code: String!, $verificationId: String!) {
      verifyOTP(phoneNumber: $phoneNumber, code: $code, verificationId: $verificationId) {
        success
        token
        user {
          id
          username
          phoneNumber
          displayName
          avatarUrl
        }
      }
    }
  ''';

  static const String updateProfile = r'''
    mutation UpdateProfile(
      $userId: ID!,
      $displayName: String,
      $username: String,
      $bio: String,
      $avatarUrl: String
    ) {
      updateProfile(
        userId: $userId,
        displayName: $displayName,
        username: $username,
        bio: $bio,
        avatarUrl: $avatarUrl
      ) {
        id
        username
        displayName
        bio
        avatarUrl
      }
    }
  ''';

  // Chat Mutations
  static const String createChat = r'''
    mutation CreateChat($participantIds: [ID!]!, $type: ChatType!, $name: String) {
      createChat(participantIds: $participantIds, type: $type, name: $name) {
        id
        type
        name
        participants {
          id
          username
          displayName
          avatarUrl
        }
        createdAt
      }
    }
  ''';

  // Message Mutations
  static const String sendMessage = r'''
    mutation SendMessage(
      $chatId: ID!,
      $content: String!,
      $type: MessageType = TEXT,
      $replyToId: ID
    ) {
      sendMessage(
        chatId: $chatId,
        content: $content,
        type: $type,
        replyToId: $replyToId
      ) {
        id
        chatId
        senderId
        content
        type
        status
        replyTo {
          id
          content
        }
        createdAt
      }
    }
  ''';

  static const String editMessage = r'''
    mutation EditMessage($messageId: ID!, $content: String!) {
      editMessage(messageId: $messageId, content: $content) {
        id
        content
        isEdited
        updatedAt
      }
    }
  ''';

  static const String deleteMessage = r'''
    mutation DeleteMessage($messageId: ID!) {
      deleteMessage(messageId: $messageId) {
        id
        isDeleted
      }
    }
  ''';

  static const String reactToMessage = r'''
    mutation ReactToMessage($messageId: ID!, $emoji: String!) {
      reactToMessage(messageId: $messageId, emoji: $emoji) {
        id
        reactions {
          emoji
          userId
        }
      }
    }
  ''';

  static const String markMessagesAsRead = r'''
    mutation MarkMessagesAsRead($chatId: ID!, $messageIds: [ID!]!) {
      markMessagesAsRead(chatId: $chatId, messageIds: $messageIds) {
        success
      }
    }
  ''';

  // Contact Mutations
  static const String addContact = r'''
    mutation AddContact($userId: ID!, $contactId: ID!) {
      addContact(userId: $userId, contactId: $contactId) {
        success
      }
    }
  ''';

  static const String removeContact = r'''
    mutation RemoveContact($userId: ID!, $contactId: ID!) {
      removeContact(userId: $userId, contactId: $contactId) {
        success
      }
    }
  ''';

  // Typing Indicator
  static const String setTyping = r'''
    mutation SetTyping($chatId: ID!, $isTyping: Boolean!) {
      setTyping(chatId: $chatId, isTyping: $isTyping) {
        success
      }
    }
  ''';
}
