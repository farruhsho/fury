// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contacts_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ContactsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContacts,
    required TResult Function(String query) searchUsers,
    required TResult Function(String userId) addContact,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContacts,
    TResult? Function(String query)? searchUsers,
    TResult? Function(String userId)? addContact,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContacts,
    TResult Function(String query)? searchUsers,
    TResult Function(String userId)? addContact,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadContacts value) loadContacts,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_AddContact value) addContact,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadContacts value)? loadContacts,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_AddContact value)? addContact,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadContacts value)? loadContacts,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_AddContact value)? addContact,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactsEventCopyWith<$Res> {
  factory $ContactsEventCopyWith(
          ContactsEvent value, $Res Function(ContactsEvent) then) =
      _$ContactsEventCopyWithImpl<$Res, ContactsEvent>;
}

/// @nodoc
class _$ContactsEventCopyWithImpl<$Res, $Val extends ContactsEvent>
    implements $ContactsEventCopyWith<$Res> {
  _$ContactsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadContactsImplCopyWith<$Res> {
  factory _$$LoadContactsImplCopyWith(
          _$LoadContactsImpl value, $Res Function(_$LoadContactsImpl) then) =
      __$$LoadContactsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadContactsImplCopyWithImpl<$Res>
    extends _$ContactsEventCopyWithImpl<$Res, _$LoadContactsImpl>
    implements _$$LoadContactsImplCopyWith<$Res> {
  __$$LoadContactsImplCopyWithImpl(
      _$LoadContactsImpl _value, $Res Function(_$LoadContactsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadContactsImpl implements _LoadContacts {
  const _$LoadContactsImpl();

  @override
  String toString() {
    return 'ContactsEvent.loadContacts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadContactsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContacts,
    required TResult Function(String query) searchUsers,
    required TResult Function(String userId) addContact,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
  }) {
    return loadContacts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContacts,
    TResult? Function(String query)? searchUsers,
    TResult? Function(String userId)? addContact,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
  }) {
    return loadContacts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContacts,
    TResult Function(String query)? searchUsers,
    TResult Function(String userId)? addContact,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    required TResult orElse(),
  }) {
    if (loadContacts != null) {
      return loadContacts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadContacts value) loadContacts,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_AddContact value) addContact,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
  }) {
    return loadContacts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadContacts value)? loadContacts,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_AddContact value)? addContact,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
  }) {
    return loadContacts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadContacts value)? loadContacts,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_AddContact value)? addContact,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    required TResult orElse(),
  }) {
    if (loadContacts != null) {
      return loadContacts(this);
    }
    return orElse();
  }
}

abstract class _LoadContacts implements ContactsEvent {
  const factory _LoadContacts() = _$LoadContactsImpl;
}

/// @nodoc
abstract class _$$SearchUsersImplCopyWith<$Res> {
  factory _$$SearchUsersImplCopyWith(
          _$SearchUsersImpl value, $Res Function(_$SearchUsersImpl) then) =
      __$$SearchUsersImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchUsersImplCopyWithImpl<$Res>
    extends _$ContactsEventCopyWithImpl<$Res, _$SearchUsersImpl>
    implements _$$SearchUsersImplCopyWith<$Res> {
  __$$SearchUsersImplCopyWithImpl(
      _$SearchUsersImpl _value, $Res Function(_$SearchUsersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$SearchUsersImpl(
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchUsersImpl implements _SearchUsers {
  const _$SearchUsersImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'ContactsEvent.searchUsers(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchUsersImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchUsersImplCopyWith<_$SearchUsersImpl> get copyWith =>
      __$$SearchUsersImplCopyWithImpl<_$SearchUsersImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContacts,
    required TResult Function(String query) searchUsers,
    required TResult Function(String userId) addContact,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
  }) {
    return searchUsers(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContacts,
    TResult? Function(String query)? searchUsers,
    TResult? Function(String userId)? addContact,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
  }) {
    return searchUsers?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContacts,
    TResult Function(String query)? searchUsers,
    TResult Function(String userId)? addContact,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    required TResult orElse(),
  }) {
    if (searchUsers != null) {
      return searchUsers(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadContacts value) loadContacts,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_AddContact value) addContact,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
  }) {
    return searchUsers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadContacts value)? loadContacts,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_AddContact value)? addContact,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
  }) {
    return searchUsers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadContacts value)? loadContacts,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_AddContact value)? addContact,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    required TResult orElse(),
  }) {
    if (searchUsers != null) {
      return searchUsers(this);
    }
    return orElse();
  }
}

