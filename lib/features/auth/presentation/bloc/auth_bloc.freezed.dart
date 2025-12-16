// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(
            String email, String password, String username, String? displayName)
        registerWithEmail,
    required TResult Function(String email, String password) signInWithEmail,
    required TResult Function() signInWithGoogle,
    required TResult Function(String phoneNumber) sendOTP,
    required TResult Function(
            String phoneNumber, String verificationId, String code)
        verifyOTP,
    required TResult Function(String? displayName, String? username,
            String? bio, String? avatarUrl)
        updateProfile,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult? Function(String email, String password)? signInWithEmail,
    TResult? Function()? signInWithGoogle,
    TResult? Function(String phoneNumber)? sendOTP,
    TResult? Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult? Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult Function(String email, String password)? signInWithEmail,
    TResult Function()? signInWithGoogle,
    TResult Function(String phoneNumber)? sendOTP,
    TResult Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_RegisterWithEmail value) registerWithEmail,
    required TResult Function(_SignInWithEmail value) signInWithEmail,
    required TResult Function(_SignInWithGoogle value) signInWithGoogle,
    required TResult Function(_SendOTP value) sendOTP,
    required TResult Function(_VerifyOTP value) verifyOTP,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_RegisterWithEmail value)? registerWithEmail,
    TResult? Function(_SignInWithEmail value)? signInWithEmail,
    TResult? Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult? Function(_SendOTP value)? sendOTP,
    TResult? Function(_VerifyOTP value)? verifyOTP,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_RegisterWithEmail value)? registerWithEmail,
    TResult Function(_SignInWithEmail value)? signInWithEmail,
    TResult Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult Function(_SendOTP value)? sendOTP,
    TResult Function(_VerifyOTP value)? verifyOTP,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CheckAuthStatusImplCopyWith<$Res> {
  factory _$$CheckAuthStatusImplCopyWith(_$CheckAuthStatusImpl value,
          $Res Function(_$CheckAuthStatusImpl) then) =
      __$$CheckAuthStatusImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckAuthStatusImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$CheckAuthStatusImpl>
    implements _$$CheckAuthStatusImplCopyWith<$Res> {
  __$$CheckAuthStatusImplCopyWithImpl(
      _$CheckAuthStatusImpl _value, $Res Function(_$CheckAuthStatusImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CheckAuthStatusImpl implements _CheckAuthStatus {
  const _$CheckAuthStatusImpl();

  @override
  String toString() {
    return 'AuthEvent.checkAuthStatus()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckAuthStatusImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(
            String email, String password, String username, String? displayName)
        registerWithEmail,
    required TResult Function(String email, String password) signInWithEmail,
    required TResult Function() signInWithGoogle,
    required TResult Function(String phoneNumber) sendOTP,
    required TResult Function(
            String phoneNumber, String verificationId, String code)
        verifyOTP,
    required TResult Function(String? displayName, String? username,
            String? bio, String? avatarUrl)
        updateProfile,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
  }) {
    return checkAuthStatus();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult? Function(String email, String password)? signInWithEmail,
    TResult? Function()? signInWithGoogle,
    TResult? Function(String phoneNumber)? sendOTP,
    TResult? Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult? Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
  }) {
    return checkAuthStatus?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult Function(String email, String password)? signInWithEmail,
    TResult Function()? signInWithGoogle,
    TResult Function(String phoneNumber)? sendOTP,
    TResult Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    required TResult orElse(),
  }) {
    if (checkAuthStatus != null) {
      return checkAuthStatus();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_RegisterWithEmail value) registerWithEmail,
    required TResult Function(_SignInWithEmail value) signInWithEmail,
    required TResult Function(_SignInWithGoogle value) signInWithGoogle,
    required TResult Function(_SendOTP value) sendOTP,
    required TResult Function(_VerifyOTP value) verifyOTP,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
  }) {
    return checkAuthStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_RegisterWithEmail value)? registerWithEmail,
    TResult? Function(_SignInWithEmail value)? signInWithEmail,
    TResult? Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult? Function(_SendOTP value)? sendOTP,
    TResult? Function(_VerifyOTP value)? verifyOTP,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
  }) {
    return checkAuthStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_RegisterWithEmail value)? registerWithEmail,
    TResult Function(_SignInWithEmail value)? signInWithEmail,
    TResult Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult Function(_SendOTP value)? sendOTP,
    TResult Function(_VerifyOTP value)? verifyOTP,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    required TResult orElse(),
  }) {
    if (checkAuthStatus != null) {
      return checkAuthStatus(this);
    }
    return orElse();
  }
}

abstract class _CheckAuthStatus implements AuthEvent {
  const factory _CheckAuthStatus() = _$CheckAuthStatusImpl;
}

/// @nodoc
abstract class _$$RegisterWithEmailImplCopyWith<$Res> {
  factory _$$RegisterWithEmailImplCopyWith(_$RegisterWithEmailImpl value,
          $Res Function(_$RegisterWithEmailImpl) then) =
      __$$RegisterWithEmailImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String email, String password, String username, String? displayName});
}

