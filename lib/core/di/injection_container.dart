import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../services/local_storage_service.dart';
import '../services/secure_storage_service.dart';
import '../services/notification_service.dart';
import '../services/file_upload_service.dart';
import '../services/presence_service.dart';
import '../services/typing_indicator_service.dart';
import '../services/graphql_service.dart';
import '../services/starred_messages_service.dart';
import '../services/chat_mute_service.dart';
import '../services/pinned_chats_service.dart';
import '../services/last_seen_privacy_service.dart';
import '../services/in_call_status_service.dart';
import '../services/link_preview_service.dart';
import '../services/incoming_call_listener_service.dart';
import '../services/message_notification_listener_service.dart';
import '../services/offline_queue_service.dart';
import '../services/connectivity_service.dart';
import '../encryption/encryption_service.dart';
import '../encryption/key_exchange_manager.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/register_with_email_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/domain/usecases/search_users_usecase.dart' as auth_search;
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/chat/data/datasources/chat_remote_datasource.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/domain/usecases/get_chats_usecase.dart';
import '../../features/chat/domain/usecases/get_messages_usecase.dart';
import '../../features/chat/domain/usecases/send_message_usecase.dart';
import '../../features/chat/domain/usecases/create_chat_usecase.dart';
import '../../features/chat/domain/usecases/mark_messages_as_read_usecase.dart';
import '../../features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import '../../features/chat/presentation/bloc/message_bloc/message_bloc.dart';
import '../../features/chat/domain/usecases/edit_message_usecase.dart';
import '../../features/chat/domain/usecases/delete_message_usecase.dart';
import '../../features/chat/domain/usecases/react_to_message_usecase.dart';
import '../../features/chat/domain/usecases/send_attachment_usecase.dart';
import '../../features/chat/domain/usecases/retry_message_usecase.dart';

import '../../features/contacts/data/datasources/contact_remote_datasource.dart';
import '../../features/contacts/data/repositories/contact_repository_impl.dart';
import '../../features/contacts/domain/repositories/contact_repository.dart';
import '../../features/contacts/domain/usecases/get_contacts_usecase.dart';
import '../../features/contacts/domain/usecases/search_users_usecase.dart';
import '../../features/contacts/domain/usecases/add_contact_usecase.dart';
import '../../features/contacts/presentation/bloc/contacts_bloc.dart';

