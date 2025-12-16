import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../bloc/contacts_bloc.dart';
import '../widgets/contact_list_item.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _searchController = TextEditingController();
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchUsers(BuildContext context) {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<ContactsBloc>().add(ContactsEvent.searchUsers(query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ContactsBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Contact', style: AppTypography.h3),
        ),
        body: BlocConsumer<ContactsBloc, ContactsState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (message) {
                CustomSnackbar.showError(context, message);
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by phone or username',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      ),
                      filled: true,
                      fillColor: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.surfaceDark
                          : AppColors.surfaceLight,
                    ),
                    onSubmitted: (_) => _searchUsers(context),
                  ),
                ),

                // Search Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: ElevatedButton(
                    onPressed: () => _searchUsers(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('Search'),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Results
                Expanded(
                  child: state.maybeWhen(
                    loading: () => const LoadingWidget(),
                    searchResults: (users) {
                      if (users.isEmpty) {
                        return Center(
                          child: Text(
                            'No users found',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textSecondaryLight,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return ContactListItem(
                            contact: user,
                            onTap: () {
                              // Show add contact dialog
                              showDialog(
                                context: context,
                                builder: (dialogContext) => AlertDialog(
                                  title: const Text('Add Contact'),
                                  content: Text(
                                    'Add ${user.displayName} to your contacts?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(dialogContext),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<ContactsBloc>().add(
                                          ContactsEvent.addContact(user.userId),
                                        );
                                        Navigator.pop(dialogContext);
                                        if (context.mounted) {
                                          CustomSnackbar.showSuccess(
                                            context,
                                            'Contact added successfully',
                                          );
                                          Future.delayed(
                                            const Duration(seconds: 1),
                                            () {
                                              if (context.mounted) {
                                                context.pop();
                                              }
                                            },
                                          );
                                        }
                                      },
                                      child: const Text('Add'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    orElse: () => Center(
                      child: Text(
                        'Search for users by phone number or username',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
