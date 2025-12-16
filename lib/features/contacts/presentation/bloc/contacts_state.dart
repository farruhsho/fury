part of 'contacts_bloc.dart';

@freezed
class ContactsState with _$ContactsState {
  const factory ContactsState.initial() = _Initial;
  const factory ContactsState.loading() = _Loading;
  const factory ContactsState.loaded(List<ContactEntity> contacts) = _Loaded;
  const factory ContactsState.searchResults(List<ContactEntity> users) = _SearchResults;
  const factory ContactsState.error(String message) = _Error;
}
