import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

import '../features/pokemon/presentation/pages/catalog_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const CatalogScreen(),
    );
  }
}
