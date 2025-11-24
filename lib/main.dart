import 'package:flutter/material.dart';
import 'theme.dart';
import 'global_state.dart'; // Importa o arquivo novo
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const BiteWiseApp());
}

class BiteWiseApp extends StatelessWidget {
  const BiteWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'BiteWise',
          debugShowCheckedModeBanner: false,
          theme: buildLightTheme(),
          darkTheme: buildDarkTheme(),
          themeMode: currentMode,
          home: const OnboardingScreen(),
        );
      },
    );
  }
}