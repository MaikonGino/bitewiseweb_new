import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';
import '../../theme.dart';
import 'tabs/create_tab.dart';
import 'tabs/profile_placeholder.dart';
import 'tabs/saved_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // O ValueListenableBuilder garante que a tela mude assim que authNotifier mudar
    return ValueListenableBuilder<bool>(
      valueListenable: authNotifier,
      builder: (context, isLoggedIn, child) {

        // Define as abas dinamicamente
        final List<Widget> tabs = [
          const CreateTab(),
          isLoggedIn ? const SavedTab() : const ProfilePlaceholder(),
          isLoggedIn
              ? ProfileTab(onLogout: () => authNotifier.logout())
              : const ProfilePlaceholder(),
        ];

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Image.asset('assets/images/logo.png', height: 32),
                const SizedBox(width: 10),
                Text(
                  "BiteWise",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => themeNotifier.toggleTheme(),
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              ),
              const SizedBox(width: 12),
            ],
          ),

          body: tabs[_selectedIndex],

          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) => setState(() => _selectedIndex = index),
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 10,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.soup_kitchen_outlined), selectedIcon: Icon(Icons.soup_kitchen), label: 'Criar'),
              NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'Receitas'),
              NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Você'),
            ],
          ),
        );
      },
    );
  }
}