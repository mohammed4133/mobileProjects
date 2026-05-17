import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/app_logo.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';
import 'main_shell.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const LoginScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final String phone = _phoneController.text.trim();
    final String password = _passwordController.text.trim();

    if (phone.isEmpty || password.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('login_validation'.tr())),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MainShell(
          themeMode: widget.themeMode,
          onThemeModeChanged: widget.onThemeModeChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 28),
              const AppLogo(size: 95).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1, end: 0),
              const SizedBox(height: 32),
              Text(
                'welcome_back'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                'login_subtitle'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.onSurface.withOpacity(0.65), fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 34),
              AppTextField(
                controller: _phoneController,
                hintText: 'phone_number'.tr(),
                icon: Icons.phone_android_rounded,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 14),
              AppTextField(
                controller: _passwordController,
                hintText: 'password'.tr(),
                icon: Icons.lock_rounded,
                isPassword: true,
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'forgot_password'.tr(),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              PrimaryButton(text: 'login'.tr(), icon: Icons.login_rounded, onPressed: _login),
              const SizedBox(height: 18),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.movie_creation_outlined),
                label: Text('continue_guest'.tr()),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  side: BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('no_account'.tr(), style: TextStyle(color: colors.onSurface.withOpacity(0.70))),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignUpScreen(
                            themeMode: widget.themeMode,
                            onThemeModeChanged: widget.onThemeModeChanged,
                          ),
                        ),
                      );
                    },
                    child: Text('sign_up'.tr(), style: const TextStyle(fontWeight: FontWeight.w900)),
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