/// @nodoc
class __$$RegisterWithEmailImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$RegisterWithEmailImpl>
    implements _$$RegisterWithEmailImplCopyWith<$Res> {
  __$$RegisterWithEmailImplCopyWithImpl(_$RegisterWithEmailImpl _value,
      $Res Function(_$RegisterWithEmailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? username = null,
    Object? displayName = freezed,
  }) {
    return _then(_$RegisterWithEmailImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RegisterWithEmailImpl implements _RegisterWithEmail {
  const _$RegisterWithEmailImpl(
      {required this.email,
      required this.password,
      required this.username,
      this.displayName});

  @override
  final String email;
  @override
  final String password;
  @override
  final String username;
  @override
  final String? displayName;

  @override
  String toString() {
    return 'AuthEvent.registerWithEmail(email: $email, password: $password, username: $username, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterWithEmailImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, username, displayName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterWithEmailImplCopyWith<_$RegisterWithEmailImpl> get copyWith =>
      __$$RegisterWithEmailImplCopyWithImpl<_$RegisterWithEmailImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(
            String email, String password, String username, String? displayName)
        registerWithEmail,
    required TResult Function(String email, String password) signInWithEmail,
    required TResult Function() signInWithGoogle,
    required TResult Function(String phoneNumber) sendOTP,
    required TResult Function(
            String phoneNumber, String verificationId, String code)
        verifyOTP,
    required TResult Function(String? displayName, String? username,
            String? bio, String? avatarUrl)
        updateProfile,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
  }) {
    return registerWithEmail(email, password, username, displayName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult? Function(String email, String password)? signInWithEmail,
    TResult? Function()? signInWithGoogle,
    TResult? Function(String phoneNumber)? sendOTP,
    TResult? Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult? Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
  }) {
    return registerWithEmail?.call(email, password, username, displayName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult Function(String email, String password)? signInWithEmail,
    TResult Function()? signInWithGoogle,
    TResult Function(String phoneNumber)? sendOTP,
    TResult Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    required TResult orElse(),
  }) {
    if (registerWithEmail != null) {
      return registerWithEmail(email, password, username, displayName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_RegisterWithEmail value) registerWithEmail,
    required TResult Function(_SignInWithEmail value) signInWithEmail,
    required TResult Function(_SignInWithGoogle value) signInWithGoogle,
    required TResult Function(_SendOTP value) sendOTP,
    required TResult Function(_VerifyOTP value) verifyOTP,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
  }) {
    return registerWithEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_RegisterWithEmail value)? registerWithEmail,
    TResult? Function(_SignInWithEmail value)? signInWithEmail,
    TResult? Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult? Function(_SendOTP value)? sendOTP,
    TResult? Function(_VerifyOTP value)? verifyOTP,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
  }) {
    return registerWithEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_RegisterWithEmail value)? registerWithEmail,
    TResult Function(_SignInWithEmail value)? signInWithEmail,
    TResult Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult Function(_SendOTP value)? sendOTP,
    TResult Function(_VerifyOTP value)? verifyOTP,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    required TResult orElse(),
  }) {
    if (registerWithEmail != null) {
      return registerWithEmail(this);
    }
    return orElse();
  }
}

abstract class _RegisterWithEmail implements AuthEvent {
  const factory _RegisterWithEmail(
      {required final String email,
      required final String password,
      required final String username,
      final String? displayName}) = _$RegisterWithEmailImpl;

  String get email;
  String get password;
  String get username;
  String? get displayName;
  @JsonKey(ignore: true)
  _$$RegisterWithEmailImplCopyWith<_$RegisterWithEmailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignInWithEmailImplCopyWith<$Res> {
  factory _$$SignInWithEmailImplCopyWith(_$SignInWithEmailImpl value,
          $Res Function(_$SignInWithEmailImpl) then) =
      __$$SignInWithEmailImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$SignInWithEmailImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignInWithEmailImpl>
    implements _$$SignInWithEmailImplCopyWith<$Res> {
  __$$SignInWithEmailImplCopyWithImpl(
      _$SignInWithEmailImpl _value, $Res Function(_$SignInWithEmailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$SignInWithEmailImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignInWithEmailImpl implements _SignInWithEmail {
  const _$SignInWithEmailImpl({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.signInWithEmail(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInWithEmailImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignInWithEmailImplCopyWith<_$SignInWithEmailImpl> get copyWith =>
      __$$SignInWithEmailImplCopyWithImpl<_$SignInWithEmailImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(
            String email, String password, String username, String? displayName)
        registerWithEmail,
    required TResult Function(String email, String password) signInWithEmail,
    required TResult Function() signInWithGoogle,
    required TResult Function(String phoneNumber) sendOTP,
    required TResult Function(
            String phoneNumber, String verificationId, String code)
        verifyOTP,
    required TResult Function(String? displayName, String? username,
            String? bio, String? avatarUrl)
        updateProfile,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
  }) {
    return signInWithEmail(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult? Function(String email, String password)? signInWithEmail,
    TResult? Function()? signInWithGoogle,
    TResult? Function(String phoneNumber)? sendOTP,
    TResult? Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult? Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
  }) {
    return signInWithEmail?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult Function(String email, String password)? signInWithEmail,
    TResult Function()? signInWithGoogle,
    TResult Function(String phoneNumber)? sendOTP,
    TResult Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    required TResult orElse(),
  }) {
    if (signInWithEmail != null) {
      return signInWithEmail(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_RegisterWithEmail value) registerWithEmail,
    required TResult Function(_SignInWithEmail value) signInWithEmail,
    required TResult Function(_SignInWithGoogle value) signInWithGoogle,
    required TResult Function(_SendOTP value) sendOTP,
    required TResult Function(_VerifyOTP value) verifyOTP,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
  }) {
    return signInWithEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_RegisterWithEmail value)? registerWithEmail,
    TResult? Function(_SignInWithEmail value)? signInWithEmail,
    TResult? Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult? Function(_SendOTP value)? sendOTP,
    TResult? Function(_VerifyOTP value)? verifyOTP,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
  }) {
    return signInWithEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_RegisterWithEmail value)? registerWithEmail,
    TResult Function(_SignInWithEmail value)? signInWithEmail,
    TResult Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult Function(_SendOTP value)? sendOTP,
    TResult Function(_VerifyOTP value)? verifyOTP,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    required TResult orElse(),
  }) {
    if (signInWithEmail != null) {
      return signInWithEmail(this);
    }
    return orElse();
  }
}

abstract class _SignInWithEmail implements AuthEvent {
  const factory _SignInWithEmail(
      {required final String email,
      required final String password}) = _$SignInWithEmailImpl;

