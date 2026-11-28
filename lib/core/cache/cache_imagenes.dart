import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// Política de almacenamiento de las imágenes (PS-08)
// Qué se guarda: las imágenes que el usuario ve, y las de sus favoritos por adelantado
// Dónde: en la caché de archivos del teléfono, en una carpeta propia de la app
// Límite: 1500 archivos, cuando se pasa se borran los que llevan más tiempo sin usarse
// Limpieza: también se borran los archivos que llevan más de 60 días sin usarse
// El límite es por cantidad y no por tamaño, porque el paquete no ofrece un tope en bytes
class CacheImagenes {
  static final CacheManager gestor = CacheManager(
    Config(
      'imagenesPokedex',
      stalePeriod: const Duration(days: 60),
      maxNrOfCacheObjects: 1500,
    ),
  );
}