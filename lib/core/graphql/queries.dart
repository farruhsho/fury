/// GraphQL Queries
abstract class GraphQLQueries {
  // User Queries
  static const String getUserById = r'''
    query GetUser($userId: ID!) {
      user(id: $userId) {
        id
        username
        phoneNumber
        displayName
        avatarUrl
        bio
        isOnline
        lastSeen
        createdAt
      }
    }
  ''';

  static const String searchUsers = r'''
    query SearchUsers($query: String!, $limit: Int = 20) {
      searchUsers(query: $query, limit: $limit) {
        id
        username
        phoneNumber
        displayName
        avatarUrl
        isOnline
      }
    }
  ''';

  static const String getContacts = r'''
    query GetContacts($userId: ID!) {
      contacts(userId: $userId) {
        id
        username
        displayName
        avatarUrl
        isOnline
        lastSeen
      }
    }
  ''';

  // Chat Queries
  static const String getChats = r'''
    query GetChats($userId: ID!, $limit: Int = 50) {
      chats(userId: $userId, limit: $limit) {
        id
        type
        name
        avatarUrl
        participants {
          id
          username
          displayName
          avatarUrl
        }
        lastMessage {
          id
          content
          senderId
          createdAt
          type
          status
        }
        unreadCount
        updatedAt
      }
    }
  ''';

  static const String getChatById = r'''
    query GetChat($chatId: ID!) {
      chat(id: $chatId) {
        id
        type
        name
        avatarUrl
        participants {
          id
          username
          displayName
          avatarUrl
          isOnline
        }
        createdAt
      }
    }
  ''';

  // Message Queries
  static const String getMessages = r'''
    query GetMessages($chatId: ID!, $limit: Int = 50, $before: DateTime) {
      messages(chatId: $chatId, limit: $limit, before: $before) {
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
        updatedAt
        isEdited
      }
    }
  ''';
}
