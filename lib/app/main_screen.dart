import 'package:flutter/material.dart';

import '../core/widgets/empty_state.dart';
import '../features/pokemon/presentation/pages/catalog_screen.dart';
import '../features/pokemon/presentation/widgets/indicador_conexion.dart';
import '../features/pokemon/presentation/pages/favorites_screen.dart';

// Pantalla principal, tiene la barra de abajo y las pestañas
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // La pestaña elegida solo importa a esta pantalla, por eso no necesita provider
  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack mantiene vivas las pestañas, así el catálogo no pierde el scroll
      body: IndexedStack(
        index: _indice,
        children: const [
          CatalogScreen(),
          FavoritesScreen(),
          _Proximamente(titulo: 'Trivia'),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (i) => setState(() => _indice = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Catálogo',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz),
            label: 'Trivia',
          ),
        ],
      ),
    );
  }
}

// Pantalla temporal, se reemplaza cuando se construya cada sección
class _Proximamente extends StatelessWidget {
  const _Proximamente({required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: const [IndicadorConexion()]
      ),
      body: const EmptyState(mensaje: 'Esta sección estará disponible pronto'),
    );
  }
}