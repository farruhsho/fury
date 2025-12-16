import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();
  File? _newAvatar;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    authState.maybeWhen(
      authenticated: (user) {
        _nameController.text = user.displayName ?? '';
        _usernameController.text = user.username ?? '';
        _bioController.text = user.bio ?? '';
      },
      orElse: () {},
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _newAvatar = File(image.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_nameController.text.trim().isEmpty) {
      CustomSnackbar.showError(context, 'Please enter your name');
      return;
    }

    setState(() => _isSaving = true);

    // TODO: Implement profile update with AuthBloc
    // For now, just show success message
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isSaving = false);

    if (mounted) {
      CustomSnackbar.showSuccess(context, 'Profile updated successfully');
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile', style: AppTypography.h3),
        actions: [
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _saveProfile,
              child: Text(
                'Save',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.maybeWhen(
            authenticated: (user) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    // Avatar
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                            backgroundImage: _newAvatar != null
                                ? FileImage(_newAvatar!)
                                : (user.avatarUrl != null
                                    ? NetworkImage(user.avatarUrl!)
                                    : null) as ImageProvider?,
                            child: _newAvatar == null && user.avatarUrl == null
                                ? Text(
                                    (user.displayName ?? 'U')[0].toUpperCase(),
                                    style: AppTypography.h1.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // Name Field
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Username Field
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Bio Field
                    TextField(
                      controller: _bioController,
                      decoration: const InputDecoration(
                        labelText: 'Bio',
                        hintText: 'Add a bio',
                        prefixIcon: Icon(Icons.info_outline),
                      ),
                      maxLines: 3,
                      maxLength: 150,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Phone (Read-only)
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        hintText: user.phoneNumber,
                        prefixIcon: const Icon(Icons.phone),
                      ),
                    ),
                  ],
                ),
              );
            },
            orElse: () => const Center(
              child: Text('Not authenticated'),
            ),
          );
        },
      ),
    );
  }
}
