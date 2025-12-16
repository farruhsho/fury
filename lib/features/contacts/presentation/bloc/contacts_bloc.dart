import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/contact_entity.dart';
import '../../domain/usecases/get_contacts_usecase.dart';
import '../../domain/usecases/search_users_usecase.dart';
import '../../domain/usecases/add_contact_usecase.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';
part 'contacts_bloc.freezed.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final GetContactsUseCase getContactsUseCase;
  final SearchUsersUseCase searchUsersUseCase;
  final AddContactUseCase addContactUseCase;

  ContactsBloc({
    required this.getContactsUseCase,
    required this.searchUsersUseCase,
    required this.addContactUseCase,
  }) : super(const ContactsState.initial()) {
    on<_LoadContacts>(_onLoadContacts);
    on<_SearchUsers>(_onSearchUsers);
    on<_AddContact>(_onAddContact);
  }

  Future<void> _onLoadContacts(
    _LoadContacts event,
    Emitter<ContactsState> emit,
  ) async {
    emit(const ContactsState.loading());

    await emit.forEach(
      getContactsUseCase(),
      onData: (result) => result.fold(
        (failure) => ContactsState.error(ErrorHandler.getUserMessage(failure)),
        (contacts) => ContactsState.loaded(contacts),
      ),
      onError: (error, stackTrace) => ContactsState.error(error.toString()),
    );
  }

  Future<void> _onSearchUsers(
    _SearchUsers event,
    Emitter<ContactsState> emit,
  ) async {
    emit(const ContactsState.loading());

    final result = await searchUsersUseCase(event.query);

    result.fold(
      (failure) => emit(ContactsState.error(ErrorHandler.getUserMessage(failure))),
      (users) => emit(ContactsState.searchResults(users)),
    );
  }

  Future<void> _onAddContact(
    _AddContact event,
    Emitter<ContactsState> emit,
  ) async {
    final result = await addContactUseCase(event.userId);

    result.fold(
      (failure) => emit(ContactsState.error(ErrorHandler.getUserMessage(failure))),
      (_) {
        // Contact added successfully, reload contacts
        add(const ContactsEvent.loadContacts());
      },
    );
  }
}
