import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

import 'main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      theme: construirTema(),
      home: const MainScreen(),
    );
  }
}
