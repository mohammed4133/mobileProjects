import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

class MainShell extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const MainShell({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeScreen(),
          SettingsScreen(
            themeMode: widget.themeMode,
            onThemeModeChanged: widget.onThemeModeChanged,
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 62,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        color: kPrimaryColor,
        buttonBackgroundColor: colors.primary,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home_rounded, color: Colors.white, size: 28),
          Icon(Icons.settings_rounded, color: Colors.white, size: 28),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
