import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showName;

  const AppLogo({
    super.key,
    this.size = 120,
    this.showName = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onSurface;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/images/logo.svg',
          width: size,
          height: size,
        ),
        if (showName) ...[
          const SizedBox(height: 12),
          Text(
            'CineBox',
            style: TextStyle(
              color: textColor,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ],
    );
  }
}
