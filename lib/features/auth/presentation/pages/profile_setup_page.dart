import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/auth_bloc.dart';

/// Profile setup page for new users
class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();
  File? _avatarImage;
  
  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }
  
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    
    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }
  
  void _completeSetup() {
    if (_formKey.currentState!.validate()) {
      // TODO: Upload avatar image and get URL
      // For now, just update profile with text fields
      context.read<AuthBloc>().add(AuthEvent.updateProfile(
        displayName: _nameController.text,
        username: _usernameController.text.isNotEmpty 
            ? _usernameController.text 
            : null,
        bio: _bioController.text.isNotEmpty 
            ? _bioController.text 
            : null,
      ));
      
      // Navigate to home
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set up your profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (user) {
              context.go('/home');
            },
            error: (message) {
              CustomSnackbar.showError(context, message);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );
          
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSpacing.xl),
                    
                    // Avatar
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                              backgroundImage: _avatarImage != null
                                  ? FileImage(_avatarImage!)
                                  : null,
                              child: _avatarImage == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 60,
                                      color: AppColors.primary,
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
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    
                    // Display Name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Display Name',
                        hintText: 'Enter your name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: Validators.validateDisplayName,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    
                    // Username (Optional)
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username (optional)',
                        hintText: 'Choose a username',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      validator: Validators.validateUsername,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    
                    // Bio (Optional)
                    TextFormField(
                      controller: _bioController,
                      decoration: const InputDecoration(
                        labelText: 'Bio (optional)',
                        hintText: 'Tell us about yourself',
                        prefixIcon: Icon(Icons.info_outline),
                      ),
                      maxLines: 3,
                      maxLength: 140,
                      validator: Validators.validateBio,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    
                    // Complete Button
                    ElevatedButton(
                      onPressed: isLoading ? null : _completeSetup,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      child: isLoading
                          ? const SmallLoadingIndicator(color: Colors.white)
                          : const Text('Complete Setup'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    
                    // Skip Button
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () => context.go('/home'),
                      child: const Text('Skip for now'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
