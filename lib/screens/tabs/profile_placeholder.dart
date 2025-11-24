import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../login_modal.dart';
import '../onboarding_screen.dart';
import '../about_modal.dart';

class ProfilePlaceholder extends StatelessWidget {
  final VoidCallback? onLoginSuccess;
  const ProfilePlaceholder({super.key, this.onLoginSuccess});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LayoutBuilder(builder: (context, constraints) { if (constraints.maxWidth > 600) { return _buildLaptopIcon(cs); } else { return _buildPhoneIcon(cs); } }),
            const SizedBox(height: 32),
            Text("Área Restrita", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: cs.onSurface)),
            const SizedBox(height: 8),
            Text("Faça login para sincronizar suas receitas e acessar recursos exclusivos.", textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14, height: 1.5)),
            const SizedBox(height: 32),
            SizedBox(width: double.infinity, height: 56, child: ElevatedButton.icon(onPressed: () { showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const LoginModal()); }, icon: const Icon(Icons.login_rounded, color: Colors.white), label: Text("ACESSAR MINHA CONTA", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.terracotta, elevation: 4, shadowColor: AppColors.terracotta.withOpacity(0.4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))))),
            const SizedBox(height: 32),

            // --- BOTÕES SECUNDÁRIOS (LADO A LADO) ---
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              runSpacing: 16,
              children: [
                TextButton.icon(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const OnboardingScreen())); }, icon: const Icon(Icons.school_outlined, size: 18), label: Text("Ver Tutorial", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)), style: TextButton.styleFrom(foregroundColor: Colors.grey[700])),
                TextButton.icon(onPressed: () { showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const AboutModal()); }, icon: const Icon(Icons.info_outline, size: 18), label: Text("Sobre Nós", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)), style: TextButton.styleFrom(foregroundColor: Colors.grey[700])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // (Métodos de ícone Laptop/Phone iguais ao anterior)
  Widget _buildPhoneIcon(ColorScheme cs) => SizedBox(width: 120, height: 120, child: Stack(alignment: Alignment.center, children: [Container(width: 70, height: 110, decoration: BoxDecoration(color: cs.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.withOpacity(0.3), width: 3), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 8))])), _buildLockCircle(cs)]));
  Widget _buildLaptopIcon(ColorScheme cs) => SizedBox(width: 160, height: 120, child: Stack(alignment: Alignment.center, children: [Column(mainAxisSize: MainAxisSize.min, children: [Container(width: 120, height: 80, decoration: BoxDecoration(color: cs.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(8)), border: Border.all(color: Colors.grey.withOpacity(0.3), width: 3)), child: Center(child: Container(width: 20, height: 20, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.1))))), Container(width: 140, height: 10, decoration: BoxDecoration(color: Colors.grey.withOpacity(0.4), borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8))))]), Padding(padding: const EdgeInsets.only(bottom: 10), child: _buildLockCircle(cs))]));
  Widget _buildLockCircle(ColorScheme cs) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.terracotta.withOpacity(0.1), shape: BoxShape.circle, border: Border.all(color: cs.surface, width: 2)), child: const Icon(Icons.lock_outline_rounded, size: 32, color: AppColors.terracotta));
}