import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/di/injection_container.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/profile_setup_page.dart';
import '../features/chat/presentation/bloc/message_bloc/message_bloc.dart';
import '../features/chat/presentation/pages/main_screen.dart';
import '../features/chat/presentation/pages/chat_page.dart';
import '../features/chat/presentation/pages/create_group_page.dart';
import '../features/chat/presentation/pages/create_channel_page.dart';
import '../features/chat/presentation/pages/unified_search_page.dart';
import '../features/contacts/presentation/pages/contacts_page.dart';
import '../features/contacts/presentation/pages/add_contact_page.dart';
import '../features/profile/presentation/pages/settings_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/chat/presentation/pages/group_channel_info_page.dart';
import '../features/calls/presentation/pages/call_page.dart';
import '../features/calls/presentation/pages/group_call_page.dart';
import '../features/calls/presentation/pages/call_history_page.dart';
import '../features/calls/presentation/pages/incoming_call_fullscreen_page.dart';
import '../features/calls/presentation/bloc/call_bloc.dart';
import '../features/chat/presentation/pages/new_chat_screen.dart';
import '../features/chat/presentation/pages/group_chat_page.dart';
import '../features/chat/presentation/pages/group_info_page.dart';
import '../features/chat/presentation/pages/media_gallery_page.dart';
import '../features/chat/presentation/pages/camera_screen.dart';
import '../features/status/presentation/pages/status_screen.dart';
import '../features/status/presentation/pages/status_upload_screen.dart';
import '../features/status/presentation/pages/text_status_screen.dart';
import '../features/profile/presentation/pages/enhanced_settings_page.dart';
import '../features/profile/presentation/pages/full_settings_page.dart';
import '../features/profile/presentation/pages/account_settings_page.dart';
import '../features/profile/presentation/pages/account_profile_page.dart';
import '../features/profile/presentation/pages/privacy_settings_page.dart';
import '../features/profile/presentation/pages/chat_settings_page.dart';
import '../features/profile/presentation/pages/accessibility_settings_page.dart';
import '../features/profile/presentation/pages/qr_code_screen.dart';
import '../features/communities/presentation/pages/communities_screen.dart';
import '../features/calls/presentation/pages/enhanced_calls_screen.dart';
import '../features/calls/presentation/pages/new_call_screen.dart';
import '../features/contacts/presentation/pages/contact_search_screen.dart';

/// Auth state notifier for GoRouter
class AuthStateNotifier extends ChangeNotifier {
  final AuthBloc _authBloc;

  AuthStateNotifier(this._authBloc) {
    _authBloc.stream.listen((_) {
      notifyListeners();
    });
  }
}

/// Application routing configuration
class AppRouter {
  // Route names
  static const String splash = '/';
  static const String login = '/login';
  static const String profileSetup = '/profile-setup';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String chatInfo = '/chat-info';
  static const String contacts = '/contacts';
  static const String addContact = '/add-contact';
  static const String createGroup = '/create-group';
  static const String groupInfo = '/group-info';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String call = '/call';
  static const String groupCall = '/group-call';
  static const String callHistory = '/call-history';

