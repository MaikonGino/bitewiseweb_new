import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../global_state.dart';
import '../plans_screen.dart';
import '../onboarding_screen.dart';
import '../about_modal.dart';

class ProfileTab extends StatefulWidget {
  final VoidCallback onLogout;
  const ProfileTab({super.key, required this.onLogout});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final TextEditingController _nameController = TextEditingController(text: "Usuário BiteWise");
  final TextEditingController _emailController = TextEditingController(text: "usuario@email.com");

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ValueListenableBuilder<PreferencesState>(
        valueListenable: preferencesNotifier,
        builder: (context, prefs, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Stack(alignment: Alignment.bottomRight, children: [Container(width: 120, height: 120, decoration: BoxDecoration(shape: BoxShape.circle, color: cs.primary.withOpacity(0.1), border: Border.all(color: AppColors.terracotta, width: 2), image: const DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=400&auto=format&fit=crop"), fit: BoxFit.cover))), Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: AppColors.terracotta, shape: BoxShape.circle), child: const Icon(Icons.camera_alt, size: 20, color: Colors.white))]),

                ValueListenableBuilder<bool>(valueListenable: planNotifier, builder: (context, isPremium, _) { return Container(margin: const EdgeInsets.symmetric(vertical: 24), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: isPremium ? AppColors.olive.withOpacity(0.1) : AppColors.terracotta.withOpacity(0.1), borderRadius: BorderRadius.circular(16), border: Border.all(color: isPremium ? AppColors.olive : AppColors.terracotta)), child: Row(children: [Icon(isPremium ? Icons.star : Icons.star_border, color: isPremium ? AppColors.olive : AppColors.terracotta, size: 30), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(isPremium ? "Plano Premium Ativo" : "Plano Gratuito", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: cs.onSurface)), Text(isPremium ? "Você tem acesso total." : "Faça o upgrade agora.", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]))])), TextButton(onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const PlansScreen())); }, child: Text("Gerenciar", style: TextStyle(color: isPremium ? AppColors.olive : AppColors.terracotta, fontWeight: FontWeight.bold))) ])); }),

                _buildLabel("Sua Dieta"),
                const SizedBox(height: 8),
                Text("Isso altera as sugestões na Home.", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 12),
                Wrap(spacing: 10, runSpacing: 10, children: [
                  ActionChip(avatar: prefs.dietFilters.isEmpty ? const Icon(Icons.check, size: 16, color: Colors.white) : null, label: const Text("Sem Restrição"), backgroundColor: prefs.dietFilters.isEmpty ? AppColors.terracotta : cs.surface, labelStyle: TextStyle(color: prefs.dietFilters.isEmpty ? Colors.white : cs.onSurface), side: BorderSide(color: prefs.dietFilters.isEmpty ? Colors.transparent : Colors.grey.withOpacity(0.3)), onPressed: () => preferencesNotifier.clearFilters()),
                  _buildFilterChip("Vegano", prefs, cs), _buildFilterChip("Vegetariano", prefs, cs), _buildFilterChip("Sem Glúten", prefs, cs), _buildFilterChip("Low Carb", prefs, cs)
                ]),

                const SizedBox(height: 32),
                _buildLabel("Dados Pessoais"),
                TextField(controller: _nameController, style: GoogleFonts.poppins(color: cs.onSurface), decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline))),
                const SizedBox(height: 20),
                _buildLabel("E-mail"),
                TextField(controller: _emailController, style: GoogleFonts.poppins(color: cs.onSurface), decoration: const InputDecoration(prefixIcon: Icon(Icons.email_outlined))),

                const SizedBox(height: 40),
                SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Perfil atualizado!"))); }, icon: const Icon(Icons.save_outlined, color: Colors.white), label: Text("SALVAR ALTERAÇÕES", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)), style: ElevatedButton.styleFrom(backgroundColor: AppColors.terracotta))),
                const SizedBox(height: 24), const Divider(), const SizedBox(height: 16),

                ListTile(leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.school_outlined, color: AppColors.coffee)), title: Text("Ver Tutorial", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: cs.onSurface)), trailing: const Icon(Icons.chevron_right), onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const OnboardingScreen())); }),
                ListTile(leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.info_outline, color: AppColors.coffee)), title: Text("Sobre o BiteWise", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: cs.onSurface)), trailing: const Icon(Icons.chevron_right), onTap: () { showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const AboutModal()); }),
                ListTile(leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.logout, color: Colors.redAccent)), title: Text("Sair da Conta", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.redAccent)), onTap: widget.onLogout),
                const SizedBox(height: 40),
              ],
            ),
          );
        }
    );
  }

  Widget _buildLabel(String text) {
    return Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.only(bottom: 8, left: 4), child: Text(text, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600))));
  }

  Widget _buildFilterChip(String label, PreferencesState prefs, ColorScheme cs) {
    final isSelected = prefs.dietFilters.contains(label);
    return FilterChip(label: Text(label), selected: isSelected, onSelected: (val) => preferencesNotifier.toggleFilter(label), selectedColor: AppColors.olive.withOpacity(0.2), checkmarkColor: AppColors.olive, backgroundColor: cs.surface, labelStyle: TextStyle(color: isSelected ? AppColors.olive : cs.onSurface, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal), side: BorderSide(color: isSelected ? AppColors.olive : Colors.grey.withOpacity(0.3)), showCheckmark: true);
  }
}