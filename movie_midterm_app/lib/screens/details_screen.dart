import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/movie.dart';
import '../widgets/movie_poster.dart';
import '../widgets/primary_button.dart';

class DetailsScreen extends StatelessWidget {
  final Movie movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('details'.tr(), style: const TextStyle(fontWeight: FontWeight.w900)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 14, 22, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MoviePoster(assetPath: movie.posterAsset, posterUrl: movie.posterUrl, height: 390),
            const SizedBox(height: 22),
            Text(
              movie.titleKey.tr(),
              style: const TextStyle(fontSize: 31, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _InfoChip(icon: Icons.calendar_month_rounded, text: movie.year),
                const SizedBox(width: 8),
                _InfoChip(icon: Icons.access_time_rounded, text: movie.duration),
                const SizedBox(width: 8),
                _InfoChip(icon: Icons.star_rounded, text: movie.rating.toStringAsFixed(1)),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              movie.genreKey.tr(),
              style: TextStyle(color: colors.primary, fontSize: 16, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 14),
            Text(
              'storyline'.tr(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              movie.descriptionKey.tr(),
              style: TextStyle(height: 1.6, fontSize: 16, color: colors.onSurface.withOpacity(0.72), fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              text: 'add_watchlist'.tr(),
              icon: Icons.bookmark_add_rounded,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('added_watchlist'.tr())),
                );
              },
            ),
          ],
        ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.06, end: 0),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withOpacity(0.65),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17, color: colors.primary),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
