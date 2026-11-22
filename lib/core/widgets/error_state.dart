import 'package:flutter/material.dart';

// Error comprensible con la opción «Reintentar»
class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.mensaje, required this.alReintentar});

  final String mensaje;
  final VoidCallback alReintentar;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExcludeSemantics(
              child: Icon(Icons.error_outline, size: 64, color: colores.error),
            ),
            const SizedBox(height: 16),
            Text(
              mensaje,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: alReintentar,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
