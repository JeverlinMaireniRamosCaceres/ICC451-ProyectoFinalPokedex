import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/connectivity_indicator.dart';
import '../providers/pokemon_providers.dart';

// Indicador de conexión ya conectado al monitor, para ponerlo en cualquier pantalla
// Tiene el mismo margen que en el catálogo, así queda en la misma posición (IND-01)
class IndicadorConexion extends ConsumerWidget {
  const IndicadorConexion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: ConnectivityIndicator(
        monitor: ref.watch(connectivityMonitorProvider),
      ),
    );
  }
}