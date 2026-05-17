# CineBox - Flutter Midterm Movie App

CineBox is a multi-page Flutter app built for the Midterm Project requirements.
It now uses real movie titles with hardcoded local data, as required by the course instructions.

## Screens included

- Splash screen
- 3 onboarding pages
- Login page with basic validation
- Sign-up page with basic validation and terms checkbox
- Home page with real movie cards and local poster-style SVG images
- Settings page with Light / Dark mode and English / Arabic switching
- Bonus movie details page when a movie card is tapped

## Packages used

- easy_localization
- flutter_svg
- flutter_animate
- introduction_screen
- curved_navigation_bar
- flutter_launcher_icons

## How to run

```bash
flutter pub get
flutter run
```

## Notes

No backend or API is used. The movie data is hardcoded inside `lib/data/movie_data.dart`.
Poster images are local SVG assets created for this student project.
