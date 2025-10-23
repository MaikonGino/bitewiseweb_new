// Conteúdo para: lib/screens/placeholder_voce_screen.dart (CORRIGIDO)

import 'package:flutter/material.dart'; // <--- ESTA LINHA FOI CORRIGIDA

// Tela placeholder (temporária)
class PlaceholderVoceScreen extends StatelessWidget {
  const PlaceholderVoceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Página "Você" (Perfil)',
        style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
      ),
    );
  }
}