abstract class _SearchUsers implements ContactsEvent {
  const factory _SearchUsers(final String query) = _$SearchUsersImpl;

  String get query;
  @JsonKey(ignore: true)
  _$$SearchUsersImplCopyWith<_$SearchUsersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddContactImplCopyWith<$Res> {
  factory _$$AddContactImplCopyWith(
          _$AddContactImpl value, $Res Function(_$AddContactImpl) then) =
      __$$AddContactImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$AddContactImplCopyWithImpl<$Res>
    extends _$ContactsEventCopyWithImpl<$Res, _$AddContactImpl>
    implements _$$AddContactImplCopyWith<$Res> {
  __$$AddContactImplCopyWithImpl(
      _$AddContactImpl _value, $Res Function(_$AddContactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$AddContactImpl(
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddContactImpl implements _AddContact {
  const _$AddContactImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'ContactsEvent.addContact(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddContactImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddContactImplCopyWith<_$AddContactImpl> get copyWith =>
      __$$AddContactImplCopyWithImpl<_$AddContactImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContacts,
    required TResult Function(String query) searchUsers,
    required TResult Function(String userId) addContact,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
  }) {
    return addContact(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContacts,
    TResult? Function(String query)? searchUsers,
    TResult? Function(String userId)? addContact,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
  }) {
    return addContact?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContacts,
    TResult Function(String query)? searchUsers,
    TResult Function(String userId)? addContact,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    required TResult orElse(),
  }) {
    if (addContact != null) {
      return addContact(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadContacts value) loadContacts,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_AddContact value) addContact,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
  }) {
    return addContact(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadContacts value)? loadContacts,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_AddContact value)? addContact,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
  }) {
    return addContact?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadContacts value)? loadContacts,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_AddContact value)? addContact,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    required TResult orElse(),
  }) {
    if (addContact != null) {
      return addContact(this);
    }
    return orElse();
  }
}

abstract class _AddContact implements ContactsEvent {
  const factory _AddContact(final String userId) = _$AddContactImpl;

  String get userId;
  @JsonKey(ignore: true)
  _$$AddContactImplCopyWith<_$AddContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveContactImplCopyWith<$Res> {
  factory _$$RemoveContactImplCopyWith(
          _$RemoveContactImpl value, $Res Function(_$RemoveContactImpl) then) =
      __$$RemoveContactImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String contactId});
}

/// @nodoc
class __$$RemoveContactImplCopyWithImpl<$Res>
    extends _$ContactsEventCopyWithImpl<$Res, _$RemoveContactImpl>
    implements _$$RemoveContactImplCopyWith<$Res> {
  __$$RemoveContactImplCopyWithImpl(
      _$RemoveContactImpl _value, $Res Function(_$RemoveContactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contactId = null,
  }) {
    return _then(_$RemoveContactImpl(
      null == contactId
          ? _value.contactId
          : contactId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemoveContactImpl implements _RemoveContact {
  const _$RemoveContactImpl(this.contactId);

  @override
  final String contactId;

  @override
  String toString() {
    return 'ContactsEvent.removeContact(contactId: $contactId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveContactImpl &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveContactImplCopyWith<_$RemoveContactImpl> get copyWith =>
      __$$RemoveContactImplCopyWithImpl<_$RemoveContactImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContacts,
    required TResult Function(String query) searchUsers,
    required TResult Function(String userId) addContact,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
  }) {
    return removeContact(contactId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContacts,
    TResult? Function(String query)? searchUsers,
    TResult? Function(String userId)? addContact,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
  }) {
    return removeContact?.call(contactId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContacts,
    TResult Function(String query)? searchUsers,
    TResult Function(String userId)? addContact,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    required TResult orElse(),
  }) {
    if (removeContact != null) {
      return removeContact(contactId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadContacts value) loadContacts,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_AddContact value) addContact,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
  }) {
    return removeContact(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadContacts value)? loadContacts,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_AddContact value)? addContact,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
  }) {
    return removeContact?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadContacts value)? loadContacts,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_AddContact value)? addContact,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    required TResult orElse(),
  }) {
    if (removeContact != null) {
      return removeContact(this);
    }
    return orElse();
  }
}

abstract class _RemoveContact implements ContactsEvent {
  const factory _RemoveContact(final String contactId) = _$RemoveContactImpl;

  String get contactId;
  @JsonKey(ignore: true)
  _$$RemoveContactImplCopyWith<_$RemoveContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BlockContactImplCopyWith<$Res> {
  factory _$$BlockContactImplCopyWith(
          _$BlockContactImpl value, $Res Function(_$BlockContactImpl) then) =
      __$$BlockContactImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String contactId});
}

