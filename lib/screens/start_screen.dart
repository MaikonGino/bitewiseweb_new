// Conteúdo para: lib/screens/start_screen.dart (CORRIGIDO)

import 'package:flutter/material.dart';
import 'package:bitewise_app/screens/login_screen.dart';
// CAMINHO CORRIGIDO de acordo com sua estrutura de arquivos:
import 'package:bitewise_app/theme/app_colors.dart';
import 'package:bitewise_app/theme/widgets/responsive_center.dart'; // Importa o delimitador

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // Fundo com gradiente sutil e profissional
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [AppColors.backgroundDark, Color(0xFF1a1a1a)]
                : [AppColors.backgroundLight, Color(0xFFf0f0f0)],
          ),
        ),
        // Aplica o "delimitador" aqui
        child: ResponsiveCenter(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // (Assume que 'bitewise_logo.png' está em 'assets/images/')
                  Image.asset(
                    'assets/images/bitewise_logo.png',
                    height: 150,
                    // Mostra um ícone de fallback se a imagem não for encontrada
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150,
                        child: Icon(Icons.food_bank_outlined, size: 100, color: AppColors.laranjaPaprika),
                      );
                    },
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Começar'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Já tem conta? Fazer login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // Cor do texto que se adapta ao tema (claro/escuro)
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}