import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../chat/domain/usecases/create_chat_usecase.dart';
import '../../../chat/domain/entities/chat_entity.dart';
import '../bloc/contacts_bloc.dart';
import '../widgets/contact_list_item.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ContactsBloc>()..add(const ContactsEvent.loadContacts()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contacts', style: AppTypography.h3),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: () => context.push('/add-contact'),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // TODO: Implement search
              },
            ),
          ],
        ),
        body: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const LoadingWidget(),
              error: (message) => ErrorDisplayWidget(
                message: message,
                onRetry: () {
                  context.read<ContactsBloc>().add(const ContactsEvent.loadContacts());
                },
              ),
              loaded: (contacts) {
                if (contacts.isEmpty) {
                  return EmptyStateWidget(
                    title: 'No contacts yet',
                    subtitle: 'Add contacts to start chatting',
                    icon: Icons.contacts,
                    action: ElevatedButton.icon(
                      onPressed: () => context.push('/add-contact'),
                      icon: const Icon(Icons.person_add),
                      label: const Text('Add Contact'),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return ContactListItem(
                      contact: contact,
                      onTap: () async {
                        // Create or navigate to chat
                        final createChatUseCase = sl<CreateChatUseCase>();
                        final result = await createChatUseCase(
                          participantIds: [contact.userId],
                          type: ChatType.private,
                        );
                        
                        result.fold(
                          (failure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${failure.message}')),
                            );
                          },
                          (chatId) {
                            context.push('/chat/$chatId');
                          },
                        );
                      },
                    );
                  },
                );
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/add-contact'),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.person_add, color: Colors.white),
        ),
      ),
    );
  }
}
