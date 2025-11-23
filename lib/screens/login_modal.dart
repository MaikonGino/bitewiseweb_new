import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart'; // Acesso ao AuthNotifier
import '../../theme.dart';

class LoginModal extends StatelessWidget {
  const LoginModal({super.key});

  void _performLogin(BuildContext context) {
    // ATIVA O LOGIN GLOBALMENTE
    authNotifier.login();
    Navigator.pop(context); // Fecha o modal

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login realizado com sucesso!", style: GoogleFonts.poppins()),
          backgroundColor: AppColors.terracotta,
          behavior: SnackBarBehavior.floating,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: SizedBox(width: 40, height: 4, child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)))),
          const SizedBox(height: 32),
          Icon(Icons.lock_person_outlined, size: 64, color: AppColors.terracotta),
          const SizedBox(height: 16),
          Text("Acesso Exclusivo", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: cs.onSurface)),
          const SizedBox(height: 8),
          Text("Salve suas receitas e acesse seu histórico de qualquer lugar.", textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.grey)),
          const Spacer(),

          OutlinedButton.icon(
            onPressed: () => _performLogin(context),
            icon: const Icon(Icons.g_mobiledata),
            label: const Text("Continuar com Google"),
            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), side: BorderSide(color: Colors.grey.withOpacity(0.5))),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _performLogin(context),
            child: const Text("Entrar com E-mail"),
          ),
        ],
      ),
    );
  }
}