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
      stream: monitor.flujoEstado,
      initialData: monitor.estadoActual,
      builder: (context, snapshot) {
        final estado = snapshot.data ?? ConnectivityStatus.sinConexion;

        late final String mensaje;
        late final IconData icono;
        late final Color color;

        // Cada estado tiene un texto, un color y un icono, para que se entienda mejor
        // y no dependa solo del color
        switch (estado) {
          case ConnectivityStatus.conectado:
            mensaje = 'Conectado';
            icono = Icons.wifi;
            color = Colors.green.shade300;

          case ConnectivityStatus.sinConexion:
            mensaje = 'Sin conexión';
            icono = Icons.wifi_off;
            color = Colors.red.shade300;

          case ConnectivityStatus.servicioNoDisponible:
            mensaje = 'Servicio no disponible';
            icono = Icons.cloud_off;
            color = Colors.orange.shade300;

          case ConnectivityStatus.sincronizando:
            mensaje = 'Sincronizando';
            icono = Icons.sync;
            color = Colors.blue.shade300;
        }

        return Semantics(
          label: 'Estado de conexión: $mensaje',
          // El lector de pantalla lee el cambio de estado sin que el usuario toque nada
          liveRegion: true,
          // Evita que el lector de pantalla lea también el texto de adentro
          excludeSemantics: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icono,
                color: color,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                mensaje,
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