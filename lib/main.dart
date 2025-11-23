import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/onboarding_screen.dart'; // Começa pelo tutorial

void main() {
  runApp(const BiteWiseApp());
}

// --- GERENCIADORES GLOBAIS ---
class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light);
  void toggleTheme() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
final themeNotifier = ThemeNotifier();

class AuthNotifier extends ValueNotifier<bool> {
  AuthNotifier() : super(false);

  void login() => value = true;
  void logout() => value = false;
}
final authNotifier = AuthNotifier();

class BiteWiseApp extends StatelessWidget {
  const BiteWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: authNotifier,
          builder: (context, isLoggedIn, child) {
            return MaterialApp(
              title: 'BiteWise',
              debugShowCheckedModeBanner: false,
              theme: buildLightTheme(),
              darkTheme: buildDarkTheme(),
              themeMode: currentMode,
              // AGORA COMEÇA PELO ONBOARDING
              home: const OnboardingScreen(),
            );
          },
        );
      },
    );
  }
}