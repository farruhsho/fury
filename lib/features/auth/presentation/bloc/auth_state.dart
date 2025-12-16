part of 'auth_bloc.dart';

/// Authentication states
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.otpSent({
    required String verificationId,
    required String phoneNumber,
  }) = _OtpSent;
  const factory AuthState.authenticated(UserEntity user) = _Authenticated;
  const factory AuthState.profileIncomplete(UserEntity user) = _ProfileIncomplete;
  const factory AuthState.error(String message) = _Error;
}
