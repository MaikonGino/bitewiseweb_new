import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../main.dart';
import '../../global_state.dart'; // Import para evitar erros de notifier
import '../theme.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  void _handleSubscription(BuildContext context, bool isAlreadyPremium) {
    final cs = Theme.of(context).colorScheme;

    // 1. Loading Modal (Respeitando o tema)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100,
                child: Lottie.network(
                  'https://assets2.lottiefiles.com/packages/lf20_w51pcehl.json',
                  errorBuilder: (c, e, s) => const Icon(Icons.sync, size: 50, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isAlreadyPremium ? "Cancelando..." : "Processando...",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // 2. Simulação de Ação
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Fecha loading

      if (isAlreadyPremium) {
        planNotifier.cancel();
        // Feedback de cancelamento com texto branco forçado
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Que pena! Você voltou ao plano Gratuito.",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF333333),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      } else {
        planNotifier.upgrade();
        // Modal de Sucesso (Confete)
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Confete
                  Lottie.network(
                    'https://assets10.lottiefiles.com/packages/lf20_qmfs6c3i.json',
                    height: 120,
                    errorBuilder: (c, e, s) => const Icon(Icons.check_circle, size: 60, color: Colors.green),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Bem-vindo à Elite!",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.terracotta,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Todas as funções foram desbloqueadas.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Fecha dialog
                        Navigator.pop(context); // Fecha tela de planos
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.terracotta),
                      child: const Text("COMEÇAR A COZINHAR", style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ValueListenableBuilder<bool>(
      valueListenable: planNotifier,
      builder: (context, isPremium, _) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            // Título sempre branco por causa dos fundos escuros/gradientes
            title: Text(
              isPremium ? "Sua Assinatura" : "Upgrade",
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: isPremium ? _buildActiveState(context, cs) : _buildSalesPage(context, cs),
        );
      },
    );
  }

  // --- TELA DE VENDA (Checkout) ---
  Widget _buildSalesPage(BuildContext context, ColorScheme cs) {
    return Stack(
      children: [
        // Fundo Gradiente
        Container(
          height: 400,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.coffee, AppColors.terracotta],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
          ),
        ),

        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 100, 24, 40),
          child: Column(
            children: [
              Text(
                "Desbloqueie seu\nPotencial na Cozinha",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Junte-se a mais de 10.000 chefs caseiros que economizam tempo e dinheiro.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),

              const SizedBox(height: 40),

              // Card Premium (Destaque)
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                      border: Border.all(color: AppColors.terracotta, width: 2),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          "BiteWise PRO",
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: AppColors.terracotta,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "R\$",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: cs.onSurface,
                              ),
                            ),
                            Text(
                              "19,90",
                              style: GoogleFonts.poppins(
                                fontSize: 42,
                                fontWeight: FontWeight.w900,
                                color: cs.onSurface,
                              ),
                            ),
                            Text(
                              "/mês",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Menos que um delivery 🍕",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        _buildFeatureItem("Receitas Ilimitadas", true, cs),
                        _buildFeatureItem("Ingredientes Ilimitados", true, cs),
                        _buildFeatureItem("Zero Anúncios", true, cs),
                        _buildFeatureItem("Cardápios Semanais", true, cs),

                        const SizedBox(height: 32),

                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () => _handleSubscription(context, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.terracotta,
                              foregroundColor: Colors.white,
                              elevation: 8,
                              shadowColor: AppColors.terracotta.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              "TESTAR AGORA",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Cancele a qualquer momento.",
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  // Tag Recomendado
                  Positioned(
                    top: -16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.white, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              "RECOMENDADO",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // CARD BASIC
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: cs.surface.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    Text(
                      "Plano Básico",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureItem("Apenas 3 Ingredientes", false, cs),
                    _buildFeatureItem("10 Receitas/mês", false, cs),
                    _buildFeatureItem("Com Anúncios", false, cs),
                    const SizedBox(height: 16),
                    Text(
                      "Você já está neste plano.",
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- TELA ATIVA PREMIUM (CARTÃO VIP DOURADO/ESCURO) ---
  Widget _buildActiveState(BuildContext context, ColorScheme cs) {
    return Stack(
      children: [
        // Fundo sempre escuro/neutro para destacar o cartão
        Container(color: const Color(0xFF121212)),

        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.terracotta.withOpacity(0.1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.terracotta.withOpacity(0.1),
                  blurRadius: 100,
                  spreadRadius: 50,
                )
              ],
            ),
          ),
        ),

        Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CARTÃO VIP
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E), // Cinza bem escuro
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFFFFD700).withOpacity(0.5),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 40,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        // Foguete Animado
                        child: Lottie.network(
                          'https://lottie.host/26462616-3ad5-4184-8c0a-c72f784ead4d/jYbnEU6nDD.json',
                          errorBuilder: (c, e, s) => const Icon(
                            Icons.rocket_launch,
                            size: 80,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "MEMBRO ELITE",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                          color: const Color(0xFFFFD700),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Você é um Chef Pro!",
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Aproveite todos os benefícios sem limites. Você está no topo.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[400],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => _handleSubscription(context, true),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red[900]!),
                            foregroundColor: Colors.red[300],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("CANCELAR ASSINATURA"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(String text, bool isIncluded, ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            isIncluded ? Icons.check_circle : Icons.cancel,
            color: isIncluded ? AppColors.terracotta : Colors.grey[300],
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isIncluded ? cs.onSurface : Colors.grey,
                fontWeight: isIncluded ? FontWeight.w500 : FontWeight.normal,
                decoration: isIncluded ? null : TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }
}