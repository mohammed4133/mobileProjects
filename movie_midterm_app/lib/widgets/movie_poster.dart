import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoviePoster extends StatelessWidget {
  final String assetPath;
  final String posterUrl;
  final double height;
  final double? width;
  final BorderRadius borderRadius;

  const MoviePoster({
    super.key,
    required this.assetPath,
    required this.posterUrl,
    this.height = 180,
    this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(22)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        height: height,
        width: width,
        child: posterUrl.trim().isNotEmpty
            ? Image.network(
                posterUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _LoadingPoster(assetPath: assetPath);
                },
                errorBuilder: (context, error, stackTrace) {
                  return _LoadingPoster(assetPath: assetPath);
                },
              )
            : _LoadingPoster(assetPath: assetPath),
      ),
    );
  }
}

class _LoadingPoster extends StatelessWidget {
  final String assetPath;

  const _LoadingPoster({required this.assetPath});

  @override
  Widget build(BuildContext context) {
    if (assetPath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        assetPath,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
    );
  }
}
