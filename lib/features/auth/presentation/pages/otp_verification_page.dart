import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/auth_bloc.dart';

/// OTP verification page
class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String? verificationId;
  
  const OTPVerificationPage({
    super.key,
    required this.phoneNumber,
    this.verificationId,
  });

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  
  int _resendTimer = 60;
  Timer? _timer;
  String? _currentVerificationId;
  
  @override
  void initState() {
    super.initState();
    _currentVerificationId = widget.verificationId;
    _startTimer();
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
  
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() => _resendTimer--);
      } else {
        timer.cancel();
      }
    });
  }
  
  void _verifyOTP() {
    if (_formKey.currentState!.validate()) {
      final code = _controllers.map((c) => c.text).join();
      
      if (_currentVerificationId == null) {
        CustomSnackbar.showError(context, 'Verification ID not found');
        return;
      }
      
      context.read<AuthBloc>().add(AuthEvent.verifyOTP(
        phoneNumber: widget.phoneNumber,
        verificationId: _currentVerificationId!,
        code: code,
      ));
    }
  }
  
  void _resendOTP() {
    if (_resendTimer > 0) return;
    
    context.read<AuthBloc>().add(AuthEvent.sendOTP(widget.phoneNumber));
    setState(() => _resendTimer = 60);
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            otpSent: (verificationId, phoneNumber) {
              setState(() => _currentVerificationId = verificationId);
              CustomSnackbar.showSuccess(context, 'OTP sent successfully');
            },
            profileIncomplete: (user) {
              context.go('/profile-setup');
            },
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
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    
                    // Title
                    const Text(
                      'Verify Phone Number',
                      style: AppTypography.h2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    
                    // Subtitle
                    Text(
                      'Enter the 6-digit code sent to\n${widget.phoneNumber}',
                      style: AppTypography.bodyMedium.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    
                    // OTP Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 50,
                          child: TextFormField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: AppTypography.h2,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.surfaceDark
                                  : AppColors.surfaceLight,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                _focusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                              
                              // Auto-submit when all fields are filled
                              if (index == 5 && value.isNotEmpty) {
                                _verifyOTP();
                              }
                            },
                            enabled: !isLoading,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    
                    // Verify Button
                    ElevatedButton(
                      onPressed: isLoading ? null : _verifyOTP,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      child: isLoading
                          ? const SmallLoadingIndicator(color: Colors.white)
                          : const Text('Verify'),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    
                    // Resend OTP
                    TextButton(
                      onPressed: _resendTimer > 0 ? null : _resendOTP,
                      child: Text(
                        _resendTimer > 0
                            ? 'Resend code in ${_resendTimer}s'
                            : 'Resend code',
                      ),
                    ),
                    
                    const Spacer(flex: 2),
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
