// Conteúdo para: lib/screens/home_screen.dart (VERSÃO PROFISSIONAL)

import 'package:flutter/material.dart';
import 'package:bitewise_app/screens/placeholder_receita_screen.dart';
import 'package:bitewise_app/screens/placeholder_voce_screen.dart';
import 'package:bitewise_app/theme/app_colors.dart';
import 'package:bitewise_app/main.dart';
import 'package:bitewise_app/theme/widgets/app_drawer.dart';
import 'package:bitewise_app/screens/recipe_screen.dart';
import 'package:bitewise_app/theme/widgets/responsive_center.dart'; // Importa o delimitador

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _toggleTheme() {
    setState(() {
      themeNotifier.value = themeNotifier.value == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  // A lista de páginas agora usa o delimitador
  static const List<Widget> _widgetOptions = <Widget>[
    ResponsiveCenter(child: HomePageContent()), // <--- APLICADO
    ResponsiveCenter(child: PlaceholderReceitaScreen()), // <--- APLICADO
    ResponsiveCenter(child: PlaceholderVoceScreen()), // <--- APLICADO
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          'BiteWise',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Criar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu_outlined),
            activeIcon: Icon(Icons.restaurant_menu),
            label: 'Receita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Você',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// --- CONTEÚDO DA HOME SEPARADO ---
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A sua receita perfeita em instantes!',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Como o BiteWise funciona?',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          // Passos agora usam um Row, como no Figma
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TEXTOS ADICIONADOS CONFORME SOLICITADO
              _buildStepCircle(
                '1. Digite seus ingredientes.', // [cite: 436]
                'assets/images/home_passo1.png',
              ),
              _buildStepCircle(
                '2. Descubra uma receita com os seus ingredientes.', // [cite: 437]
                'assets/images/home_passo2.png',
              ),
              _buildStepCircle(
                '3. Siga os passos da receita.', // [cite: 438]
                'assets/images/home_passo3.png',
              ),
            ],
          ),
          SizedBox(height: 24),
          _buildGenerateRecipeCard(context),
          SizedBox(height: 24),
          Text(
            'Menos tempo, mais sabor!',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _buildInfoCard(
            'Praticidade',
            'Receitas em segundos, mais tempo com quem você ama.',
            'assets/images/card_praticidade.png',
          ),
          _buildInfoCard(
            'Ingredientes',
            'Use ao máximo o que você tem. Sem desperdício.',
            'assets/images/card_ingredientes.png',
          ),
          _buildInfoCard(
            'Oferta',
            '2 meses grátis* + 16% de desconto no plano anual.',
            'assets/images/card_oferta.png',
          ),
        ],
      ),
    );
  }

  // Widget dos Passos (AGORA COM TEXTO)
  Widget _buildStepCircle(String text, String imagePath) {
    return Flexible(
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: AssetImage(imagePath),
            // Mensagem de erro caso a imagem não exista
            onBackgroundImageError: (exception, stackTrace) {
              debugPrint('Erro ao carregar imagem: $imagePath');
            },
          ),
          SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Card "Faça sua receita"
  Widget _buildGenerateRecipeCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.begeClaro.withOpacity(0.5)
            : AppColors.cinzaNuvem.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cinzaNuvem.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Faça sua receita',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: 'Digite seus ingredientes, separados por vírgula.',
              hintStyle: TextStyle(fontSize: 14),
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.laranjaPaprika,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeScreen()),
              );
            },
            child: Text('Começar'),
          ),
        ],
      ),
    );
  }

  // Card de Informações
  Widget _buildInfoCard(String title, String subtitle, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                // Mostra um ícone se a imagem falhar
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey.shade200,
                    child: Icon(Icons.image_not_supported, color: Colors.grey.shade400),
                  );
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
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