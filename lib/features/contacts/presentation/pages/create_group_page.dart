import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../chat/domain/usecases/create_chat_usecase.dart';
import '../../../chat/domain/entities/chat_entity.dart';
import '../../../contacts/presentation/bloc/contacts_bloc.dart';
import '../../../contacts/domain/entities/contact_entity.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final _nameController = TextEditingController();
  final _selectedMembers = <ContactEntity>[];
  File? _groupImage;
  bool _isCreating = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _groupImage = File(image.path);
      });
    }
  }

  Future<void> _createGroup() async {
    if (_nameController.text.trim().isEmpty) {
      CustomSnackbar.showError(context, 'Please enter a group name');
      return;
    }

    if (_selectedMembers.isEmpty) {
      CustomSnackbar.showError(context, 'Please select at least one member');
      return;
    }

    setState(() => _isCreating = true);

    final createChatUseCase = sl<CreateChatUseCase>();
    final memberIds = _selectedMembers.map((m) => m.userId).toList();

    final result = await createChatUseCase(
      participantIds: memberIds,
      type: ChatType.group,
      groupName: _nameController.text.trim(),
    );

    setState(() => _isCreating = false);

    result.fold(
      (failure) {
        CustomSnackbar.showError(context, 'Failed to create group: ${failure.message}');
      },
      (chatId) {
        CustomSnackbar.showSuccess(context, 'Group created successfully');
        context.go('/chat/$chatId');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ContactsBloc>()..add(const ContactsEvent.loadContacts()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Group', style: AppTypography.h3),
          actions: [
            if (_isCreating)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: SmallLoadingIndicator(),
              )
            else
              TextButton(
                onPressed: _createGroup,
                child: Text(
                  'Create',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        body: Column(
          children: [
            // Group Info Section
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.surfaceDark
                  : AppColors.surfaceLight,
              child: Row(
                children: [
                  // Group Image
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                          backgroundImage: _groupImage != null
                              ? FileImage(_groupImage!)
                              : null,
                          child: _groupImage == null
                              ? const Icon(
                                  Icons.group,
                                  size: 35,
                                  color: AppColors.primary,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),

                  // Group Name Input
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Group name',
                        border: InputBorder.none,
                      ),
                      style: AppTypography.h3,
                    ),
                  ),
                ],
              ),
            ),

            // Selected Members Count
            if (_selectedMembers.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                color: AppColors.primary.withValues(alpha: 0.1),
                child: Row(
                  children: [
                    Text(
                      '${_selectedMembers.length} members selected',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            // Contacts List
            Expanded(
              child: BlocBuilder<ContactsBloc, ContactsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const LoadingWidget(),
                    loaded: (contacts) {
                      if (contacts.isEmpty) {
                        return Center(
                          child: Text(
                            'No contacts available',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textSecondaryLight,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          final isSelected = _selectedMembers.contains(contact);

                          return CheckboxListTile(
                            value: isSelected,
                            onChanged: (selected) {
                              setState(() {
                                if (selected == true) {
                                  _selectedMembers.add(contact);
                                } else {
                                  _selectedMembers.remove(contact);
                                }
                              });
                            },
                            secondary: CircleAvatar(
                              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                              backgroundImage: contact.avatarUrl != null
                                  ? NetworkImage(contact.avatarUrl!)
                                  : null,
                              child: contact.avatarUrl == null
                                  ? Text(
                                      contact.displayName[0].toUpperCase(),
                                      style: AppTypography.bodyLarge.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    )
                                  : null,
                            ),
                            title: Text(
                              contact.displayName,
                              style: AppTypography.bodyLarge,
                            ),
                            subtitle: Text(
                              contact.bio ?? contact.phoneNumber,
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                            activeColor: AppColors.primary,
                          );
                        },
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
