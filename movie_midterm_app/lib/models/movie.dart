class Movie {
  final String titleKey;
  final String genreKey;
  final String descriptionKey;
  final String posterAsset;
  final String posterUrl;
  final String year;
  final String duration;
  final double rating;

  const Movie({
    required this.titleKey,
    required this.genreKey,
    required this.descriptionKey,
    required this.posterAsset,
    required this.posterUrl,
    required this.year,
    required this.duration,
    required this.rating,
  });
}
