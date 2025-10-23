// Conteúdo para: lib/main.dart (SUBSTITUA TODO O CONTEÚDO)

import 'package:flutter/material.dart';
import 'package:bitewise_app/screens/start_screen.dart';
import 'package:bitewise_app/theme/app_colors.dart';

// Notificador global para controlar o tema
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const BiteWiseApp());
}

class BiteWiseApp extends StatelessWidget {
  const BiteWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuta o notificador de tema
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, currentMode, __) {
        return MaterialApp(
          title: 'BiteWise',
          debugShowCheckedModeBanner: false,

          // Tema Claro (Baseado no Guia de Cores)
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: AppColors.laranjaPaprika,
            scaffoldBackgroundColor: AppColors.backgroundLight,
            fontFamily: 'Poppins',
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.backgroundLight,
              foregroundColor: AppColors.textLight,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColors.laranjaPaprika),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: AppColors.verdeMarProfundo,
              unselectedItemColor: AppColors.cinzaNuvem,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.laranjaPaprika,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                textStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Tema Escuro (Baseado no Guia de Cores)
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: AppColors.laranjaPaprika,
            scaffoldBackgroundColor: AppColors.backgroundDark,
            fontFamily: 'Poppins',
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.backgroundDark,
              foregroundColor: AppColors.textDark,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColors.laranjaMel),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: AppColors.verdeErvaDoce,
              unselectedItemColor: AppColors.cinzaNuvem,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.laranjaPaprika,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                textStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Define o modo de tema (inicia como .light)
          themeMode: currentMode,

          // Começa na tela de início
          home: const StartScreen(),
        );
      },
    );
  }
}