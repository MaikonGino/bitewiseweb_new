import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../main.dart'; // Acesso ao AuthNotifier
import '../login_modal.dart';

class ProfilePlaceholder extends StatelessWidget {
  final VoidCallback? onLoginSuccess; // Opcional

  const ProfilePlaceholder({super.key, this.onLoginSuccess});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie (Cadeado)
            Lottie.network(
              'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/B.json',
              height: 150,
              errorBuilder: (c,e,s) => Icon(Icons.lock_outline, size: 80, color: AppColors.terracotta),
            ),
            const SizedBox(height: 24),

            Text(
              "Você não está logado",
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Faça login para ver suas receitas salvas e acessar seu perfil completo.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 32),

            // --- BOTÃO DE LOGIN BONITO ---
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const LoginModal(),
                  );
                },
                icon: const Icon(Icons.login_rounded, color: Colors.white),
                label: Text(
                    "FAZER LOGIN",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.terracotta,
                  elevation: 4,
                  shadowColor: AppColors.terracotta.withOpacity(0.4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}