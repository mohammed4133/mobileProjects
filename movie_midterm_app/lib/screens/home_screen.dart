import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/movie_data.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_poster.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openDetails(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsScreen(movie: movie),
      ),
    );
  }

  void _openAllMovies(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AllMoviesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final List<Movie> topRatedMovies = [...movies]
      ..sort((a, b) => b.rating.compareTo(a.rating));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'app_name'.tr(),
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            onPressed: () => _openAllMovies(context),
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 95),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFE50914),
                      Color(0xFF6D0F16),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE50914).withOpacity(0.22),
                      blurRadius: 24,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'home_hero_title'.tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'home_hero_body'.tr(),
                            style: const TextStyle(
                              color: Colors.white70,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.local_movies_rounded,
                      color: Colors.white,
                      size: 62,
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.08, end: 0),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'popular_movies'.tr(),
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _openAllMovies(context),
                    child: Text(
                      'see_all'.tr(),
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 360,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final Movie movie = movies[index];

                    return SizedBox(
                      width: 190,
                      child: MovieCard(
                        movie: movie,
                        onTap: () => _openDetails(context, movie),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Top Rated',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 14),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: topRatedMovies.take(4).length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final Movie movie = topRatedMovies[index];

                  return _TopRatedMovieTile(
                    movie: movie,
                    onTap: () => _openDetails(context, movie),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AllMoviesScreen extends StatelessWidget {
  const AllMoviesScreen({super.key});

  void _openDetails(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsScreen(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'popular_movies'.tr(),
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
        itemCount: movies.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final Movie movie = movies[index];

          return _VerticalMovieTile(
            movie: movie,
            onTap: () => _openDetails(context, movie),
          );
        },
      ),
      backgroundColor: colors.surface,
    );
  }
}

class _VerticalMovieTile extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const _VerticalMovieTile({
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest.withOpacity(0.55),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            MoviePoster(
              assetPath: movie.posterAsset,
              posterUrl: movie.posterUrl,
              width: 95,
              height: double.infinity,
              borderRadius: BorderRadius.circular(16),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.titleKey.tr(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    movie.genreKey.tr(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.65),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.descriptionKey.tr(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.60),
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFC107),
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.rating.toStringAsFixed(1),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(width: 14),
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 17,
                        color: colors.onSurface.withOpacity(0.55),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.year,
                        style: TextStyle(
                          color: colors.onSurface.withOpacity(0.65),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopRatedMovieTile extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const _TopRatedMovieTile({
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest.withOpacity(0.45),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: MoviePoster(
                assetPath: movie.posterAsset,
                posterUrl: movie.posterUrl,
                width: 75,
                height: 82,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.titleKey.tr(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.genreKey.tr(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.onSurface.withOpacity(0.65),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFC107),
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movie.rating.toStringAsFixed(1),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        movie.year,
                        style: TextStyle(
                          color: colors.onSurface.withOpacity(0.65),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: colors.onSurface.withOpacity(0.45),
            ),
          ],
        ),
      ),
    );
  }
}
