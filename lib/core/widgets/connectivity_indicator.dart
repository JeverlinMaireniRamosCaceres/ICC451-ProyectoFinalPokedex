import 'package:flutter/material.dart';

import '../network/connectivity_monitor.dart';
import '../network/connectivity_status.dart';

class ConnectivityIndicator extends StatelessWidget {
  const ConnectivityIndicator({
    super.key,
    required this.monitor,
  });

  final ConnectivityMonitor monitor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityStatus>(
      stream: monitor.statusStream,
      initialData: monitor.currentStatus,
      builder: (context, snapshot) {
        final status = snapshot.data ?? ConnectivityStatus.offline;

        late final String message;
        late final IconData icon;
        late final Color color;

        switch (status) {
          case ConnectivityStatus.online:
            message = 'Conectado';
            icon = Icons.wifi;
            color = Colors.green;

          case ConnectivityStatus.offline:
            message = 'Sin conexión';
            icon = Icons.wifi_off;
            color = Colors.red;

          case ConnectivityStatus.serviceUnavailable:
            message = 'Servicio no disponible';
            icon = Icons.cloud_off;
            color = Colors.orange;

          case ConnectivityStatus.syncing:
            message = 'Sincronizando';
            icon = Icons.sync;
            color = Colors.blue;
        }

        return Semantics(
          label: 'Estado de conexión: $message',
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