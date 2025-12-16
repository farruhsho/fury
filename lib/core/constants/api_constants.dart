/// API and network configuration constants
abstract class ApiConstants {
  // Base URLs - Update these with your actual backend URLs
  static const String baseUrl = 'https://your-api.com/api/v1';
  static const String wsBaseUrl = 'wss://your-api.com';
  static const String graphqlEndpoint = 'https://your-api.com/graphql';
  static const String graphqlWsEndpoint = 'wss://your-api.com/graphql';
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  
  // Retry
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int messagesPageSize = 50;
  
  // File Upload
  static const int maxFileSize = 100 * 1024 * 1024; // 100MB
  static const int maxImageSize = 10 * 1024 * 1024; // 10MB
  static const int maxVideoSize = 50 * 1024 * 1024; // 50MB
  
  // API Endpoints
  static const String auth = '/auth';
  static const String users = '/users';
  static const String chats = '/chats';
  static const String messages = '/messages';
  static const String media = '/media';
  static const String calls = '/calls';
}
