import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/auth_bloc.dart';

/// Phone input page for authentication
class PhoneInputPage extends StatefulWidget {
  const PhoneInputPage({super.key});

  @override
  State<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  String _countryCode = '+998';
  
  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
  
  void _sendOTP() {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = '$_countryCode${_phoneController.text}';
      context.read<AuthBloc>().add(AuthEvent.sendOTP(phoneNumber));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            otpSent: (verificationId, phoneNumber) {
              context.push('/otp-verification', extra: {
                'verificationId': verificationId,
                'phoneNumber': phoneNumber,
              });
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
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    
                    // Logo or App Name
                    const Icon(
                      Icons.chat_bubble,
                      size: 80,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    
                    // Title
                    const Text(
                      'Welcome to Fury Chat',
                      style: AppTypography.h2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    
                    // Subtitle
                    Text(
                      'Enter your phone number to get started',
                      style: AppTypography.bodyMedium.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    
                    // Phone Number Input
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Country Code Selector
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.surfaceDark
                                : AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          ),
                          child: DropdownButtonFormField<String>(
                            initialValue: _countryCode,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                                vertical: AppSpacing.lg,
                              ),
                              border: InputBorder.none,
                            ),
                            items: const [
                              DropdownMenuItem(value: '+998', child: Text('+998')),
                              DropdownMenuItem(value: '+996', child: Text('+996')),
                              DropdownMenuItem(value: '+7', child: Text('+7')),
                              DropdownMenuItem(value: '+1', child: Text('+1')),
                              DropdownMenuItem(value: '+44', child: Text('+44')),
                              DropdownMenuItem(value: '+91', child: Text('+91')),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _countryCode = value);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        
                        // Phone Number Field
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(15),
                            ],
                            decoration: InputDecoration(
                              hintText: 'Phone number',
                              prefixIcon: const Icon(Icons.phone),
                              filled: true,
                              fillColor: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.surfaceDark
                                  : AppColors.surfaceLight,
                            ),
                            validator: Validators.validatePhoneNumber,
                            enabled: !isLoading,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    
                    // Continue Button
                    ElevatedButton(
                      onPressed: isLoading ? null : _sendOTP,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      child: isLoading
                          ? const SmallLoadingIndicator(color: Colors.white)
                          : const Text('Continue'),
                    ),
                    
                    const Spacer(flex: 2),
                    
                    // Terms and Privacy
                    Text(
                      'By continuing, you agree to our Terms of Service and Privacy Policy',
                      style: AppTypography.caption.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                      textAlign: TextAlign.center,
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
