// Conteúdo para: lib/screens/placeholder_receita_screen.dart

import 'package:flutter/material.dart';

// Tela placeholder (temporária)
class PlaceholderReceitaScreen extends StatelessWidget {
  const PlaceholderReceitaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Página de Receitas',
        style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
      ),
    );
  }
}