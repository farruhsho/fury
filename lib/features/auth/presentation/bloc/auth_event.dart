part of 'auth_bloc.dart';

/// Authentication events
@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.checkAuthStatus() = _CheckAuthStatus;

  // Email/Password Auth
  const factory AuthEvent.registerWithEmail({
    required String email,
    required String password,
    required String username,
    String? displayName,
  }) = _RegisterWithEmail;

  const factory AuthEvent.signInWithEmail({
    required String email,
    required String password,
  }) = _SignInWithEmail;

  // Google Sign-In
  const factory AuthEvent.signInWithGoogle() = _SignInWithGoogle;

  // Phone Auth (for future)
  const factory AuthEvent.sendOTP(String phoneNumber) = _SendOTP;
  const factory AuthEvent.verifyOTP({
    required String phoneNumber,
    required String verificationId,
    required String code,
  }) = _VerifyOTP;

  // Profile Management
  const factory AuthEvent.updateProfile({
    String? displayName,
    String? username,
    String? bio,
    String? avatarUrl,
  }) = _UpdateProfile;

  const factory AuthEvent.signOut() = _SignOut;
  const factory AuthEvent.deleteAccount() = _DeleteAccount;
}
