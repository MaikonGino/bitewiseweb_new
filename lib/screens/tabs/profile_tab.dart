import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../onboarding_screen.dart'; // Para poder voltar ao tutorial

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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // ... (Código da foto de perfil igual ao anterior) ...
          Stack(
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

          const SizedBox(height: 32),

          // Campos (iguais ao anterior)
          _buildLabel("Nome Completo"),
          TextField(
            controller: _nameController,
            style: GoogleFonts.poppins(color: cs.onSurface),
            decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline)),
          ),
          const SizedBox(height: 20),
          _buildLabel("E-mail"),
          TextField(
            controller: _emailController,
            style: GoogleFonts.poppins(color: cs.onSurface),
            decoration: const InputDecoration(prefixIcon: Icon(Icons.email_outlined)),
          ),

          const SizedBox(height: 40),

          // BOTÃO SALVAR
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

          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),

          // --- BOTÃO VER TUTORIAL ---
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.school_outlined, color: AppColors.coffee),
            ),
            title: Text("Ver Tutorial", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OnboardingScreen()));
            },
          ),

          // --- BOTÃO SAIR (LOGOUT) ---
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.logout, color: Colors.redAccent),
            ),
            title: Text("Sair da Conta", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.redAccent)),
            onTap: widget.onLogout, // Agora funciona porque a Home está ouvindo!
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 4),
        child: Text(text, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
      ),
    );
  }
}