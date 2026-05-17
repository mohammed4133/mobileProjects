import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const SettingsScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    // Important fix:
    // We read the real current theme from the app, not from the old passed value.
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.tr(),
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 100),
          children: [
            _SettingsCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      isDark
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isDark ? 'Dark Mode' : 'Light Mode',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'dark_mode_subtitle'.tr(),
                          style: TextStyle(
                            color: colors.onSurface.withOpacity(0.65),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: isDark,
                    activeColor: colors.primary,
                    onChanged: (value) {
                      onThemeModeChanged(
                        value ? ThemeMode.dark : ThemeMode.light,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SettingsCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'language'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'language_subtitle'.tr(),
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.65),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _LanguageButton(
                          text: 'English',
                          selected: context.locale.languageCode == 'en',
                          onPressed: () {
                            context.setLocale(const Locale('en'));
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _LanguageButton(
                          text: 'العربية',
                          selected: context.locale.languageCode == 'ar',
                          onPressed: () {
                            context.setLocale(const Locale('ar'));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SettingsCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'about_app'.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'about_app_body'.tr(),
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.70),
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.05, end: 0),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;

  const _SettingsCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest
          .withOpacity(0.55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: child,
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onPressed;

  const _LanguageButton({
    required this.text,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: selected ? colors.primary : Colors.transparent,
        foregroundColor: selected ? Colors.white : colors.onSurface,
        minimumSize: const Size(double.infinity, 48),
        side: BorderSide(
          color: selected ? colors.primary : colors.outline.withOpacity(0.45),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w900),
      ),
    );
  }
}
