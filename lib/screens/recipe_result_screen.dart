import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../global_state.dart';
import 'login_modal.dart';

class RecipeResultScreen extends StatefulWidget {
  final List<String>? userIngredients;
  final Map<String, dynamic>? existingRecipe;
  const RecipeResultScreen({super.key, this.userIngredients, this.existingRecipe});

  @override
  State<RecipeResultScreen> createState() => _RecipeResultScreenState();
}

class _RecipeResultScreenState extends State<RecipeResultScreen> {
  late Map<String, dynamic> recipe;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingRecipe != null) {
      recipe = widget.existingRecipe!;
      isSaved = true;
    } else {
      recipe = {
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "title": "Prato Mágico com ${widget.userIngredients?.first ?? 'Ingredientes'}",
        "image": "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=1000&auto=format&fit=crop",
        "prep_time": "25 min",
        "servings": "2 pessoas",
        "difficulty": "Fácil",
        "calories": "320 kcal",
        "ingredients": widget.userIngredients ?? [],
        "steps": [
          "Higienize bem todos os vegetais e corte em cubos pequenos.",
          "Aqueça uma frigideira antiaderente com um fio de azeite.",
          "Refogue os ingredientes base por 5 minutos até dourarem.",
          "Adicione os temperos a gosto e deixe cozinhar em fogo baixo.",
          "Sirva quente decorado com folhas frescas."
        ],
        "tips": ["Adicione limão no final.", "Use ervas frescas se tiver."],
        "storage": "Geladeira: 3 dias. Freezer: 30 dias.",
        "date": DateTime.now().toString().split(' ')[0],
      };
      isSaved = false;
    }
  }

  void _handleSave() {
    if (!authNotifier.value) {
      showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) => const LoginModal());
      return;
    }
    savedRecipesNotifier.saveRecipe(recipe);
    setState(() => isSaved = true);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Receita salva!", style: GoogleFonts.poppins()), backgroundColor: AppColors.olive, behavior: SnackBarBehavior.floating, action: SnackBarAction(label: "VER LISTA", textColor: Colors.white, onPressed: () {
      Navigator.pop(context);
      tabNotifier.goToSaved(); // Agora funciona
    })));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0, pinned: true, backgroundColor: AppColors.terracotta,
            leading: Container(margin: const EdgeInsets.all(8), decoration: BoxDecoration(color: cs.surface.withOpacity(0.8), shape: BoxShape.circle), child: IconButton(icon: Icon(Icons.arrow_back, color: cs.onSurface), onPressed: () => Navigator.pop(context))),
            actions: [ if (!isSaved) Container(margin: const EdgeInsets.all(8), decoration: BoxDecoration(color: cs.surface.withOpacity(0.8), shape: BoxShape.circle), child: IconButton(icon: const Icon(Icons.bookmark_add_outlined, color: AppColors.terracotta), onPressed: _handleSave)) ],
            flexibleSpace: FlexibleSpaceBar(background: Image.network(recipe['image'], fit: BoxFit.cover, errorBuilder: (c,e,s) => Container(color: AppColors.coffee, child: const Center(child: Icon(Icons.restaurant, color: Colors.white, size: 50))))),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(color: cs.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
              transform: Matrix4.translationValues(0, -20, 0),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: cs.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(20), border: Border.all(color: cs.primary.withOpacity(0.1))), child: Row(mainAxisSize: MainAxisSize.min, children: [Image.asset('assets/images/logo.png', height: 18), const SizedBox(width: 8), Text("Receita BiteWise IA", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: cs.primary))]))),
                  const SizedBox(height: 20),
                  Text(recipe['title'], style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: cs.onBackground)),
                  const SizedBox(height: 16),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_buildMetaInfo(Icons.timer_outlined, recipe['prep_time'], "Preparo", cs), _buildMetaInfo(Icons.bar_chart_rounded, recipe['difficulty'], "Dificuldade", cs), _buildMetaInfo(Icons.restaurant_menu, recipe['servings'], "Porções", cs)]),
                  const SizedBox(height: 32), const Divider(), const SizedBox(height: 24),
                  Text("Ingredientes", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  Wrap(spacing: 8, runSpacing: 8, children: (recipe['ingredients'] as List).map((ing) => Chip(label: Text(ing.toString()), backgroundColor: cs.surface, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.grey.withOpacity(0.2))))).toList()),
                  const SizedBox(height: 32),
                  Text("Modo de Preparo", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  ... (recipe['steps'] as List).asMap().entries.map((entry) => Padding(padding: const EdgeInsets.only(bottom: 16), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [CircleAvatar(radius: 12, backgroundColor: AppColors.terracotta, child: Text("${entry.key + 1}", style: GoogleFonts.poppins(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold))), const SizedBox(width: 12), Expanded(child: Text(entry.value, style: GoogleFonts.poppins(fontSize: 16, height: 1.5)))]))),
                  const SizedBox(height: 24),
                  _buildInfoCard("Dicas do Chef", recipe['tips'].join("\n"), Icons.lightbulb_outline, Colors.amber, cs),
                  const SizedBox(height: 16),
                  _buildInfoCard("Armazenamento", recipe['storage'], Icons.inventory_2_outlined, Colors.blue, cs),
                  const SizedBox(height: 40),
                  if (!isSaved) SizedBox(width: double.infinity, height: 56, child: ElevatedButton.icon(onPressed: _handleSave, style: ElevatedButton.styleFrom(backgroundColor: AppColors.terracotta, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), icon: const Icon(Icons.bookmark_border), label: Text("SALVAR NO MEU LIVRO", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)))),
                  const SizedBox(height: 40),
                  Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: cs.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.withOpacity(0.2))), child: Row(children: [const Icon(Icons.warning_amber_rounded, color: Colors.grey), const SizedBox(width: 12), Expanded(child: Text("Receita gerada por Inteligência Artificial. Verifique os ingredientes.", style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey)))])),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaInfo(IconData icon, String text, String label, ColorScheme cs) => Column(children: [Icon(icon, color: AppColors.terracotta, size: 28), const SizedBox(height: 4), Text(text, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14, color: cs.onBackground)), Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey))]);
  Widget _buildInfoCard(String title, String content, IconData icon, Color color, ColorScheme cs) => Container(width: double.infinity, padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(icon, size: 20, color: color), const SizedBox(width: 8), Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: color))]), const SizedBox(height: 8), Text(content, style: GoogleFonts.poppins(fontSize: 14, height: 1.5, color: cs.onBackground.withOpacity(0.8)))]));
}