  static GoRouter createRouter(AuthBloc authBloc) {
    return GoRouter(
      initialLocation: splash,
      refreshListenable: AuthStateNotifier(authBloc),
      redirect: (context, state) {
        final authState = authBloc.state;
      
      return authState.maybeWhen(
        // Handle loading state - stay on splash
        loading: () {
          if (state.uri.toString() == splash) {
            return null; // Stay on splash while loading
          }
          return splash; // Redirect to splash if navigating elsewhere
        },
        
        // Handle error state - treat as unauthenticated
        error: (_) {
          if (state.uri.toString() == login) {
            return null; // Allow access to auth pages
          }
          return login; // Redirect to login on error
        },
        
        unauthenticated: () {
          // Redirect to login if on splash or trying to access protected pages
          if (state.uri.toString() == splash) {
            print('🔄 [ROUTER] Unauthenticated - redirecting from splash to login');
            return login;
          }
          if (state.uri.toString() == login) {
            return null; // Already on login page
          }
          // Redirect any other protected page to login
          return login;
        },
        
        authenticated: (_) {
          // Redirect to home if on auth pages
          if (state.uri.toString() == splash || 
              state.uri.toString() == login ||
              state.uri.toString() == profileSetup) {
            return home;
          }
          return null;
        },
        
        profileIncomplete: (_) {
          // Redirect to profile setup if not already there
          if (state.uri.toString() != profileSetup) {
            return profileSetup;
          }
          return null;
        },
        
        orElse: () => login, // Default: redirect to login
        );
      },
      routes: [
      // Splash Screen
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      
      // Authentication
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      
      GoRoute(
        path: profileSetup,
        name: 'profileSetup',
        builder: (context, state) => const ProfileSetupPage(),
      ),
      
      // Root level chat route (for navigation from other pages)
      GoRoute(
        path: '/chat/:chatId',
        name: 'rootChat',
        builder: (context, state) {
          final chatId = state.pathParameters['chatId']!;
          return BlocProvider(
            create: (context) => sl<MessageBloc>()
              ..add(MessageEvent.loadMessages(chatId)),
            child: ChatPage(chatId: chatId),
          );
        },
      ),
      
      // Incoming call fullscreen (for background/locked screen calls)
      GoRoute(
        path: '/incoming-call/:callId',
        name: 'incomingCall',
        builder: (context, state) {
          final callId = state.pathParameters['callId']!;
          final callerName = state.uri.queryParameters['callerName'] ?? 'Unknown';
          final callerAvatar = state.uri.queryParameters['callerAvatar'];
          final isVideo = state.uri.queryParameters['isVideo'] == 'true';
          return IncomingCallFullscreenPage(
            callId: callId,
            callerName: Uri.decodeComponent(callerName),
            callerAvatar: callerAvatar,
            isVideo: isVideo,
          );
        },
      ),
      
      // Main App
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
        routes: [
          // Chat routes
          GoRoute(
            path: 'chat/:chatId',
            name: 'chat',
            builder: (context, state) {
              final chatId = state.pathParameters['chatId']!;
              return BlocProvider(
                create: (context) => sl<MessageBloc>()
                  ..add(MessageEvent.loadMessages(chatId)),
                child: ChatPage(chatId: chatId),
              );
            },
          ),
          
          GoRoute(
            path: 'chat-info/:chatId',
            name: 'chatInfo',
            builder: (context, state) {
              final chatId = state.pathParameters['chatId']!;
              return ChatInfoPage(chatId: chatId);
            },
          ),
          
          // Contacts
          GoRoute(
            path: 'contacts',
            name: 'contacts',
            builder: (context, state) => const ContactsPage(),
          ),
          
          GoRoute(
            path: 'add-contact',
            name: 'addContact',
            builder: (context, state) => const AddContactPage(),
          ),
          
          // User Search (now unified search)
          GoRoute(
            path: 'search-users',
            name: 'searchUsers',
            builder: (context, state) => const UnifiedSearchPage(),
          ),
          
          // Groups
          GoRoute(
            path: 'new-chat',
            name: 'newChat',
            builder: (context, state) => const NewChatScreen(),
          ),
          
          GoRoute(
            path: 'new-group',
            name: 'newGroup',
            builder: (context, state) {
              final initialMembers = state.extra as List<String>? ?? [];
              return GroupChatPage(initialMembers: initialMembers);
            },
          ),
          
          GoRoute(
            path: 'create-group',
            name: 'createGroup',
            builder: (context, state) => const CreateGroupPage(),
          ),
          
          // Channels
          GoRoute(
            path: 'create-channel',
            name: 'createChannel',
            builder: (context, state) => const CreateChannelPage(),
          ),
          
          GoRoute(
            path: 'group-info/:chatId',
            name: 'groupInfo',
            builder: (context, state) {
              final chatId = state.pathParameters['chatId']!;
              return GroupChannelInfoPage(chatId: chatId);
            },
          ),
          
          // New WhatsApp-style group info page
          GoRoute(
            path: 'chat-info-new/:chatId',
            name: 'chatInfoNew',
            builder: (context, state) {
              final chatId = state.pathParameters['chatId']!;
              return GroupInfoPage(chatId: chatId);
            },
          ),
          
          // Media gallery page
          GoRoute(
            path: 'media-gallery/:chatId',
            name: 'mediaGallery',
            builder: (context, state) {
              final chatId = state.pathParameters['chatId']!;
              final chatName = state.uri.queryParameters['name'];
              return MediaGalleryPage(chatId: chatId, chatName: chatName);
            },
          ),
          
          // Profile & Settings
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
          
          GoRoute(
            path: 'settings',
            name: 'settings',
            builder: (context, state) => const SettingsPage(),
          ),

          // Call routes
          GoRoute(
            path: 'call',
            name: 'call',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return BlocProvider(
                create: (context) => sl<CallBloc>(),
                child: CallPage(
                  callId: extra?['callId'],
                  chatId: extra?['chatId'],
                  recipientId: extra?['recipientId'] ?? '',
                  recipientName: extra?['recipientName'] ?? 'Unknown',
                  recipientAvatarUrl: extra?['recipientAvatarUrl'],
                  isVideo: extra?['isVideo'] ?? false,
                  isIncoming: extra?['isIncoming'] ?? false,
                ),
              );
            },
          ),

          GoRoute(
            path: 'group-call',
            name: 'groupCall',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return GroupCallPage(
                callId: extra?['callId'],
                chatId: extra?['chatId'] ?? '',
                chatName: extra?['chatName'] ?? 'Group Call',
                participantIds: List<String>.from(extra?['participantIds'] ?? []),
                isVideo: extra?['isVideo'] ?? false,
                isIncoming: extra?['isIncoming'] ?? false,
              );
            },
          ),

          GoRoute(
            path: 'call-history',
            name: 'callHistory',
            builder: (context, state) => const CallHistoryPage(),
          ),
          
          // Status routes
          GoRoute(
            path: 'status',
            name: 'status',
            builder: (context, state) => const StatusScreen(),
          ),
          GoRoute(
            path: 'text-status',
            name: 'textStatus',
            builder: (context, state) => const TextStatusScreen(),
          ),
          GoRoute(
            path: 'status-upload',
            name: 'statusUpload',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return StatusUploadScreen(
                mediaPath: extra?['mediaPath'],
                isVideo: extra?['isVideo'] ?? false,
              );
            },
          ),
          
          // Camera
          GoRoute(
            path: 'camera',
            name: 'camera',
            builder: (context, state) => const CameraScreen(),
          ),
          
          // Enhanced Settings routes
          GoRoute(
            path: 'full-settings',
            name: 'fullSettings',
            builder: (context, state) => const FullSettingsPage(),
          ),
          GoRoute(
            path: 'enhanced-settings',
            name: 'enhancedSettings',
            builder: (context, state) => const EnhancedSettingsPage(),
          ),
          GoRoute(
            path: 'account-settings',
            name: 'accountSettings',
            builder: (context, state) => const AccountSettingsPage(),
          ),
          GoRoute(
            path: 'account-profile',
            name: 'accountProfile',
            builder: (context, state) => const AccountProfilePage(),
          ),
          GoRoute(
            path: 'privacy-settings',
            name: 'privacySettings',
            builder: (context, state) => const PrivacySettingsPage(),
          ),
          GoRoute(
            path: 'chat-settings',
            name: 'chatSettings',
            builder: (context, state) => const ChatSettingsPage(),
          ),
          GoRoute(
            path: 'accessibility-settings',
            name: 'accessibilitySettings',
            builder: (context, state) => const AccessibilitySettingsPage(),
          ),
          GoRoute(
            path: 'qr-code',
            name: 'qrCode',
            builder: (context, state) => const QRCodeScreen(),
          ),
          
          // Communities
          GoRoute(
            path: 'communities',
            name: 'communities',
            builder: (context, state) => const CommunitiesScreen(),
          ),
          
          // Extended Calls
          GoRoute(
            path: 'calls',
            name: 'calls',
            builder: (context, state) => const EnhancedCallsScreen(),
          ),
          GoRoute(
            path: 'new-call',
            name: 'newCall',
            builder: (context, state) => const NewCallScreen(),
          ),
          
          // Contact search
          GoRoute(
            path: 'contact-search',
            name: 'contactSearch',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return ContactSearchScreen(
                multiSelect: extra?['multiSelect'] ?? true,
                title: extra?['title'],
              );
            },
          ),
        ],
      ),
    ],
    
      // Error handling
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text('Page not found: ${state.uri}'),
        ),
      ),
    );
  }
}

// Placeholder pages - will be implemented in later phases
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF0A0A0F),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated logo placeholder
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFFF2D92), Color(0xFF9D00FF), Color(0xFF0066FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF2D92).withValues(alpha: 0.5),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.local_fire_department,
              size: 64,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'FURY',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: 8,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Color(0xFFFF2D92),
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => const MainScreen();
}

class ChatInfoPage extends StatelessWidget {
  final String chatId;
  const ChatInfoPage({super.key, required this.chatId});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Text('Chat Info: $chatId')),
  );
}
