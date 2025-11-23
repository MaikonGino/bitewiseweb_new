import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedTab extends StatelessWidget {
  const SavedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.bookmark_border, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          Text("Nenhuma receita salva ainda.", style: GoogleFonts.poppins(color: Colors.grey)),
        ],
      ),
    );
  }
}