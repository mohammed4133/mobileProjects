import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../main.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const OnboardingScreen({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  void _goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(
          themeMode: themeMode,
          onThemeModeChanged: onThemeModeChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = Theme.of(context).colorScheme.onSurface;

    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      pages: [
        _page(
          context,
          image: 'assets/images/onboarding_discover.svg',
          title: 'onboarding_1_title'.tr(),
          body: 'onboarding_1_body'.tr(),
        ),
        _page(
          context,
          image: 'assets/images/onboarding_stream.svg',
          title: 'onboarding_2_title'.tr(),
          body: 'onboarding_2_body'.tr(),
        ),
        _page(
          context,
          image: 'assets/images/onboarding_watchlist.svg',
          title: 'onboarding_3_title'.tr(),
          body: 'onboarding_3_body'.tr(),
        ),
      ],
      showSkipButton: true,
      skip: Text('skip'.tr(), style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
      next: const Icon(Icons.arrow_forward_rounded, color: kPrimaryColor),
      done: Text('start'.tr(), style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w900)),
      onDone: () => _goToLogin(context),
      onSkip: () => _goToLogin(context),
      dotsDecorator: DotsDecorator(
        activeColor: kPrimaryColor,
        color: isDark ? Colors.white24 : Colors.black12,
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }

  PageViewModel _page(
    BuildContext context, {
    required String image,
    required String title,
    required String body,
  }) {
    final Color textColor = Theme.of(context).colorScheme.onSurface;

    return PageViewModel(
      titleWidget: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: textColor),
      ),
      bodyWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Text(
          body,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: textColor.withOpacity(0.72),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      image: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: SvgPicture.asset(image, height: 260),
      ),
      decoration: const PageDecoration(
        imagePadding: EdgeInsets.zero,
        pageMargin: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
