part of 'contacts_bloc.dart';

@freezed
class ContactsEvent with _$ContactsEvent {
  const factory ContactsEvent.loadContacts() = _LoadContacts;
  const factory ContactsEvent.searchUsers(String query) = _SearchUsers;
  const factory ContactsEvent.addContact(String userId) = _AddContact;
  const factory ContactsEvent.removeContact(String contactId) = _RemoveContact;
  const factory ContactsEvent.blockContact(String contactId) = _BlockContact;
}
