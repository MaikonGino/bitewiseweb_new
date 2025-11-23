import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../theme.dart';
import '../recipe_result_screen.dart';

class CreateTab extends StatefulWidget {
  const CreateTab({super.key});

  @override
  State<CreateTab> createState() => _CreateTabState();
}

class _CreateTabState extends State<CreateTab> {
  final TextEditingController _ingredientController = TextEditingController();
  final List<String> _ingredients = [];

  final Map<String, List<String>> _categories = {
    "Básicos": ["Arroz", "Feijão", "Ovo", "Macarrão"],
    "Proteínas": ["Frango", "Carne", "Peixe", "Tofu"],
    "Vegetais": ["Tomate", "Cenoura", "Batata", "Cebola"],
  };

  void _addIngredient(String text) {
    if (text.trim().isEmpty) return;
    final List<String> newItems = text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    setState(() {
      for (var item in newItems) {
        String formatted = item[0].toUpperCase() + item.substring(1);
        if (!_ingredients.contains(formatted)) _ingredients.add(formatted);
      }
      _ingredientController.clear();
    });
  }

  void _removeIngredient(String ingredient) => setState(() => _ingredients.remove(ingredient));

  Future<void> _generateRecipe() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 150,
                child: Lottie.network(
                  'https://lottie.host/d52ad3b9-6b2d-4d46-8211-e2a2a61189a0/6LNQtfLEkA.json',
                  errorBuilder: (c, e, s) => Icon(Icons.soup_kitchen, size: 80, color: AppColors.terracotta),
                ),
              ),
              const SizedBox(height: 16),
              Text("Preparando sua receita...", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 4));

    if (mounted) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeResultScreen(userIngredients: _ingredients)));
    }
  }

  void _showDownloadModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo no modal também para reforçar a marca
            Image.asset('assets/images/logo.png', height: 60),
            const SizedBox(height: 24),
            Text("Baixe o App Android", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              "A versão completa para Android com todas as funcionalidades estará disponível em breve para download direto.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], foregroundColor: Colors.black87),
                child: const Text("FECHAR"),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bool canGenerate = _ingredients.length >= 3;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          children: [
            // ... (Banner e Input - Sem alterações)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.terracotta, AppColors.coffee],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: AppColors.terracotta.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Olá, Chef! 👨‍🍳", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  Text("Digite o que você tem e nós criamos a mágica.", style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.9))),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text("Seus Ingredientes", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _ingredientController,
              onSubmitted: (val) => _addIngredient(val),
              decoration: InputDecoration(
                hintText: "Ex: Ovo, Leite, Farinha...",
                prefixIcon: const Icon(Icons.add_circle, color: AppColors.terracotta),
                suffixIcon: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => _addIngredient(_ingredientController.text)),
              ),
            ),

            if (_ingredients.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: _ingredients.map((ing) => Chip(
                  label: Text(ing, style: TextStyle(color: cs.onSurface)),
                  backgroundColor: cs.primary.withOpacity(0.1),
                  deleteIcon: Icon(Icons.close, size: 16, color: cs.onSurface.withOpacity(0.6)),
                  onDeleted: () => _removeIngredient(ing),
                )).toList(),
              ),
            ],

            const SizedBox(height: 32),

            if (_ingredients.length < 3) ...[
              Text("Sugestões Rápidas:", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 16),
              ..._categories.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.key, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: cs.primary, fontSize: 15)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: entry.value.map((item) => ActionChip(
                        label: Text(item, style: TextStyle(color: cs.onSurface)),
                        onPressed: () => _addIngredient(item),
                        backgroundColor: cs.surface,
                        elevation: 1,
                        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                        padding: const EdgeInsets.all(8),
                      )).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              }).toList(),
            ],

            const SizedBox(height: 20),

            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: canGenerate ? _generateRecipe : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.terracotta,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: cs.onSurface.withOpacity(0.12),
                  disabledForegroundColor: cs.onSurface.withOpacity(0.38),
                  elevation: canGenerate ? 4 : 0,
                ),
                child: Text(
                  canGenerate ? "GERAR RECEITA" : "ADICIONE ${3 - _ingredients.length} INGREDIENTES",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 60),

            // --- NOVA SEÇÃO PREMIUM: BAIXE O APP ---
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                // Fundo sutilmente diferente para destacar
                color: cs.surface,
                borderRadius: BorderRadius.circular(24),
                // Borda fina e sombra suave para um efeito de "cartão elevado"
                border: Border.all(color: cs.primary.withOpacity(0.08)),
                boxShadow: [
                  BoxShadow(
                    color: cs.shadow.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // --- MOCKUP DO CELULAR COM LOGO ---
                  Container(
                    width: 80,
                    height: 140,
                    decoration: BoxDecoration(
                      color: cs.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: cs.onSurface.withOpacity(0.2), width: 3),
                    ),
                    child: Center(
                      // Logo dentro da "tela" do celular
                      child: Image.asset('assets/images/logo.png', height: 40),
                    ),
                  ),
                  const SizedBox(width: 24),
                  // --- TEXTO E BOTÃO ---
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Leve o BiteWise com você",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: cs.primary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Baixe o app oficial para a melhor experiência.",
                          style: GoogleFonts.poppins(color: cs.onSurface.withOpacity(0.7), fontSize: 13),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => _showDownloadModal(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.terracotta, width: 1.5),
                              foregroundColor: AppColors.terracotta,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            icon: const Icon(Icons.download_rounded, size: 20),
                            label: Text("BAIXAR APK", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}