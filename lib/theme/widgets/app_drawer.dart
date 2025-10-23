// Conteúdo para: lib/widgets/app_drawer.dart

import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'BiteWise Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Início'),
            onTap: () {
              // TODO: Navegar para o Início (se não estiver lá)
              Navigator.pop(context); // Fecha o menu
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Meu Perfil'),
            onTap: () {
              // TODO: Navegar para o Perfil
              Navigator.pop(context); // Fecha o menu
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Configurações'),
            onTap: () {
              // TODO: Navegar para Configurações
              Navigator.pop(context); // Fecha o menu
            },
          ),
        ],
      ),
    );
  }
}