import 'package:flutter/material.dart';

import '../network/connectivity_monitor.dart';
import '../network/connectivity_status.dart';

/// Muestra el estado de la conexion con texto, iconos y color
/// Escucha el stream del monitor y vuelve a dibujarlo cada vez que el estado cambia
class ConnectivityIndicator extends StatelessWidget {
  const ConnectivityIndicator({
    super.key,
    required this.monitor,
  });

  final ConnectivityMonitor monitor;

  @override
  Widget build(BuildContext context) {

    // StreamBuilder escucha el Stream del monitor y vuelve a dibujar
    // el indicador cada vez que llega un estado nuevo
    // initialData muestra el estado actual mientras llega el primero
    return StreamBuilder<ConnectivityStatus>(
      stream: monitor.statusStream,
      initialData: monitor.currentStatus,
      builder: (context, snapshot) {
        final status = snapshot.data ?? ConnectivityStatus.offline;

        late final String message;
        late final IconData icon;
        late final Color color;

        // Cada estado tiene un texto, un color y un icono, para que se entienda mejor
        // y no dependa solo del color
        switch (status) {
          case ConnectivityStatus.online:
            message = 'Conectado';
            icon = Icons.wifi;
            color = Colors.green.shade800;

          case ConnectivityStatus.offline:
            message = 'Sin conexión';
            icon = Icons.wifi_off;
            color = Colors.red.shade800;

          case ConnectivityStatus.serviceUnavailable:
            message = 'Servicio no disponible';
            icon = Icons.cloud_off;
            color = Colors.orange.shade900;

          case ConnectivityStatus.syncing:
            message = 'Sincronizando';
            icon = Icons.sync;
            color = Colors.blue.shade800;
        }

        return Semantics(
          label: 'Estado de conexión: $message',
          // El lector de pantalla lee el cambio de estado sin que el usuario toque nada
          liveRegion: true,
          // Evita que el lector de pantalla lea también el texto de adentro
          excludeSemantics: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                message,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}