// Conteúdo para: lib/screens/recipe_screen.dart

import 'package:flutter/material.dart';
import 'package:bitewise_app/theme/app_colors.dart';

// [MOCK] Tela placeholder para onde o usuário vai ao gerar uma receita
class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sua Receita', style: TextStyle(fontFamily: 'Poppins')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long_outlined, size: 100, color: AppColors.verdeMarProfundo),
              SizedBox(height: 20),
              Text(
                'Pão de Queijo Caseiro', //
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Aqui seria exibida a receita gerada pela IA, conforme a Imagem 24.',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}