  String get email;
  String get password;
  @JsonKey(ignore: true)
  _$$SignInWithEmailImplCopyWith<_$SignInWithEmailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignInWithGoogleImplCopyWith<$Res> {
  factory _$$SignInWithGoogleImplCopyWith(_$SignInWithGoogleImpl value,
          $Res Function(_$SignInWithGoogleImpl) then) =
      __$$SignInWithGoogleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignInWithGoogleImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignInWithGoogleImpl>
    implements _$$SignInWithGoogleImplCopyWith<$Res> {
  __$$SignInWithGoogleImplCopyWithImpl(_$SignInWithGoogleImpl _value,
      $Res Function(_$SignInWithGoogleImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignInWithGoogleImpl implements _SignInWithGoogle {
  const _$SignInWithGoogleImpl();

  @override
  String toString() {
    return 'AuthEvent.signInWithGoogle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignInWithGoogleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(
            String email, String password, String username, String? displayName)
        registerWithEmail,
    required TResult Function(String email, String password) signInWithEmail,
    required TResult Function() signInWithGoogle,
    required TResult Function(String phoneNumber) sendOTP,
    required TResult Function(
            String phoneNumber, String verificationId, String code)
        verifyOTP,
    required TResult Function(String? displayName, String? username,
            String? bio, String? avatarUrl)
        updateProfile,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
  }) {
    return signInWithGoogle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult? Function(String email, String password)? signInWithEmail,
    TResult? Function()? signInWithGoogle,
    TResult? Function(String phoneNumber)? sendOTP,
    TResult? Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult? Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
  }) {
    return signInWithGoogle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult Function(String email, String password)? signInWithEmail,
    TResult Function()? signInWithGoogle,
    TResult Function(String phoneNumber)? sendOTP,
    TResult Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    required TResult orElse(),
  }) {
    if (signInWithGoogle != null) {
      return signInWithGoogle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_RegisterWithEmail value) registerWithEmail,
    required TResult Function(_SignInWithEmail value) signInWithEmail,
    required TResult Function(_SignInWithGoogle value) signInWithGoogle,
    required TResult Function(_SendOTP value) sendOTP,
    required TResult Function(_VerifyOTP value) verifyOTP,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
  }) {
    return signInWithGoogle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_RegisterWithEmail value)? registerWithEmail,
    TResult? Function(_SignInWithEmail value)? signInWithEmail,
    TResult? Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult? Function(_SendOTP value)? sendOTP,
    TResult? Function(_VerifyOTP value)? verifyOTP,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
  }) {
    return signInWithGoogle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_RegisterWithEmail value)? registerWithEmail,
    TResult Function(_SignInWithEmail value)? signInWithEmail,
    TResult Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult Function(_SendOTP value)? sendOTP,
    TResult Function(_VerifyOTP value)? verifyOTP,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    required TResult orElse(),
  }) {
    if (signInWithGoogle != null) {
      return signInWithGoogle(this);
    }
    return orElse();
  }
}

abstract class _SignInWithGoogle implements AuthEvent {
  const factory _SignInWithGoogle() = _$SignInWithGoogleImpl;
}

/// @nodoc
abstract class _$$SendOTPImplCopyWith<$Res> {
  factory _$$SendOTPImplCopyWith(
          _$SendOTPImpl value, $Res Function(_$SendOTPImpl) then) =
      __$$SendOTPImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber});
}