/// @nodoc
class __$$BlockContactImplCopyWithImpl<$Res>
    extends _$ContactsEventCopyWithImpl<$Res, _$BlockContactImpl>
    implements _$$BlockContactImplCopyWith<$Res> {
  __$$BlockContactImplCopyWithImpl(
      _$BlockContactImpl _value, $Res Function(_$BlockContactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contactId = null,
  }) {
    return _then(_$BlockContactImpl(
      null == contactId
          ? _value.contactId
          : contactId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BlockContactImpl implements _BlockContact {
  const _$BlockContactImpl(this.contactId);

  @override
  final String contactId;

  @override
  String toString() {
    return 'ContactsEvent.blockContact(contactId: $contactId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockContactImpl &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contactId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockContactImplCopyWith<_$BlockContactImpl> get copyWith =>
      __$$BlockContactImplCopyWithImpl<_$BlockContactImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadContacts,
    required TResult Function(String query) searchUsers,
    required TResult Function(String userId) addContact,
    required TResult Function(String contactId) removeContact,
    required TResult Function(String contactId) blockContact,
  }) {
    return blockContact(contactId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadContacts,
    TResult? Function(String query)? searchUsers,
    TResult? Function(String userId)? addContact,
    TResult? Function(String contactId)? removeContact,
    TResult? Function(String contactId)? blockContact,
  }) {
    return blockContact?.call(contactId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadContacts,
    TResult Function(String query)? searchUsers,
    TResult Function(String userId)? addContact,
    TResult Function(String contactId)? removeContact,
    TResult Function(String contactId)? blockContact,
    required TResult orElse(),
  }) {
    if (blockContact != null) {
      return blockContact(contactId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadContacts value) loadContacts,
    required TResult Function(_SearchUsers value) searchUsers,
    required TResult Function(_AddContact value) addContact,
    required TResult Function(_RemoveContact value) removeContact,
    required TResult Function(_BlockContact value) blockContact,
  }) {
    return blockContact(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadContacts value)? loadContacts,
    TResult? Function(_SearchUsers value)? searchUsers,
    TResult? Function(_AddContact value)? addContact,
    TResult? Function(_RemoveContact value)? removeContact,
    TResult? Function(_BlockContact value)? blockContact,
  }) {
    return blockContact?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadContacts value)? loadContacts,
    TResult Function(_SearchUsers value)? searchUsers,
    TResult Function(_AddContact value)? addContact,
    TResult Function(_RemoveContact value)? removeContact,
    TResult Function(_BlockContact value)? blockContact,
    required TResult orElse(),
  }) {
    if (blockContact != null) {
      return blockContact(this);
    }
    return orElse();
  }
}

abstract class _BlockContact implements ContactsEvent {
  const factory _BlockContact(final String contactId) = _$BlockContactImpl;

  String get contactId;
  @JsonKey(ignore: true)
  _$$BlockContactImplCopyWith<_$BlockContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ContactsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ContactEntity> contacts) loaded,
    required TResult Function(List<ContactEntity> users) searchResults,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ContactEntity> contacts)? loaded,
    TResult? Function(List<ContactEntity> users)? searchResults,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ContactEntity> contacts)? loaded,
    TResult Function(List<ContactEntity> users)? searchResults,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_SearchResults value) searchResults,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_SearchResults value)? searchResults,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_SearchResults value)? searchResults,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactsStateCopyWith<$Res> {
  factory $ContactsStateCopyWith(
          ContactsState value, $Res Function(ContactsState) then) =
      _$ContactsStateCopyWithImpl<$Res, ContactsState>;
}

