import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../theme.dart';
import '../../main.dart'; // Acesso aos notifiers e global state
import '../../global_state.dart'; // Para PreferencesState se necessário
import '../recipe_result_screen.dart';
import '../plans_screen.dart';

class CreateTab extends StatefulWidget {
  const CreateTab({super.key});

  @override
  State<CreateTab> createState() => _CreateTabState();
}

class _CreateTabState extends State<CreateTab> {
  final TextEditingController _ingredientController = TextEditingController();
  final List<String> _ingredients = [];

  final List<Map<String, dynamic>> _allIngredientsDb = [
    {"name": "Arroz", "category": "Básicos", "tags": ["carb", "vegan", "gluten_free"]},
    {"name": "Feijão", "category": "Básicos", "tags": ["carb", "vegan", "gluten_free", "protein"]},
    {"name": "Ovo", "category": "Básicos", "tags": ["protein", "animal", "gluten_free", "low_carb"]},
    {"name": "Frango", "category": "Proteínas", "tags": ["protein", "animal", "meat", "gluten_free", "low_carb"]},
    {"name": "Tofu", "category": "Proteínas", "tags": ["protein", "vegan", "gluten_free", "low_carb"]},
    {"name": "Tomate", "category": "Vegetais", "tags": ["vegan", "gluten_free", "low_carb"]},
    {"name": "Cenoura", "category": "Vegetais", "tags": ["vegan", "gluten_free", "carb"]},
  ];

  Map<String, List<String>> _getSmartSuggestions(Set<String> filters) {
    Map<String, List<String>> result = {"Básicos": [], "Proteínas": [], "Vegetais": []};
    for (var item in _allIngredientsDb) {
      bool isAllowed = true;
      if (filters.contains("Vegano") && item['tags'].contains("animal")) isAllowed = false;
      if (filters.contains("Vegetariano") && item['tags'].contains("meat")) isAllowed = false;
      if (filters.contains("Sem Glúten") && item['tags'].contains("gluten")) isAllowed = false;
      if (filters.contains("Low Carb") && item['tags'].contains("carb") && !item['tags'].contains("low_carb")) isAllowed = false;

      if (isAllowed) result[item['category']]!.add(item['name']);
    }
    // Garante que não fique vazio
    if(result["Básicos"]!.isEmpty) result["Básicos"] = ["Água", "Sal", "Azeite"];
    return result;
  }

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

  Future<void> _generateRecipe(String selectedAI, Set<String> diets) async {
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
              Text("Chef $selectedAI cozinhando...", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              if (diets.isNotEmpty)
                Text("Considerando: ${diets.join(', ')}", textAlign: TextAlign.center, style: GoogleFonts.poppins(color: AppColors.terracotta, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeResultScreen(userIngredients: _ingredients)));
    }
  }