import '../../features/calls/presentation/bloc/call_bloc.dart';
import '../../features/calls/data/datasources/call_signaling_datasource.dart';
import '../../features/calls/data/datasources/webrtc_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External - Register these FIRST as other services depend on them
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker());

  //! Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      registerWithEmailUseCase: sl(),
      signInWithEmailUseCase: sl(),
      signInWithGoogleUseCase: sl(),
      getCurrentUserUseCase: sl(),
      signOutUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => RegisterWithEmailUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithEmailUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
  // Phone/SMS authentication use cases (commented out - not configured)
  // sl.registerLazySingleton(() => SendOTPUseCase(sl()));
  // sl.registerLazySingleton(() => VerifyOTPUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => auth_search.SearchUsersUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: sl(),
      localDatasource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(
      firebaseAuth: sl(),
      firestore: sl(),
    ),
  );

  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasource(sl()),
  );

  //! Features - Chat
  // Bloc
  sl.registerFactory(
    () => ChatBloc(
      getChatsUseCase: sl(),
      createChatUseCase: sl(),
    ),
  );
  
  sl.registerFactory(
    () => MessageBloc(
      getMessagesUseCase: sl(),
      sendMessageUseCase: sl(),
      sendAttachmentUseCase: sl(),
      markMessagesAsReadUseCase: sl(),
      editMessageUseCase: sl(),
      deleteMessageUseCase: sl(),
      reactToMessageUseCase: sl(),
      retryMessageUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetChatsUseCase(sl()));
  sl.registerLazySingleton(() => GetMessagesUseCase(sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton(() => SendAttachmentUseCase(sl()));
  sl.registerLazySingleton(() => CreateChatUseCase(sl()));
  sl.registerLazySingleton(() => MarkMessagesAsReadUseCase(sl()));
  sl.registerLazySingleton(() => EditMessageUseCase(sl()));
  sl.registerLazySingleton(() => DeleteMessageUseCase(sl()));
  sl.registerLazySingleton(() => ReactToMessageUseCase(sl()));
  sl.registerLazySingleton(() => RetryMessageUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      remoteDatasource: sl(),
      offlineQueueService: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ChatRemoteDatasource>(
    () => ChatRemoteDatasource(
      firestore: sl(),
      auth: sl(),
      fileUploadService: sl(),
    ),
  );

  //! Features - Contacts
  // Bloc
  sl.registerFactory(
    () => ContactsBloc(
      getContactsUseCase: sl(),
      searchUsersUseCase: sl(),
      addContactUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetContactsUseCase(sl()));
  sl.registerLazySingleton(() => SearchUsersUseCase(sl()));
  sl.registerLazySingleton(() => AddContactUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(
      remoteDatasource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ContactRemoteDatasource>(
    () => ContactRemoteDatasource(
      firestore: sl(),
      auth: sl(),
    ),
  );

  //! Features - Calls
  // Data sources
  sl.registerLazySingleton<CallSignalingDatasource>(
    () => CallSignalingDatasource(
      firestore: sl(),
      auth: sl(),
    ),
  );

  sl.registerLazySingleton<WebRTCService>(
    () => WebRTCService(),
  );

  // Bloc
  sl.registerFactory(
    () => CallBloc(
      signalingDatasource: sl(),
      webrtcService: sl(),
      chatRepository: sl(),
    ),
  );

  //! Core
  // Services
  final localStorageService = LocalStorageService();
  await localStorageService.init();
  sl.registerLazySingleton(() => localStorageService);

  final secureStorageService = SecureStorageService();
  sl.registerLazySingleton(() => secureStorageService);
  
  final notificationService = NotificationService();
  await notificationService.init();
  sl.registerLazySingleton(() => notificationService);

  final fileUploadService = FileUploadService();
  sl.registerLazySingleton(() => fileUploadService);

  final presenceService = PresenceService();
  await presenceService.initialize();
  sl.registerLazySingleton(() => presenceService);

  final typingIndicatorService = TypingIndicatorService();
  sl.registerLazySingleton(() => typingIndicatorService);

  // Connectivity Service for offline awareness
  final connectivityService = ConnectivityService();
  await connectivityService.initialize();
  sl.registerLazySingleton(() => connectivityService);

  // GraphQL Service (optional - for future backend integration)
  final graphqlService = GraphQLService();
  // Note: GraphQL service initialization is commented out by default
  // Uncomment when you have a GraphQL backend configured
  // await graphqlService.initialize();
  sl.registerLazySingleton(() => graphqlService);

  //! Encryption Services
  final encryptionService = EncryptionService();
  sl.registerLazySingleton(() => encryptionService);
  
  final keyExchangeManager = KeyExchangeManager(
    firestore: sl(),
    auth: sl(),
    encryptionService: encryptionService,
  );
  sl.registerLazySingleton(() => keyExchangeManager);

  //! Messaging Services
  sl.registerLazySingleton(() => StarredMessagesService());
  sl.registerLazySingleton(() => ChatMuteService());
  sl.registerLazySingleton(() => PinnedChatsService());
  sl.registerLazySingleton(() => LastSeenPrivacyService());
  sl.registerLazySingleton(() => InCallStatusService());
  sl.registerLazySingleton(() => LinkPreviewService());

  //! Real-time Listener Services (without Cloud Functions)
  final incomingCallListener = IncomingCallListenerService();
  sl.registerLazySingleton(() => incomingCallListener);

  final messageNotificationListener = MessageNotificationListenerService();
  sl.registerLazySingleton(() => messageNotificationListener);
  
  //! Offline Queue
  final offlineQueueService = OfflineQueueService();
  await offlineQueueService.init();
  sl.registerLazySingleton(() => offlineQueueService);
  
  // Break circular dependency
  // OfflineQueue needs ChatRepository to send messages
  // ChatRepository needs OfflineQueue to enqueue messages
  // We set it after ChatRepository is registered (which happens above)
  if (sl.isRegistered<ChatRepository>()) {
    offlineQueueService.setChatRepository(sl<ChatRepository>());
  }
}
