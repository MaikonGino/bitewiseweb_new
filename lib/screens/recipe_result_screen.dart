import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import 'login_modal.dart'; // Vamos criar esse modal simples

class RecipeResultScreen extends StatelessWidget {
  final List<String> userIngredients;

  const RecipeResultScreen({super.key, required this.userIngredients});

  void _promptLogin(BuildContext context) {
    // AQUI É O GATILHO: O usuário gostou e quer salvar? Agora pedimos login.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LoginModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // AppBar transparente para a imagem subir
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.red),
              onPressed: () => _promptLogin(context), // Pede login ao curtir
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem de Topo (Placeholder Temático)
            Container(
              height: 300,
              width: double.infinity,
              color: AppColors.olive.withOpacity(0.3), // Fundo caso imagem falhe
              child: Image.network(
                'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=1000&auto=format&fit=crop', // Imagem de comida genérica
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => const Center(child: Icon(Icons.image, size: 50)),
              ),
            ),

            // Conteúdo da Receita (Fundo arredondado subindo na imagem)
            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    Text(
                      "Salada Mágica da Geladeira", // Título Fake
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Tags (Tempo, Dificuldade)
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 16, color: Colors.grey),
                        Text(" 15 min  ", style: GoogleFonts.poppins(color: Colors.grey)),
                        const Icon(Icons.local_fire_department_outlined, size: 16, color: Colors.grey),
                        Text(" Fácil", style: GoogleFonts.poppins(color: Colors.grey)),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Ingredientes Usados (Baseado no input do usuário)
                    Text(
                      "Ingredientes Utilizados:",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: userIngredients.map((ing) => Chip(
                        label: Text(ing),
                        backgroundColor: AppColors.terracotta.withOpacity(0.1),
                      )).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Modo de Preparo (Fake)
                    Text(
                      "Modo de Preparo:",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "1. Misture todos os ingredientes em uma tigela.\n2. Tempere com azeite, sal e pimenta.\n3. Sirva fresco e aproveite sua economia!",
                      style: GoogleFonts.poppins(fontSize: 16, height: 1.6),
                    ),

                    const SizedBox(height: 40),

                    // Botão Principal: SALVAR
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => _promptLogin(context), // GATILHO DE LOGIN
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.terracotta,
                          foregroundColor: Colors.white,
                        ),
                        child: Text("SALVAR NO MEU LIVRO", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}