  void _showDownloadModal(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context, backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(color: cs.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(32))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset('assets/images/logo.png', height: 60),
          const SizedBox(height: 24),
          Text("Baixe o App Android", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: cs.onSurface)),
          const SizedBox(height: 32),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], foregroundColor: Colors.black87), child: const Text("FECHAR")))
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bool canGenerate = _ingredients.length >= 3;

    return ValueListenableBuilder<PreferencesState>(
        valueListenable: preferencesNotifier,
        builder: (context, prefs, _) {
          final smartSuggestions = _getSmartSuggestions(prefs.dietFilters);

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                children: [
                  // --- BANNER ---
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppColors.terracotta, AppColors.coffee], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: AppColors.terracotta.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Olá, Chef! 👨‍🍳", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 8),
                        Text(
                            prefs.dietFilters.isEmpty ? "Digite o que você tem e nós criamos a mágica." : "Modo ${prefs.dietFilters.join(' + ')} ativado.",
                            style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.9))
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- SELETOR IA ---
                  Text("Escolha sua IA", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                  const SizedBox(height: 12),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(color: cs.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: cs.primary.withOpacity(0.1))),
                    child: Row(
                      children: ["Gemini", "OpenAI", "Llama"].map((ai) {
                        final isSelected = prefs.selectedAI == ai;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => preferencesNotifier.setAI(ai),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.terracotta.withOpacity(0.15) : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: isSelected ? Border.all(color: AppColors.terracotta, width: 1.5) : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(ai, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? AppColors.terracotta : Colors.grey, fontSize: 13)),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- INPUT ---
                  Text("Seus Ingredientes", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: cs.onSurface)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _ingredientController,
                    onSubmitted: (val) => _addIngredient(val),
                    style: TextStyle(color: cs.onSurface),
                    decoration: InputDecoration(
                      hintText: "Ex: Ovo, Leite, Farinha...",
                      prefixIcon: const Icon(Icons.add_circle, color: AppColors.terracotta),
                      suffixIcon: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => _addIngredient(_ingredientController.text)),
                    ),
                  ),

                  if (_ingredients.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(spacing: 8, runSpacing: 8, children: _ingredients.map((ing) => Chip(label: Text(ing, style: TextStyle(color: cs.onSurface)), backgroundColor: cs.primary.withOpacity(0.1), deleteIcon: Icon(Icons.close, size: 16, color: cs.onSurface.withOpacity(0.6)), onDeleted: () => _removeIngredient(ing))).toList()),
                  ],

                  const SizedBox(height: 32),

                  // --- SUGESTÕES INTELIGENTES ---
                  if (_ingredients.length < 3) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sugestões Rápidas:", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey)),
                        if (prefs.dietFilters.isNotEmpty) Icon(Icons.check_circle, size: 16, color: AppColors.olive),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...smartSuggestions.entries.map((entry) {
                      if (entry.value.isEmpty) return const SizedBox.shrink();
                      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(entry.key, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: cs.primary, fontSize: 15)), const SizedBox(height: 8), Wrap(spacing: 10, runSpacing: 10, children: entry.value.map((item) => ActionChip(label: Text(item, style: TextStyle(color: cs.onSurface)), onPressed: () => _addIngredient(item), backgroundColor: cs.surface, elevation: 1, side: BorderSide(color: Colors.grey.withOpacity(0.2)), padding: const EdgeInsets.all(8))).toList()), const SizedBox(height: 24)]);
                    }).toList(),
                  ],

                  const SizedBox(height: 20),

                  // --- BOTÃO GERAR ---
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: canGenerate ? () => _generateRecipe(prefs.selectedAI, prefs.dietFilters) : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.terracotta,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: cs.onSurface.withOpacity(0.12),
                        disabledForegroundColor: cs.onSurface.withOpacity(0.38),
                        elevation: canGenerate ? 4 : 0,
                      ),
                      child: Text(
                        canGenerate ? "GERAR COM ${prefs.selectedAI.toUpperCase()}" : "ADICIONE ${3 - _ingredients.length} INGREDIENTES",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // --- COMO FUNCIONA (CORRIGIDO CONTRASTE) ---
                  Text("Como o BiteWise funciona?", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: cs.onSurface)),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: [
                        _buildStepCard(context, "01", "Seus Itens", "Você nos diz o que tem na geladeira.", Icons.kitchen, AppColors.terracotta),
                        const SizedBox(width: 16),
                        _buildStepCard(context, "02", "Mágica", "A IA cria receitas únicas para você.", Icons.auto_awesome, Colors.purple),
                        const SizedBox(width: 16),
                        _buildStepCard(context, "03", "Economia", "Evite desperdício e economize.", Icons.savings, Colors.green),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  // --- PREMIUM E APK ---
                  ValueListenableBuilder<bool>(
                      valueListenable: planNotifier,
                      builder: (context, isPremium, _) {
                        return Column(
                          children: [
                            if (!isPremium)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PlansScreen())),
                                  child: Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: AppColors.coffee, borderRadius: BorderRadius.circular(24)), child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppColors.terracotta, borderRadius: BorderRadius.circular(8)), child: Text("OFERTA ESPECIAL", style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white))), const SizedBox(height: 12), Text("Seja Premium", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)), const SizedBox(height: 4), Text("Receitas ilimitadas e cardápios semanais.", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13))])), Container(width: 50, height: 50, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Icon(Icons.arrow_forward, color: AppColors.coffee))])),
                                ),
                              ),
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(color: cs.surface, borderRadius: BorderRadius.circular(24), border: Border.all(color: cs.primary.withOpacity(0.1)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))]),
                              child: Row(children: [Container(width: 70, height: 130, decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 4))]), padding: const EdgeInsets.all(3), child: Container(decoration: BoxDecoration(color: AppColors.sand, borderRadius: BorderRadius.circular(9)), child: Center(child: Image.asset('assets/images/logo.png', height: 30, fit: BoxFit.contain)))), const SizedBox(width: 24), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Leve o BiteWise", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: cs.primary)), const SizedBox(height: 4), Text("Tenha a experiência completa no seu Android.", style: GoogleFonts.poppins(color: cs.onSurface.withOpacity(0.7), fontSize: 13)), const SizedBox(height: 16), SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () => _showDownloadModal(context), style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.terracotta), foregroundColor: AppColors.terracotta, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), icon: const Icon(Icons.download_rounded, size: 20), label: const Text("BAIXAR APK")))]))]),
                            ),
                          ],
                        );
                      }
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _buildStepCard(BuildContext context, String number, String title, String desc, IconData icon, Color accentColor) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.grey.withOpacity(0.2) : Colors.transparent),
        boxShadow: [if (!isDark) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AQUI ESTÁ A CORREÇÃO DE CONTRASTE (Opacity 0.5)
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: accentColor.withOpacity(0.1), shape: BoxShape.circle), child: Icon(icon, color: accentColor, size: 20)), Text(number, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w900, color: cs.primary.withOpacity(0.5)))]),
          const Spacer(),
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: cs.onSurface)),
          const SizedBox(height: 4),
          Text(desc, style: GoogleFonts.poppins(fontSize: 12, color: cs.onSurface.withOpacity(0.6), height: 1.4)),
        ],
      ),
    );
  }
}