/// @nodoc
class __$$SendOTPImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SendOTPImpl>
    implements _$$SendOTPImplCopyWith<$Res> {
  __$$SendOTPImplCopyWithImpl(
      _$SendOTPImpl _value, $Res Function(_$SendOTPImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
  }) {
    return _then(_$SendOTPImpl(
      null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SendOTPImpl implements _SendOTP {
  const _$SendOTPImpl(this.phoneNumber);

  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'AuthEvent.sendOTP(phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendOTPImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendOTPImplCopyWith<_$SendOTPImpl> get copyWith =>
      __$$SendOTPImplCopyWithImpl<_$SendOTPImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(
            String email, String password, String username, String? displayName)
        registerWithEmail,
    required TResult Function(String email, String password) signInWithEmail,
    required TResult Function() signInWithGoogle,
    required TResult Function(String phoneNumber) sendOTP,
    required TResult Function(
            String phoneNumber, String verificationId, String code)
        verifyOTP,
    required TResult Function(String? displayName, String? username,
            String? bio, String? avatarUrl)
        updateProfile,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
  }) {
    return sendOTP(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult? Function(String email, String password)? signInWithEmail,
    TResult? Function()? signInWithGoogle,
    TResult? Function(String phoneNumber)? sendOTP,
    TResult? Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult? Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
  }) {
    return sendOTP?.call(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult Function(String email, String password)? signInWithEmail,
    TResult Function()? signInWithGoogle,
    TResult Function(String phoneNumber)? sendOTP,
    TResult Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    required TResult orElse(),
  }) {
    if (sendOTP != null) {
      return sendOTP(phoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_RegisterWithEmail value) registerWithEmail,
    required TResult Function(_SignInWithEmail value) signInWithEmail,
    required TResult Function(_SignInWithGoogle value) signInWithGoogle,
    required TResult Function(_SendOTP value) sendOTP,
    required TResult Function(_VerifyOTP value) verifyOTP,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
  }) {
    return sendOTP(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_RegisterWithEmail value)? registerWithEmail,
    TResult? Function(_SignInWithEmail value)? signInWithEmail,
    TResult? Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult? Function(_SendOTP value)? sendOTP,
    TResult? Function(_VerifyOTP value)? verifyOTP,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
  }) {
    return sendOTP?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_RegisterWithEmail value)? registerWithEmail,
    TResult Function(_SignInWithEmail value)? signInWithEmail,
    TResult Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult Function(_SendOTP value)? sendOTP,
    TResult Function(_VerifyOTP value)? verifyOTP,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    required TResult orElse(),
  }) {
    if (sendOTP != null) {
      return sendOTP(this);
    }
    return orElse();
  }
}

abstract class _SendOTP implements AuthEvent {
  const factory _SendOTP(final String phoneNumber) = _$SendOTPImpl;

  String get phoneNumber;
  @JsonKey(ignore: true)
  _$$SendOTPImplCopyWith<_$SendOTPImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyOTPImplCopyWith<$Res> {
  factory _$$VerifyOTPImplCopyWith(
          _$VerifyOTPImpl value, $Res Function(_$VerifyOTPImpl) then) =
      __$$VerifyOTPImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber, String verificationId, String code});
}

/// @nodoc
class __$$VerifyOTPImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$VerifyOTPImpl>
    implements _$$VerifyOTPImplCopyWith<$Res> {
  __$$VerifyOTPImplCopyWithImpl(
      _$VerifyOTPImpl _value, $Res Function(_$VerifyOTPImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? verificationId = null,
    Object? code = null,
  }) {
    return _then(_$VerifyOTPImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      verificationId: null == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VerifyOTPImpl implements _VerifyOTP {
  const _$VerifyOTPImpl(
      {required this.phoneNumber,
      required this.verificationId,
      required this.code});

  @override
  final String phoneNumber;
  @override
  final String verificationId;
  @override
  final String code;

  @override
  String toString() {
    return 'AuthEvent.verifyOTP(phoneNumber: $phoneNumber, verificationId: $verificationId, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOTPImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phoneNumber, verificationId, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOTPImplCopyWith<_$VerifyOTPImpl> get copyWith =>
      __$$VerifyOTPImplCopyWithImpl<_$VerifyOTPImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(
            String email, String password, String username, String? displayName)
        registerWithEmail,
    required TResult Function(String email, String password) signInWithEmail,
    required TResult Function() signInWithGoogle,
    required TResult Function(String phoneNumber) sendOTP,
    required TResult Function(
            String phoneNumber, String verificationId, String code)
        verifyOTP,
    required TResult Function(String? displayName, String? username,
            String? bio, String? avatarUrl)
        updateProfile,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
  }) {
    return verifyOTP(phoneNumber, verificationId, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult? Function(String email, String password)? signInWithEmail,
    TResult? Function()? signInWithGoogle,
    TResult? Function(String phoneNumber)? sendOTP,
    TResult? Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult? Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
  }) {
    return verifyOTP?.call(phoneNumber, verificationId, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult Function(String email, String password)? signInWithEmail,
    TResult Function()? signInWithGoogle,
    TResult Function(String phoneNumber)? sendOTP,
    TResult Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    required TResult orElse(),
  }) {
    if (verifyOTP != null) {
      return verifyOTP(phoneNumber, verificationId, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_RegisterWithEmail value) registerWithEmail,
    required TResult Function(_SignInWithEmail value) signInWithEmail,
    required TResult Function(_SignInWithGoogle value) signInWithGoogle,
    required TResult Function(_SendOTP value) sendOTP,
    required TResult Function(_VerifyOTP value) verifyOTP,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
  }) {
    return verifyOTP(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_RegisterWithEmail value)? registerWithEmail,
    TResult? Function(_SignInWithEmail value)? signInWithEmail,
    TResult? Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult? Function(_SendOTP value)? sendOTP,
    TResult? Function(_VerifyOTP value)? verifyOTP,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
  }) {
    return verifyOTP?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_RegisterWithEmail value)? registerWithEmail,
    TResult Function(_SignInWithEmail value)? signInWithEmail,
    TResult Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult Function(_SendOTP value)? sendOTP,
    TResult Function(_VerifyOTP value)? verifyOTP,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    required TResult orElse(),
  }) {
    if (verifyOTP != null) {
      return verifyOTP(this);
    }
    return orElse();
  }
}

abstract class _VerifyOTP implements AuthEvent {
  const factory _VerifyOTP(
      {required final String phoneNumber,
      required final String verificationId,
      required final String code}) = _$VerifyOTPImpl;

