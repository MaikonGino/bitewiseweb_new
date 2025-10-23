// Conteúdo para: lib/screens/login_screen.dart (VERSÃO PROFISSIONAL)

import 'package:flutter/material.dart';
import 'package:bitewise_app/screens/home_screen.dart';
import 'package:bitewise_app/theme/app_colors.dart';
import 'package:bitewise_app/theme/widgets/responsive_center.dart'; // Importa o delimitador

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login/Cadastro', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: Colors.transparent,
      ),
      // Aplica o "delimitador" aqui
      body: ResponsiveCenter(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          // O Card cria a "delimitação" profissional
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Faça seu cadastro no BiteWise',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),
                  TextField(decoration: InputDecoration(labelText: 'Nome Completo', border: OutlineInputBorder())),
                  SizedBox(height: 16),
                  TextField(decoration: InputDecoration(labelText: 'E-mail', border: OutlineInputBorder())),
                  SizedBox(height: 16),
                  TextField(decoration: InputDecoration(labelText: 'Senha', border: OutlineInputBorder()), obscureText: true),
                  SizedBox(height: 16),
                  TextField(decoration: InputDecoration(labelText: 'Repetir senha', border: OutlineInputBorder()), obscureText: true),
                  SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.verdeErvaDoce,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                            (route) => false,
                      );
                    },
                    child: Text('Cadastrar'),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'OU fazer login com cadastro',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 16),
                  TextField(decoration: InputDecoration(labelText: 'E-mail', border: OutlineInputBorder())),
                  SizedBox(height: 16),
                  TextField(decoration: InputDecoration(labelText: 'Senha', border: OutlineInputBorder()), obscureText: true),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                            (route) => false,
                      );
                    },
                    child: Text('Começar'),
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