import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.mensaje,
    this.icono = Icons.inbox_outlined,
    this.textoAccion,
    this.alAccionar,
  });

  final String mensaje;
  final IconData icono;
  final String? textoAccion;
  final VoidCallback? alAccionar;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;

    // Scroll por si el texto del sistema está al 200%
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExcludeSemantics(
              child: Icon(icono, size: 64, color: colores.outline),
            ),
            const SizedBox(height: 16),
            Text(
              mensaje,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (textoAccion != null && alAccionar != null) ...[
              const SizedBox(height: 16),
              FilledButton(onPressed: alAccionar, child: Text(textoAccion!)),
            ],
          ],
        ),
      ),
    );
  }
}
