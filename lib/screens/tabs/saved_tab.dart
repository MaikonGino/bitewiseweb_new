import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme.dart';
import '../../global_state.dart'; // Import Correto
import '../recipe_result_screen.dart';

class SavedTab extends StatelessWidget {
  const SavedTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: savedRecipesNotifier,
      builder: (context, recipes, child) {
        if (recipes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: AppColors.terracotta.withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.bookmark_border, size: 60, color: AppColors.terracotta),
                ),
                const SizedBox(height: 24),
                Text("Seu livro está vazio", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: cs.onSurface)),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text("Crie receitas incríveis com o que você tem na geladeira e salve-as aqui.", textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.grey, height: 1.5)),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => tabNotifier.goToCreate(),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.terracotta, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14)),
                  child: Text("CRIAR AGORA", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                )
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return Dismissible(
                key: Key(recipe['id'] ?? recipe['title'] + index.toString()),
                direction: DismissDirection.endToStart,
                background: Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 24), margin: const EdgeInsets.only(bottom: 16), decoration: BoxDecoration(color: Colors.red[400], borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.delete_outline, color: Colors.white, size: 28)),
                onDismissed: (direction) {
                  final removed = savedRecipesNotifier.removeRecipe(index);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Receita removida.", style: GoogleFonts.poppins(color: Colors.white)), backgroundColor: const Color(0xFF333333), action: SnackBarAction(label: "DESFAZER", textColor: AppColors.terracotta, onPressed: () => savedRecipesNotifier.restoreRecipe(index, removed))));
                },
                child: Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: cs.primary.withOpacity(0.05))),
                    color: cs.surface,
                    child: InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeResultScreen(existingRecipe: recipe))),
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(children: [
                              ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(recipe['image'], width: 80, height: 80, fit: BoxFit.cover, errorBuilder: (c,e,s)=>Container(width:80,height:80,color:cs.primary.withOpacity(0.1),child:const Icon(Icons.restaurant)))),
                              const SizedBox(width: 16),
                              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(recipe['title'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: cs.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis), const SizedBox(height: 4), Text((recipe['ingredients'] as List).join(", "), style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey), maxLines: 2, overflow: TextOverflow.ellipsis), const SizedBox(height: 8), Row(children: [Icon(Icons.timer, size: 12, color: Colors.grey), const SizedBox(width: 4), Text(recipe['prep_time'] ?? "20 min", style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey))])])),
                              Icon(Icons.chevron_right, color: Colors.grey[300])
                            ])
                        )
                    )
                )
            );
          },
        );
      },
    );
  }
}