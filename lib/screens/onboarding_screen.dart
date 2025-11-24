import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../global_state.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      "title": "Use o que você já tem",
      "text": "Encontre receitas perfeitas em segundos com os ingredientes da sua geladeira.",
      "lottie": "https://lottie.host/8302237a-c733-49bc-b4ca-542d4cf78289/SFtzhAgCXs.json",
    },
    {
      "title": "Evite Desperdícios",
      "text": "Economize dinheiro e ajude o planeta aproveitando cada ingrediente.",
      "lottie": "https://lottie.host/9b178a87-7254-4c9e-8fee-35f76f4439fa/uinEhOSmjS.json",
    },
    {
      "title": "Receitas Mágicas",
      "text": "Nossa Inteligência Artificial cria pratos únicos baseados no seu gosto.",
      "lottie": "https://lottie.host/b5e465e2-23e2-4699-9e34-2952c4a88948/9UcqvXGPLl.json",
    },
  ];

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Cor Laranja Oficial (Terracotta) para garantir contraste
    const Color brandOrange = Color(0xFFD35400);

    return Scaffold(
      backgroundColor: cs.background,
      body: SafeArea(
        child: Stack(
          children: [
            // --- CONTEÚDO ---
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 60),
                            Expanded(
                              flex: 3,
                              child: Lottie.network(
                                _pages[index]["lottie"]!,
                                fit: BoxFit.contain,
                                width: 300,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.broken_image, size: 80, color: cs.primary.withOpacity(0.3));
                                },
                                frameBuilder: (context, child, composition) {
                                  if (composition != null) return child;
                                  return Center(child: CircularProgressIndicator(color: brandOrange));
                                },
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              _pages[index]["title"]!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: cs.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _pages[index]["text"]!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: cs.onBackground.withOpacity(0.8),
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // --- RODAPÉ ---
                Container(
                  padding: const EdgeInsets.all(32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentPage > 0)
                        TextButton(
                          onPressed: () {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text("Voltar", style: GoogleFonts.poppins(color: Colors.grey, fontWeight: FontWeight.w600)),
                        )
                      else
                        const SizedBox(width: 60),

                      // Bolinhas
                      Row(
                        children: List.generate(
                          _pages.length,
                              (index) => GestureDetector(
                            onTap: () => _controller.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: _currentPage == index ? 24 : 8,
                              decoration: BoxDecoration(
                                // Se ativo: Laranja. Se inativo: tom suave da cor primária.
                                color: _currentPage == index ? brandOrange : cs.primary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),

                      if (_currentPage == _pages.length - 1)
                        ElevatedButton(
                          onPressed: _goToHome,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: brandOrange, // COR FIXA LARANJA
                            foregroundColor: Colors.white, // TEXTO BRANCO FIXO
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            elevation: 4,
                          ),
                          child: const Text("Começar"),
                        )
                      else
                        TextButton(
                          onPressed: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text("Próximo", style: GoogleFonts.poppins(color: brandOrange, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            // --- TOPO ---
            Positioned(
              top: 20,
              left: 24,
              right: 24,
              child: Row(
                children: [
                  Image.asset('assets/images/logo.png', height: 40, fit: BoxFit.contain),
                  const Spacer(),
                  IconButton(
                    onPressed: () => themeNotifier.toggleTheme(),
                    icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: cs.primary),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: _goToHome,
                    child: Text("Pular", style: GoogleFonts.poppins(color: Colors.grey, fontWeight: FontWeight.w600)),
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