/// @nodoc
class _$ContactsStateCopyWithImpl<$Res, $Val extends ContactsState>
    implements $ContactsStateCopyWith<$Res> {
  _$ContactsStateCopyWithImpl(this._value, this._then);

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
    extends _$ContactsStateCopyWithImpl<$Res, _$InitialImpl>
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
    return 'ContactsState.initial()';
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
    required TResult Function(List<ContactEntity> contacts) loaded,
    required TResult Function(List<ContactEntity> users) searchResults,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ContactEntity> contacts)? loaded,
    TResult? Function(List<ContactEntity> users)? searchResults,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ContactEntity> contacts)? loaded,
    TResult Function(List<ContactEntity> users)? searchResults,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_SearchResults value) searchResults,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_SearchResults value)? searchResults,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_SearchResults value)? searchResults,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ContactsState {
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
    extends _$ContactsStateCopyWithImpl<$Res, _$LoadingImpl>
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
    return 'ContactsState.loading()';
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
    required TResult Function(List<ContactEntity> contacts) loaded,
    required TResult Function(List<ContactEntity> users) searchResults,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ContactEntity> contacts)? loaded,
    TResult? Function(List<ContactEntity> users)? searchResults,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ContactEntity> contacts)? loaded,
    TResult Function(List<ContactEntity> users)? searchResults,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_SearchResults value) searchResults,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_SearchResults value)? searchResults,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_SearchResults value)? searchResults,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ContactsState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ContactEntity> contacts});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ContactsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contacts = null,
  }) {
    return _then(_$LoadedImpl(
      null == contacts
          ? _value._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<ContactEntity>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(final List<ContactEntity> contacts) : _contacts = contacts;

  final List<ContactEntity> _contacts;
  @override
  List<ContactEntity> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  @override
  String toString() {
    return 'ContactsState.loaded(contacts: $contacts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._contacts, _contacts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_contacts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ContactEntity> contacts) loaded,
    required TResult Function(List<ContactEntity> users) searchResults,
    required TResult Function(String message) error,
  }) {
    return loaded(contacts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ContactEntity> contacts)? loaded,
    TResult? Function(List<ContactEntity> users)? searchResults,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(contacts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ContactEntity> contacts)? loaded,
    TResult Function(List<ContactEntity> users)? searchResults,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(contacts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_SearchResults value) searchResults,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_SearchResults value)? searchResults,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_SearchResults value)? searchResults,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ContactsState {
  const factory _Loaded(final List<ContactEntity> contacts) = _$LoadedImpl;

  List<ContactEntity> get contacts;
  @JsonKey(ignore: true)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchResultsImplCopyWith<$Res> {
  factory _$$SearchResultsImplCopyWith(
          _$SearchResultsImpl value, $Res Function(_$SearchResultsImpl) then) =
      __$$SearchResultsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ContactEntity> users});
}

/// @nodoc
class __$$SearchResultsImplCopyWithImpl<$Res>
    extends _$ContactsStateCopyWithImpl<$Res, _$SearchResultsImpl>
    implements _$$SearchResultsImplCopyWith<$Res> {
  __$$SearchResultsImplCopyWithImpl(
      _$SearchResultsImpl _value, $Res Function(_$SearchResultsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
  }) {
    return _then(_$SearchResultsImpl(
      null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<ContactEntity>,
    ));
  }
}

/// @nodoc

class _$SearchResultsImpl implements _SearchResults {
  const _$SearchResultsImpl(final List<ContactEntity> users) : _users = users;

  final List<ContactEntity> _users;
  @override
  List<ContactEntity> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString() {
    return 'ContactsState.searchResults(users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultsImpl &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_users));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultsImplCopyWith<_$SearchResultsImpl> get copyWith =>
      __$$SearchResultsImplCopyWithImpl<_$SearchResultsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<ContactEntity> contacts) loaded,
    required TResult Function(List<ContactEntity> users) searchResults,
    required TResult Function(String message) error,
  }) {
    return searchResults(users);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ContactEntity> contacts)? loaded,
    TResult? Function(List<ContactEntity> users)? searchResults,
    TResult? Function(String message)? error,
  }) {
    return searchResults?.call(users);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ContactEntity> contacts)? loaded,
    TResult Function(List<ContactEntity> users)? searchResults,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (searchResults != null) {
      return searchResults(users);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_SearchResults value) searchResults,
    required TResult Function(_Error value) error,
  }) {
    return searchResults(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_SearchResults value)? searchResults,
    TResult? Function(_Error value)? error,
  }) {
    return searchResults?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_SearchResults value)? searchResults,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (searchResults != null) {
      return searchResults(this);
    }
    return orElse();
  }
}

abstract class _SearchResults implements ContactsState {
  const factory _SearchResults(final List<ContactEntity> users) =
      _$SearchResultsImpl;

  List<ContactEntity> get users;
  @JsonKey(ignore: true)
  _$$SearchResultsImplCopyWith<_$SearchResultsImpl> get copyWith =>
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
    extends _$ContactsStateCopyWithImpl<$Res, _$ErrorImpl>
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
    return 'ContactsState.error(message: $message)';
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
    required TResult Function(List<ContactEntity> contacts) loaded,
    required TResult Function(List<ContactEntity> users) searchResults,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<ContactEntity> contacts)? loaded,
    TResult? Function(List<ContactEntity> users)? searchResults,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<ContactEntity> contacts)? loaded,
    TResult Function(List<ContactEntity> users)? searchResults,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_SearchResults value) searchResults,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_SearchResults value)? searchResults,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_SearchResults value)? searchResults,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ContactsState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
