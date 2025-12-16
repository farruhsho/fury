import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/register_with_email_usecase.dart';
import '../../domain/usecases/sign_in_with_email_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

/// Authentication BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterWithEmailUseCase registerWithEmailUseCase;
  final SignInWithEmailUseCase signInWithEmailUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final SignOutUseCase signOutUseCase;

  AuthBloc({
    required this.registerWithEmailUseCase,
    required this.signInWithEmailUseCase,
    required this.signInWithGoogleUseCase,
    required this.getCurrentUserUseCase,
    required this.signOutUseCase,
  }) : super(const AuthState.initial()) {
    on<_CheckAuthStatus>(_onCheckAuthStatus);
    on<_RegisterWithEmail>(_onRegisterWithEmail);
    on<_SignInWithEmail>(_onSignInWithEmail);
    on<_SignInWithGoogle>(_onSignInWithGoogle);
    on<_UpdateProfile>(_onUpdateProfile);
    on<_SignOut>(_onSignOut);
    on<_DeleteAccount>(_onDeleteAccount);
  }
  
  Future<void> _onCheckAuthStatus(
    _CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    print('🔐 [AUTH_BLOC] Checking authentication status...');
    emit(const AuthState.loading());

    try {
      // Add timeout to the entire operation to prevent infinite loading
      final result = await getCurrentUserUseCase().timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print('⏱️ [AUTH_BLOC] Auth check timed out after 15 seconds');
          print('ℹ️ [AUTH_BLOC] Treating as unauthenticated');
          // Return a Right(null) to indicate unauthenticated
          return Future.value(Right(null));
        },
      );

      result.fold(
        (failure) {
          print('❌ [AUTH_BLOC] Auth check failed: ${ErrorHandler.getUserMessage(failure)}');
          // Treat errors as unauthenticated instead of error state
          // This prevents blocking the user from accessing the login page
          print('ℹ️ [AUTH_BLOC] Redirecting to unauthenticated state');
          emit(const AuthState.unauthenticated());
        },
        (user) {
          if (user == null) {
            print('ℹ️ [AUTH_BLOC] No user found - emitting unauthenticated state');
            emit(const AuthState.unauthenticated());
          } else if (user.displayName == null || user.displayName!.isEmpty) {
            print('⚠️ [AUTH_BLOC] User profile incomplete - redirecting to profile setup');
            emit(AuthState.profileIncomplete(user));
          } else {
            print('✅ [AUTH_BLOC] User authenticated: ${user.id}');
            emit(AuthState.authenticated(user));
          }
        },
      );
    } catch (e) {
      print('❌ [AUTH_BLOC] Unexpected error in auth check: $e');
      print('ℹ️ [AUTH_BLOC] Treating as unauthenticated');
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onRegisterWithEmail(
    _RegisterWithEmail event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await registerWithEmailUseCase(
      email: event.email,
      password: event.password,
      username: event.username,
      displayName: event.displayName,
    );

    result.fold(
      (failure) => emit(AuthState.error(ErrorHandler.getUserMessage(failure))),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onSignInWithEmail(
    _SignInWithEmail event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await signInWithEmailUseCase(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthState.error(ErrorHandler.getUserMessage(failure))),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  Future<void> _onSignInWithGoogle(
    _SignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final result = await signInWithGoogleUseCase();

    result.fold(
      (failure) => emit(AuthState.error(ErrorHandler.getUserMessage(failure))),
      (user) => emit(AuthState.authenticated(user)),
    );
  }

  
  Future<void> _onUpdateProfile(
    _UpdateProfile event,
    Emitter<AuthState> emit,
  ) async {
    // This will be implemented when we add the update profile use case
    // For now, just emit authenticated state
  }
  
  Future<void> _onSignOut(
    _SignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    
    final result = await signOutUseCase();
    
    result.fold(
      (failure) => emit(AuthState.error(ErrorHandler.getUserMessage(failure))),
      (_) => emit(const AuthState.unauthenticated()),
    );
  }
  
  Future<void> _onDeleteAccount(
    _DeleteAccount event,
    Emitter<AuthState> emit,
  ) async {
    // This will be implemented when we add the delete account use case
  }
}