  String get phoneNumber;
  String get verificationId;
  String get code;
  @JsonKey(ignore: true)
  _$$VerifyOTPImplCopyWith<_$VerifyOTPImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateProfileImplCopyWith<$Res> {
  factory _$$UpdateProfileImplCopyWith(
          _$UpdateProfileImpl value, $Res Function(_$UpdateProfileImpl) then) =
      __$$UpdateProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String? displayName, String? username, String? bio, String? avatarUrl});
}

/// @nodoc
class __$$UpdateProfileImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$UpdateProfileImpl>
    implements _$$UpdateProfileImplCopyWith<$Res> {
  __$$UpdateProfileImplCopyWithImpl(
      _$UpdateProfileImpl _value, $Res Function(_$UpdateProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? username = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(_$UpdateProfileImpl(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UpdateProfileImpl implements _UpdateProfile {
  const _$UpdateProfileImpl(
      {this.displayName, this.username, this.bio, this.avatarUrl});

  @override
  final String? displayName;
  @override
  final String? username;
  @override
  final String? bio;
  @override
  final String? avatarUrl;

  @override
  String toString() {
    return 'AuthEvent.updateProfile(displayName: $displayName, username: $username, bio: $bio, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateProfileImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, displayName, username, bio, avatarUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateProfileImplCopyWith<_$UpdateProfileImpl> get copyWith =>
      __$$UpdateProfileImplCopyWithImpl<_$UpdateProfileImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(
            String email, String password, String username, String? displayName)
        registerWithEmail,
    required TResult Function(String email, String password) signInWithEmail,
    required TResult Function() signInWithGoogle,
    required TResult Function(String phoneNumber) sendOTP,
    required TResult Function(
            String phoneNumber, String verificationId, String code)
        verifyOTP,
    required TResult Function(String? displayName, String? username,
            String? bio, String? avatarUrl)
        updateProfile,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
  }) {
    return updateProfile(displayName, username, bio, avatarUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult? Function(String email, String password)? signInWithEmail,
    TResult? Function()? signInWithGoogle,
    TResult? Function(String phoneNumber)? sendOTP,
    TResult? Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult? Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
  }) {
    return updateProfile?.call(displayName, username, bio, avatarUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult Function(String email, String password)? signInWithEmail,
    TResult Function()? signInWithGoogle,
    TResult Function(String phoneNumber)? sendOTP,
    TResult Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    required TResult orElse(),
  }) {
    if (updateProfile != null) {
      return updateProfile(displayName, username, bio, avatarUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_RegisterWithEmail value) registerWithEmail,
    required TResult Function(_SignInWithEmail value) signInWithEmail,
    required TResult Function(_SignInWithGoogle value) signInWithGoogle,
    required TResult Function(_SendOTP value) sendOTP,
    required TResult Function(_VerifyOTP value) verifyOTP,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
  }) {
    return updateProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_RegisterWithEmail value)? registerWithEmail,
    TResult? Function(_SignInWithEmail value)? signInWithEmail,
    TResult? Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult? Function(_SendOTP value)? sendOTP,
    TResult? Function(_VerifyOTP value)? verifyOTP,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
  }) {
    return updateProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_RegisterWithEmail value)? registerWithEmail,
    TResult Function(_SignInWithEmail value)? signInWithEmail,
    TResult Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult Function(_SendOTP value)? sendOTP,
    TResult Function(_VerifyOTP value)? verifyOTP,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    required TResult orElse(),
  }) {
    if (updateProfile != null) {
      return updateProfile(this);
    }
    return orElse();
  }
}

abstract class _UpdateProfile implements AuthEvent {
  const factory _UpdateProfile(
      {final String? displayName,
      final String? username,
      final String? bio,
      final String? avatarUrl}) = _$UpdateProfileImpl;

  String? get displayName;
  String? get username;
  String? get bio;
  String? get avatarUrl;
  @JsonKey(ignore: true)
  _$$UpdateProfileImplCopyWith<_$UpdateProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignOutImplCopyWith<$Res> {
  factory _$$SignOutImplCopyWith(
          _$SignOutImpl value, $Res Function(_$SignOutImpl) then) =
      __$$SignOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignOutImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignOutImpl>
    implements _$$SignOutImplCopyWith<$Res> {
  __$$SignOutImplCopyWithImpl(
      _$SignOutImpl _value, $Res Function(_$SignOutImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignOutImpl implements _SignOut {
  const _$SignOutImpl();

  @override
  String toString() {
    return 'AuthEvent.signOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignOutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(
            String email, String password, String username, String? displayName)
        registerWithEmail,
    required TResult Function(String email, String password) signInWithEmail,
    required TResult Function() signInWithGoogle,
    required TResult Function(String phoneNumber) sendOTP,
    required TResult Function(
            String phoneNumber, String verificationId, String code)
        verifyOTP,
    required TResult Function(String? displayName, String? username,
            String? bio, String? avatarUrl)
        updateProfile,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
  }) {
    return signOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult? Function(String email, String password)? signInWithEmail,
    TResult? Function()? signInWithGoogle,
    TResult? Function(String phoneNumber)? sendOTP,
    TResult? Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult? Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
  }) {
    return signOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult Function(String email, String password)? signInWithEmail,
    TResult Function()? signInWithGoogle,
    TResult Function(String phoneNumber)? sendOTP,
    TResult Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    required TResult orElse(),
  }) {
    if (signOut != null) {
      return signOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_RegisterWithEmail value) registerWithEmail,
    required TResult Function(_SignInWithEmail value) signInWithEmail,
    required TResult Function(_SignInWithGoogle value) signInWithGoogle,
    required TResult Function(_SendOTP value) sendOTP,
    required TResult Function(_VerifyOTP value) verifyOTP,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
  }) {
    return signOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_RegisterWithEmail value)? registerWithEmail,
    TResult? Function(_SignInWithEmail value)? signInWithEmail,
    TResult? Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult? Function(_SendOTP value)? sendOTP,
    TResult? Function(_VerifyOTP value)? verifyOTP,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
  }) {
    return signOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_RegisterWithEmail value)? registerWithEmail,
    TResult Function(_SignInWithEmail value)? signInWithEmail,
    TResult Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult Function(_SendOTP value)? sendOTP,
    TResult Function(_VerifyOTP value)? verifyOTP,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    required TResult orElse(),
  }) {
    if (signOut != null) {
      return signOut(this);
    }
    return orElse();
  }
}

