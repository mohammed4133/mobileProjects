import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const SignUpScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _acceptedTerms = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    final bool valid = _nameController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty &&
        _passwordController.text.trim().length >= 4 &&
        _passwordController.text.trim() == _confirmPasswordController.text.trim() &&
        _acceptedTerms;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(valid ? 'otp_sent'.tr() : 'signup_validation'.tr())),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'signup_title'.tr(),
                style: const TextStyle(fontSize: 31, fontWeight: FontWeight.w900),
              ).animate().fadeIn(duration: 450.ms).slideX(begin: -0.1, end: 0),
              const SizedBox(height: 8),
              Text(
                'signup_subtitle'.tr(),
                style: TextStyle(fontSize: 17, height: 1.35, color: colors.onSurface.withOpacity(0.70), fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 30),
              AppTextField(controller: _nameController, hintText: 'full_name'.tr(), icon: Icons.person_rounded),
              const SizedBox(height: 12),
              AppTextField(
                controller: _phoneController,
                hintText: 'phone_number'.tr(),
                icon: Icons.phone_android_rounded,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              AppTextField(controller: _passwordController, hintText: 'password'.tr(), icon: Icons.key_rounded, isPassword: true),
              const SizedBox(height: 12),
              AppTextField(controller: _confirmPasswordController, hintText: 'confirm_password'.tr(), icon: Icons.key_outlined, isPassword: true),
              const SizedBox(height: 12),
              AppTextField(controller: _emailController, hintText: 'email_optional'.tr(), icon: Icons.email_rounded, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _acceptedTerms,
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (value) {
                      setState(() {
                        _acceptedTerms = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: colors.onSurface.withOpacity(0.75), fontWeight: FontWeight.w700),
                        children: [
                          TextSpan(text: '${'agreeing_to'.tr()} '),
                          TextSpan(
                            text: 'terms'.tr(),
                            style: TextStyle(color: colors.primary, decoration: TextDecoration.underline, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              PrimaryButton(text: 'send_otp'.tr(), icon: Icons.sms_rounded, onPressed: _sendOtp),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('already_account'.tr(), style: TextStyle(color: colors.onSurface.withOpacity(0.70))),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('sign_in'.tr(), style: const TextStyle(fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
