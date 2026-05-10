import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Sora',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Arial',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111318),
        fontFamily: 'Arial',
      ),
      home: LoginPage(onToggleTheme: _toggleTheme),
    );
  }
}

const Color primaryRed = Color(0xFFEF3B3A);
const Color darkText = Color(0xFF242938);
const Color softGrey = Color(0xFFF0F0F3);
const Color greenStroke = Color(0xFF3DDC84);

class LoginPage extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const LoginPage({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 330),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const PhoneStatusRow(),
                  const SizedBox(height: 14),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: ControlBar(
                      onToggleLanguage: () => _switchLanguage(context),
                      onToggleTheme: onToggleTheme,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const BrandLogo(),
                  const SizedBox(height: 52),
                  AppTextField(hint: 'phone_number'.tr()),
                  const SizedBox(height: 10),
                  AppTextField(hint: 'password'.tr(), obscureText: true),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: LinkButton(
                      text: 'forgot_password'.tr(),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: 'login'.tr(),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'or'.tr(),
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white60
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GoogleButton(onPressed: () {}),
                  const SizedBox(height: 22),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '${'dont_have_account'.tr()} ',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      LinkButton(
                        text: 'sign_up'.tr(),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  SignUpPage(onToggleTheme: onToggleTheme),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const SignUpPage({super.key, required this.onToggleTheme});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool agreed = true;
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final Color titleColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : darkText;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 330),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PhoneStatusRow(),
                  const SizedBox(height: 14),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: ControlBar(
                      onToggleLanguage: () => _switchLanguage(context),
                      onToggleTheme: widget.onToggleTheme,
                    ),
                  ),
                  const SizedBox(height: 22),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: primaryRed),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                LoginPage(onToggleTheme: widget.onToggleTheme),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'signup_title'.tr(),
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 27,
                      height: 1.05,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'signup_subtitle'.tr(),
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 17,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 34),
                  AppTextField(
                      hint: 'full_name'.tr(), prefixIcon: Icons.person_outline),
                  const SizedBox(height: 10),
                  AppTextField(
                      hint: 'phone_number'.tr(),
                      prefixIcon: Icons.phone_iphone),
                  const SizedBox(height: 10),
                  AppTextField(
                    hint: 'password'.tr(),
                    prefixIcon: Icons.vpn_key_outlined,
                    obscureText: hidePassword,
                    suffixIcon: hidePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onSuffixTap: () =>
                        setState(() => hidePassword = !hidePassword),
                  ),
                  const SizedBox(height: 10),
                  AppTextField(
                    hint: 'confirm_password'.tr(),
                    prefixIcon: Icons.vpn_key_outlined,
                    obscureText: hideConfirmPassword,
                    suffixIcon: hideConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onSuffixTap: () => setState(
                        () => hideConfirmPassword = !hideConfirmPassword),
                  ),
                  const SizedBox(height: 10),
                  AppTextField(
                      hint: 'email_optional'.tr(),
                      prefixIcon: Icons.mail_outline),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: agreed,
                          onChanged: (value) =>
                              setState(() => agreed = value ?? false),
                          activeColor: primaryRed,
                          side: const BorderSide(color: primaryRed, width: 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${'agreeing_to'.tr()} ',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      Flexible(
                        child: LinkButton(
                          text: 'terms'.tr(),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    text: 'send_otp'.tr(),
                    onPressed: agreed ? () {} : null,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '${'already_account'.tr()} ',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        LinkButton(
                          text: 'sign_in'.tr(),
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  final String hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final VoidCallback? onSuffixTap;

  const AppTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 45,
      child: TextField(
        obscureText: obscureText,
        style: TextStyle(
          color: isDark ? Colors.white : darkText,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: isDark ? Colors.white38 : const Color(0xFFA8ABB3),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: isDark ? Colors.white.withOpacity(0.08) : softGrey,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          prefixIcon: prefixIcon == null
              ? null
              : Icon(prefixIcon,
                  color: isDark ? Colors.white38 : const Color(0xFFA8ABB3)),
          suffixIcon: suffixIcon == null
              ? null
              : GestureDetector(
                  onTap: onSuffixTap,
                  child: Icon(suffixIcon,
                      color: isDark ? Colors.white38 : const Color(0xFFA8ABB3)),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: primaryRed, width: 1.2),
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primaryRed,
          disabledBackgroundColor: primaryRed.withOpacity(0.45),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      height: 47,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: primaryRed, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: isDark ? Colors.white : darkText,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'G',
              style: TextStyle(
                color: primaryRed,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 2),
            Text(
              'continue_google'.tr().replaceFirst('Continue', 'Continue'),
              style: TextStyle(
                color: isDark ? Colors.white : darkText,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinkButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const LinkButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: primaryRed,
          fontSize: 13,
          fontWeight: FontWeight.w800,
          decoration: TextDecoration.underline,
          decorationColor: primaryRed,
        ),
      ),
    );
  }
}

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 230,
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: greenStroke, width: 4),
        borderRadius: BorderRadius.circular(80),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'mobile'.tr(),
            style: TextStyle(
              color: isDark ? Colors.white : darkText,
              fontSize: 35,
              height: 0.9,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, color: primaryRed),
              const SizedBox(width: 8),
              Text(
                'sora'.tr(),
                style: TextStyle(
                  color: isDark ? Colors.white : darkText,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ControlBar extends StatelessWidget {
  final VoidCallback onToggleLanguage;
  final VoidCallback onToggleTheme;

  const ControlBar({
    super.key,
    required this.onToggleLanguage,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final String languageLabel =
        context.locale.languageCode == 'en' ? 'EN | AR' : 'AR | EN';

    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onToggleLanguage,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.10)
                    : const Color(0xFFF4F4F6),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isDark ? Colors.white24 : const Color(0xFFE2E3E8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.language_rounded,
                    size: 15,
                    color: isDark ? Colors.white : darkText,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    languageLabel,
                    style: TextStyle(
                      color: isDark ? Colors.white : darkText,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: onToggleTheme,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.10)
                    : const Color(0xFFF4F4F6),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? Colors.white24 : const Color(0xFFE2E3E8),
                ),
              ),
              child: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                size: 16,
                color: isDark ? Colors.white : darkText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneStatusRow extends StatelessWidget {
  const PhoneStatusRow({super.key});

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: TextStyle(
                color: iconColor, fontSize: 14, fontWeight: FontWeight.w800),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_4_bar, color: iconColor, size: 15),
              const SizedBox(width: 4),
              Icon(Icons.wifi, color: iconColor, size: 15),
              const SizedBox(width: 4),
              Icon(Icons.battery_full, color: iconColor, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}

void _switchLanguage(BuildContext context) {
  final String currentLanguage = context.locale.languageCode;
  context.setLocale(Locale(currentLanguage == 'en' ? 'ar' : 'en'));
}