abstract class _SignOut implements AuthEvent {
  const factory _SignOut() = _$SignOutImpl;
}

/// @nodoc
abstract class _$$DeleteAccountImplCopyWith<$Res> {
  factory _$$DeleteAccountImplCopyWith(
          _$DeleteAccountImpl value, $Res Function(_$DeleteAccountImpl) then) =
      __$$DeleteAccountImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeleteAccountImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$DeleteAccountImpl>
    implements _$$DeleteAccountImplCopyWith<$Res> {
  __$$DeleteAccountImplCopyWithImpl(
      _$DeleteAccountImpl _value, $Res Function(_$DeleteAccountImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DeleteAccountImpl implements _DeleteAccount {
  const _$DeleteAccountImpl();

  @override
  String toString() {
    return 'AuthEvent.deleteAccount()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeleteAccountImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkAuthStatus,
    required TResult Function(
            String email, String password, String username, String? displayName)
        registerWithEmail,
    required TResult Function(String email, String password) signInWithEmail,
    required TResult Function() signInWithGoogle,
    required TResult Function(String phoneNumber) sendOTP,
    required TResult Function(
            String phoneNumber, String verificationId, String code)
        verifyOTP,
    required TResult Function(String? displayName, String? username,
            String? bio, String? avatarUrl)
        updateProfile,
    required TResult Function() signOut,
    required TResult Function() deleteAccount,
  }) {
    return deleteAccount();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkAuthStatus,
    TResult? Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult? Function(String email, String password)? signInWithEmail,
    TResult? Function()? signInWithGoogle,
    TResult? Function(String phoneNumber)? sendOTP,
    TResult? Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult? Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult? Function()? signOut,
    TResult? Function()? deleteAccount,
  }) {
    return deleteAccount?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkAuthStatus,
    TResult Function(String email, String password, String username,
            String? displayName)?
        registerWithEmail,
    TResult Function(String email, String password)? signInWithEmail,
    TResult Function()? signInWithGoogle,
    TResult Function(String phoneNumber)? sendOTP,
    TResult Function(String phoneNumber, String verificationId, String code)?
        verifyOTP,
    TResult Function(String? displayName, String? username, String? bio,
            String? avatarUrl)?
        updateProfile,
    TResult Function()? signOut,
    TResult Function()? deleteAccount,
    required TResult orElse(),
  }) {
    if (deleteAccount != null) {
      return deleteAccount();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CheckAuthStatus value) checkAuthStatus,
    required TResult Function(_RegisterWithEmail value) registerWithEmail,
    required TResult Function(_SignInWithEmail value) signInWithEmail,
    required TResult Function(_SignInWithGoogle value) signInWithGoogle,
    required TResult Function(_SendOTP value) sendOTP,
    required TResult Function(_VerifyOTP value) verifyOTP,
    required TResult Function(_UpdateProfile value) updateProfile,
    required TResult Function(_SignOut value) signOut,
    required TResult Function(_DeleteAccount value) deleteAccount,
  }) {
    return deleteAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult? Function(_RegisterWithEmail value)? registerWithEmail,
    TResult? Function(_SignInWithEmail value)? signInWithEmail,
    TResult? Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult? Function(_SendOTP value)? sendOTP,
    TResult? Function(_VerifyOTP value)? verifyOTP,
    TResult? Function(_UpdateProfile value)? updateProfile,
    TResult? Function(_SignOut value)? signOut,
    TResult? Function(_DeleteAccount value)? deleteAccount,
  }) {
    return deleteAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CheckAuthStatus value)? checkAuthStatus,
    TResult Function(_RegisterWithEmail value)? registerWithEmail,
    TResult Function(_SignInWithEmail value)? signInWithEmail,
    TResult Function(_SignInWithGoogle value)? signInWithGoogle,
    TResult Function(_SendOTP value)? sendOTP,
    TResult Function(_VerifyOTP value)? verifyOTP,
    TResult Function(_UpdateProfile value)? updateProfile,
    TResult Function(_SignOut value)? signOut,
    TResult Function(_DeleteAccount value)? deleteAccount,
    required TResult orElse(),
  }) {
    if (deleteAccount != null) {
      return deleteAccount(this);
    }
    return orElse();
  }
}

