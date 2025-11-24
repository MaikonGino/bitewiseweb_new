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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- CABEÇALHO PERFIL ---
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 120, height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cs.primary.withOpacity(0.1),
                          border: Border.all(color: AppColors.terracotta, width: 2),
                          image: const DecorationImage(
                            image: NetworkImage("https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=400&auto=format&fit=crop"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: AppColors.terracotta, shape: BoxShape.circle),
                        child: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                // --- PLANO ATIVO ---
                ValueListenableBuilder<bool>(
                    valueListenable: planNotifier,
                    builder: (context, isPremium, _) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isPremium ? AppColors.olive.withOpacity(0.1) : AppColors.terracotta.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: isPremium ? AppColors.olive : AppColors.terracotta),
                        ),
                        child: Row(
                          children: [
                            Icon(isPremium ? Icons.star : Icons.star_border, color: isPremium ? AppColors.olive : AppColors.terracotta, size: 30),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(isPremium ? "Plano Premium Ativo" : "Plano Gratuito", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: cs.onSurface)),
                                  Text(isPremium ? "Acesso ilimitado." : "Faça o upgrade agora.", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PlansScreen())),
                              child: Text("Gerenciar", style: TextStyle(color: isPremium ? AppColors.olive : AppColors.terracotta, fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      );
                    }
                ),

                // --- PREFERÊNCIAS ALIMENTARES (EXPANDIDA) ---
                Text("Sua Dieta e Restrições", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: cs.onSurface)),
                const SizedBox(height: 8),
                Text("Selecione tudo que se aplica. Isso personaliza suas sugestões.", style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 16),

                Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: [
                    // Botão Mestre
                    ActionChip(
                      avatar: prefs.dietFilters.isEmpty ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                      label: const Text("Sem Restrição"),
                      backgroundColor: prefs.dietFilters.isEmpty ? AppColors.terracotta : cs.surface,
                      labelStyle: TextStyle(color: prefs.dietFilters.isEmpty ? Colors.white : cs.onSurface, fontWeight: FontWeight.bold),
                      side: BorderSide(color: prefs.dietFilters.isEmpty ? Colors.transparent : Colors.grey.withOpacity(0.3)),
                      onPressed: () => preferencesNotifier.clearFilters(),
                    ),
                    // Opções Completas
                    _buildFilterChip("Vegano", prefs, cs),
                    _buildFilterChip("Vegetariano", prefs, cs),
                    _buildFilterChip("Sem Glúten", prefs, cs),
                    _buildFilterChip("Sem Lactose", prefs, cs),
                    _buildFilterChip("Low Carb", prefs, cs),
                    _buildFilterChip("Keto", prefs, cs),
                    _buildFilterChip("Paleo", prefs, cs),
                    _buildFilterChip("Sem Açúcar", prefs, cs),
                    _buildFilterChip("Sem Nozes", prefs, cs),
                  ],
                ),

                const SizedBox(height: 40),

                // --- DADOS PESSOAIS ---
                Text("Dados Pessoais", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: cs.onSurface)),
                const SizedBox(height: 16),
                TextField(controller: _nameController, style: GoogleFonts.poppins(color: cs.onSurface), decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline), labelText: "Nome Completo")),
                const SizedBox(height: 16),
                TextField(controller: _emailController, style: GoogleFonts.poppins(color: cs.onSurface), decoration: const InputDecoration(prefixIcon: Icon(Icons.email_outlined), labelText: "E-mail")),

                const SizedBox(height: 40),

                // --- AÇÕES ---
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Perfil atualizado!")));
                    },
                    icon: const Icon(Icons.save_outlined, color: Colors.white),
                    label: Text("SALVAR ALTERAÇÕES", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.terracotta),
                  ),
                ),

                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 16),

                // Links Úteis
                _buildMenuLink("Ver Tutorial", Icons.school_outlined, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OnboardingScreen())), cs),
                _buildMenuLink("Sobre o BiteWise", Icons.info_outline, () => showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const AboutModal()), cs),
                _buildMenuLink("Sair da Conta", Icons.logout, widget.onLogout, cs, isDestructive: true),

                const SizedBox(height: 40),
              ],
            ),
          );
        }
    );
  }

  Widget _buildFilterChip(String label, PreferencesState prefs, ColorScheme cs) {
    final isSelected = prefs.dietFilters.contains(label);
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) => preferencesNotifier.toggleFilter(label),
      selectedColor: AppColors.olive.withOpacity(0.15),
      checkmarkColor: AppColors.olive,
      backgroundColor: cs.surface,
      labelStyle: TextStyle(
          color: isSelected ? AppColors.olive : cs.onSurface,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
      ),
      side: BorderSide(color: isSelected ? AppColors.olive : Colors.grey.withOpacity(0.3)),
      showCheckmark: true,
    );
  }

  Widget _buildMenuLink(String title, IconData icon, VoidCallback onTap, ColorScheme cs, {bool isDestructive = false}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isDestructive ? Colors.red[50] : AppColors.sand,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Icon(icon, color: isDestructive ? Colors.red : AppColors.coffee, size: 22),
      ),
      title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: isDestructive ? Colors.red : cs.onSurface)),
      trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
      onTap: onTap,
    );
  }
}