import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme.dart';

class AboutModal extends StatelessWidget {
  const AboutModal({super.key});

  // Função para abrir o site
  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://bitewisedesing.web.app/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7, // Altura confortável
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Puxador
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 32),

          // Logo e Título
          Center(child: Image.asset('assets/images/logo.png', height: 60)),
          const SizedBox(height: 16),
          Text(
            "Nossa Missão",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: cs.onSurface),
          ),

          const SizedBox(height: 24),

          // Conteúdo (Baseado na Documentação)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Unindo tecnologia e sabor.",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.terracotta),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "O BiteWise nasceu na interseção entre a inteligência artificial e a paixão culinária. Nossa missão é transformar ingredientes comuns em experiências extraordinárias, combatendo o desperdício e devolvendo a criatividade para a sua cozinha.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600], height: 1.6),
                  ),
                  const SizedBox(height: 24),

                  // Cards de Valores
                  Row(
                    children: [
                      _buildValueCard(Icons.eco, "Sustentável", Colors.green),
                      const SizedBox(width: 12),
                      _buildValueCard(Icons.lightbulb, "Inovador", Colors.amber),
                      const SizedBox(width: 12),
                      _buildValueCard(Icons.favorite, "Humano", Colors.red),
                    ],
                  ),

                  const SizedBox(height: 24),
                  Text(
                    "Desenvolvido por WebInnovate",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: cs.primary.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Botão de Ação (Link Externo)
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: _launchURL,
              icon: const Icon(Icons.language, color: Colors.white),
              label: Text("VISITAR DESIGN SYSTEM", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.coffee, // Cor mais sóbria/institucional
                foregroundColor: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(label, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
      ),
    );
  }
}