abstract class _DeleteAccount implements AuthEvent {
  const factory _DeleteAccount() = _$DeleteAccountImpl;
}

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(String verificationId, String phoneNumber)
        otpSent,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function(UserEntity user) profileIncomplete,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function(String verificationId, String phoneNumber)? otpSent,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function(UserEntity user)? profileIncomplete,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(String verificationId, String phoneNumber)? otpSent,
    TResult Function(UserEntity user)? authenticated,
    TResult Function(UserEntity user)? profileIncomplete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpSent value) otpSent,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_ProfileIncomplete value) profileIncomplete,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpSent value)? otpSent,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_ProfileIncomplete value)? profileIncomplete,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpSent value)? otpSent,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_ProfileIncomplete value)? profileIncomplete,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(String verificationId, String phoneNumber)
        otpSent,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function(UserEntity user) profileIncomplete,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function(String verificationId, String phoneNumber)? otpSent,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function(UserEntity user)? profileIncomplete,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(String verificationId, String phoneNumber)? otpSent,
    TResult Function(UserEntity user)? authenticated,
    TResult Function(UserEntity user)? profileIncomplete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpSent value) otpSent,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_ProfileIncomplete value) profileIncomplete,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpSent value)? otpSent,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_ProfileIncomplete value)? profileIncomplete,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpSent value)? otpSent,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_ProfileIncomplete value)? profileIncomplete,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AuthState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(String verificationId, String phoneNumber)
        otpSent,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function(UserEntity user) profileIncomplete,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function(String verificationId, String phoneNumber)? otpSent,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function(UserEntity user)? profileIncomplete,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(String verificationId, String phoneNumber)? otpSent,
    TResult Function(UserEntity user)? authenticated,
    TResult Function(UserEntity user)? profileIncomplete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpSent value) otpSent,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_ProfileIncomplete value) profileIncomplete,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpSent value)? otpSent,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_ProfileIncomplete value)? profileIncomplete,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpSent value)? otpSent,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_ProfileIncomplete value)? profileIncomplete,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AuthState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$UnauthenticatedImplCopyWith<$Res> {
  factory _$$UnauthenticatedImplCopyWith(_$UnauthenticatedImpl value,
          $Res Function(_$UnauthenticatedImpl) then) =
      __$$UnauthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnauthenticatedImpl>
    implements _$$UnauthenticatedImplCopyWith<$Res> {
  __$$UnauthenticatedImplCopyWithImpl(
      _$UnauthenticatedImpl _value, $Res Function(_$UnauthenticatedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UnauthenticatedImpl implements _Unauthenticated {
  const _$UnauthenticatedImpl();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(String verificationId, String phoneNumber)
        otpSent,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function(UserEntity user) profileIncomplete,
    required TResult Function(String message) error,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function(String verificationId, String phoneNumber)? otpSent,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function(UserEntity user)? profileIncomplete,
    TResult? Function(String message)? error,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(String verificationId, String phoneNumber)? otpSent,
    TResult Function(UserEntity user)? authenticated,
    TResult Function(UserEntity user)? profileIncomplete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpSent value) otpSent,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_ProfileIncomplete value) profileIncomplete,
    required TResult Function(_Error value) error,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpSent value)? otpSent,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_ProfileIncomplete value)? profileIncomplete,
    TResult? Function(_Error value)? error,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpSent value)? otpSent,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_ProfileIncomplete value)? profileIncomplete,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _Unauthenticated implements AuthState {
  const factory _Unauthenticated() = _$UnauthenticatedImpl;
}

/// @nodoc
abstract class _$$OtpSentImplCopyWith<$Res> {
  factory _$$OtpSentImplCopyWith(
          _$OtpSentImpl value, $Res Function(_$OtpSentImpl) then) =
      __$$OtpSentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String verificationId, String phoneNumber});
}

/// @nodoc
class __$$OtpSentImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$OtpSentImpl>
    implements _$$OtpSentImplCopyWith<$Res> {
  __$$OtpSentImplCopyWithImpl(
      _$OtpSentImpl _value, $Res Function(_$OtpSentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verificationId = null,
    Object? phoneNumber = null,
  }) {
    return _then(_$OtpSentImpl(
      verificationId: null == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OtpSentImpl implements _OtpSent {
  const _$OtpSentImpl(
      {required this.verificationId, required this.phoneNumber});

  @override
  final String verificationId;
  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'AuthState.otpSent(verificationId: $verificationId, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpSentImpl &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, verificationId, phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpSentImplCopyWith<_$OtpSentImpl> get copyWith =>
      __$$OtpSentImplCopyWithImpl<_$OtpSentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(String verificationId, String phoneNumber)
        otpSent,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function(UserEntity user) profileIncomplete,
    required TResult Function(String message) error,
  }) {
    return otpSent(verificationId, phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function(String verificationId, String phoneNumber)? otpSent,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function(UserEntity user)? profileIncomplete,
    TResult? Function(String message)? error,
  }) {
    return otpSent?.call(verificationId, phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(String verificationId, String phoneNumber)? otpSent,
    TResult Function(UserEntity user)? authenticated,
    TResult Function(UserEntity user)? profileIncomplete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (otpSent != null) {
      return otpSent(verificationId, phoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpSent value) otpSent,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_ProfileIncomplete value) profileIncomplete,
    required TResult Function(_Error value) error,
  }) {
    return otpSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpSent value)? otpSent,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_ProfileIncomplete value)? profileIncomplete,
    TResult? Function(_Error value)? error,
  }) {
    return otpSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpSent value)? otpSent,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_ProfileIncomplete value)? profileIncomplete,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (otpSent != null) {
      return otpSent(this);
    }
    return orElse();
  }
}

