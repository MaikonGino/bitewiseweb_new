import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';
import '../../theme.dart';
import '../../global_state.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  bool _showEmailForm = false;
  bool _isRegistering = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  void _performAuth() async {
    // 1. Mostra Loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) => const Center(child: CircularProgressIndicator(color: AppColors.terracotta)),
    );

    // 2. Simula rede
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return; // Segurança contra crash
    Navigator.pop(context); // Fecha loading

    // 3. Realiza login
    authNotifier.login();

    if (!mounted) return;
    Navigator.pop(context); // Fecha modal

    // 4. Feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isRegistering ? "Conta criada com sucesso!" : "Bem-vindo de volta!",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: AppColors.olive,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Altura dinâmica segura
    final double heightFactor = _showEmailForm ? (_isRegistering ? 0.85 : 0.75) : 0.55;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuint,
      height: MediaQuery.of(context).size.height * heightFactor,
      // Padding seguro para teclado
      padding: EdgeInsets.fromLTRB(24, 12, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Puxador
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(2)),
            ),
          ),

          // Conteúdo com Scroll (Para não quebrar em telas pequenas)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center, // Centraliza o conteúdo verticalmente
                children: [
                  const SizedBox(height: 24),

                  // --- TELA INICIAL (ESCOLHA) ---
                  if (!_showEmailForm) ...[
                    Text(
                      "Acesse o BiteWise",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold, color: cs.onSurface),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Salve receitas, sincronize seus dispositivos e acesse recursos exclusivos.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                      ),
                    ),

                    const SizedBox(height: 40), // Espaço fixo em vez de Spacer()

                    // 1. GOOGLE (HERÓI)
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _performAuth,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.g_mobiledata, color: Colors.blue, size: 32),
                            const SizedBox(width: 12),
                            Text("Continuar com Google", style: GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87)),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 2. EMAIL
                    SizedBox(
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: () => setState(() => _showEmailForm = true),
                        icon: Icon(Icons.mail_outline, color: cs.onSurface),
                        label: Text("Usar e-mail e senha", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: cs.onSurface)),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: cs.onSurface.withOpacity(0.2)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // --- FORMULÁRIO DE EMAIL ---
                  if (_showEmailForm) ...[
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => setState(() => _showEmailForm = false),
                        ),
                        Text(
                          _isRegistering ? "Criar Conta" : "Login com E-mail",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    if (_isRegistering) ...[
                      _buildInput("Nome Completo", Icons.person_outline, _nameController, cs, isDark),
                      const SizedBox(height: 16)
                    ],
                    _buildInput("E-mail", Icons.email_outlined, _emailController, cs, isDark),
                    const SizedBox(height: 16),
                    _buildInput("Senha", Icons.lock_outline, _passwordController, cs, isDark, isPassword: true),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _performAuth,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.terracotta,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text(_isRegistering ? "CADASTRAR" : "ENTRAR", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isRegistering ? "Já tem conta?" : "Novo no BiteWise?",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () => setState(() => _isRegistering = !_isRegistering),
                          child: Text(
                            _isRegistering ? "Fazer Login" : "Criar Conta",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: AppColors.terracotta),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(String label, IconData icon, TextEditingController controller, ColorScheme cs, bool isDark, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: GoogleFonts.poppins(color: cs.onSurface),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: isDark ? const Color(0xFF2C2C2C) : Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }
}