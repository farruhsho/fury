import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../core/di/injection_container.dart';
import '../core/providers/theme_provider.dart';
import '../core/providers/locale_provider.dart';
import '../core/widgets/global_call_handler.dart';
import '../core/services/session_service.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import 'theme/app_theme.dart';
import 'app_router.dart';

/// Main application widget
class FuryChatApp extends StatefulWidget {
  const FuryChatApp({super.key});

  @override
  State<FuryChatApp> createState() => _FuryChatAppState();
}

class _FuryChatAppState extends State<FuryChatApp> {
  late final AuthBloc _authBloc;
  late final GoRouter _router;
  final SessionService _sessionService = SessionService();

  @override
  void initState() {
    super.initState();
    _authBloc = sl<AuthBloc>()..add(const AuthEvent.checkAuthStatus());
    _router = AppRouter.createRouter(_authBloc);
    
    // Listen to auth state changes to manage sessions
    _authBloc.stream.listen((state) {
      state.maybeWhen(
        authenticated: (_) => _sessionService.registerSession(),
        unauthenticated: () => _sessionService.removeSession(),
        orElse: () {},
      );
    });
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(
            value: _authBloc,
          ),
        ],
        child: Consumer2<ThemeProvider, LocaleProvider>(
          builder: (context, themeProvider, localeProvider, child) {
            return MaterialApp.router(
              title: 'Fury Chat',
              debugShowCheckedModeBanner: false,

              // Theme with dynamic switching
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,

              // Localization with dynamic switching
              locale: localeProvider.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('ru', ''),
                Locale('uz', ''),
              ],

              // Routing
              routerConfig: _router,
              
              // Wrap entire app with global call handler for incoming call detection
              builder: (context, child) {
                return GlobalCallHandler(
                  child: child ?? const SizedBox.shrink(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}