abstract class _OtpSent implements AuthState {
  const factory _OtpSent(
      {required final String verificationId,
      required final String phoneNumber}) = _$OtpSentImpl;

  String get verificationId;
  String get phoneNumber;
  @JsonKey(ignore: true)
  _$$OtpSentImplCopyWith<_$OtpSentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
          _$AuthenticatedImpl value, $Res Function(_$AuthenticatedImpl) then) =
      __$$AuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserEntity user});

  $UserEntityCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
      _$AuthenticatedImpl _value, $Res Function(_$AuthenticatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$AuthenticatedImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res> get user {
    return $UserEntityCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$AuthenticatedImpl implements _Authenticated {
  const _$AuthenticatedImpl(this.user);

  @override
  final UserEntity user;

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      __$$AuthenticatedImplCopyWithImpl<_$AuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(String verificationId, String phoneNumber)
        otpSent,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function(UserEntity user) profileIncomplete,
    required TResult Function(String message) error,
  }) {
    return authenticated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function(String verificationId, String phoneNumber)? otpSent,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function(UserEntity user)? profileIncomplete,
    TResult? Function(String message)? error,
  }) {
    return authenticated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(String verificationId, String phoneNumber)? otpSent,
    TResult Function(UserEntity user)? authenticated,
    TResult Function(UserEntity user)? profileIncomplete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpSent value) otpSent,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_ProfileIncomplete value) profileIncomplete,
    required TResult Function(_Error value) error,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpSent value)? otpSent,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_ProfileIncomplete value)? profileIncomplete,
    TResult? Function(_Error value)? error,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpSent value)? otpSent,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_ProfileIncomplete value)? profileIncomplete,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements AuthState {
  const factory _Authenticated(final UserEntity user) = _$AuthenticatedImpl;

  UserEntity get user;
  @JsonKey(ignore: true)
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProfileIncompleteImplCopyWith<$Res> {
  factory _$$ProfileIncompleteImplCopyWith(_$ProfileIncompleteImpl value,
          $Res Function(_$ProfileIncompleteImpl) then) =
      __$$ProfileIncompleteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserEntity user});

  $UserEntityCopyWith<$Res> get user;
}

/// @nodoc
class __$$ProfileIncompleteImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$ProfileIncompleteImpl>
    implements _$$ProfileIncompleteImplCopyWith<$Res> {
  __$$ProfileIncompleteImplCopyWithImpl(_$ProfileIncompleteImpl _value,
      $Res Function(_$ProfileIncompleteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$ProfileIncompleteImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserEntity,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserEntityCopyWith<$Res> get user {
    return $UserEntityCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$ProfileIncompleteImpl implements _ProfileIncomplete {
  const _$ProfileIncompleteImpl(this.user);

  @override
  final UserEntity user;

  @override
  String toString() {
    return 'AuthState.profileIncomplete(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileIncompleteImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileIncompleteImplCopyWith<_$ProfileIncompleteImpl> get copyWith =>
      __$$ProfileIncompleteImplCopyWithImpl<_$ProfileIncompleteImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(String verificationId, String phoneNumber)
        otpSent,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function(UserEntity user) profileIncomplete,
    required TResult Function(String message) error,
  }) {
    return profileIncomplete(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function(String verificationId, String phoneNumber)? otpSent,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function(UserEntity user)? profileIncomplete,
    TResult? Function(String message)? error,
  }) {
    return profileIncomplete?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(String verificationId, String phoneNumber)? otpSent,
    TResult Function(UserEntity user)? authenticated,
    TResult Function(UserEntity user)? profileIncomplete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (profileIncomplete != null) {
      return profileIncomplete(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpSent value) otpSent,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_ProfileIncomplete value) profileIncomplete,
    required TResult Function(_Error value) error,
  }) {
    return profileIncomplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpSent value)? otpSent,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_ProfileIncomplete value)? profileIncomplete,
    TResult? Function(_Error value)? error,
  }) {
    return profileIncomplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpSent value)? otpSent,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_ProfileIncomplete value)? profileIncomplete,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (profileIncomplete != null) {
      return profileIncomplete(this);
    }
    return orElse();
  }
}

abstract class _ProfileIncomplete implements AuthState {
  const factory _ProfileIncomplete(final UserEntity user) =
      _$ProfileIncompleteImpl;

  UserEntity get user;
  @JsonKey(ignore: true)
  _$$ProfileIncompleteImplCopyWith<_$ProfileIncompleteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() unauthenticated,
    required TResult Function(String verificationId, String phoneNumber)
        otpSent,
    required TResult Function(UserEntity user) authenticated,
    required TResult Function(UserEntity user) profileIncomplete,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? unauthenticated,
    TResult? Function(String verificationId, String phoneNumber)? otpSent,
    TResult? Function(UserEntity user)? authenticated,
    TResult? Function(UserEntity user)? profileIncomplete,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? unauthenticated,
    TResult Function(String verificationId, String phoneNumber)? otpSent,
    TResult Function(UserEntity user)? authenticated,
    TResult Function(UserEntity user)? profileIncomplete,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpSent value) otpSent,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_ProfileIncomplete value) profileIncomplete,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpSent value)? otpSent,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_ProfileIncomplete value)? profileIncomplete,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpSent value)? otpSent,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_ProfileIncomplete value)? profileIncomplete,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AuthState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
