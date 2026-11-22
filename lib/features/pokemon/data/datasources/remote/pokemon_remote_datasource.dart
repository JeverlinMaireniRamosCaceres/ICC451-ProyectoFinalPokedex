import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../dtos/pokemon_dto.dart';
import 'pokemon_queries.dart';

/// Realiza las peticiones hacia la API GraphQL de PokeAPI
/// Las respuestas son convertidas en DTOs
class PokemonRemoteDataSource {
  static const String _endpoint = 'https://graphql.pokeapi.co/v1beta2';

  final Dio _dio;

  PokemonRemoteDataSource({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              // Es el tiempo máximo de espera para conectar y para recibir la respuesta
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: {'Content-Type': 'application/json'},
            ),
          );

  /// Solicita una pagina del catalogo
  /// [limite] indica cuantos pokemones se pueden traer
  /// [offset] indica desde cuál pokemon se empieza
  Future<PokemonPageDto> obtenerPaginaPokemon({
    required int limite,
    required int offset,
  }) async {
    final variables = {'limit': limite, 'offset': offset};

    // Se imprime la consulta para poder visualizarla
    debugPrint('[GraphQL] CatalogoPokemon $variables');

    // en GraphQL todas las peticiones van a la misma url
    // y la consulta va en el cuerpo de la peticion,
    // por eso se usa POST junto con las variables
    final respuesta = await _dio.post<Map<String, dynamic>>(
      _endpoint,
      data: {'query': catalogoPokemonQuery, 'variables': variables},
    );

    final cuerpo = respuesta.data;
    if (cuerpo == null) {
      throw const PokemonApiException('La API devolvió una respuesta vacía');
    }

    final datos = cuerpo['data'] as Map<String, dynamic>?;
    final errores = cuerpo['errors'] as List<dynamic>?;

    // Si la API no devolvio datos, la peticion falla
    // Se muestra un error
    if (datos == null) {
      final mensaje = errores != null && errores.isNotEmpty
          ? (errores.first as Map<String, dynamic>)['message'] as String?
          : null;
      throw PokemonApiException(mensaje ?? 'La API no devolvió datos');
    }

    // GraphQL puede devolver "data" y "errors" a la vez, que son errores parciales
    // Sucede cuando una parte de la consulta falla y el resto si funciono
    // En ese caso se imprimen los errores y se usan los datos que si llegaron
    if (errores != null && errores.isNotEmpty) {
      debugPrint('[GraphQL] Errores parciales $errores');
    }

    return PokemonPageDto.fromJson(datos);
  }
}

/// Error que se lanza cuando la API responde pero no devuelve datos validos
class PokemonApiException implements Exception {
  final String mensaje;

  const PokemonApiException(this.mensaje);

  @override
  String toString() => 'PokemonApiException $mensaje';
}
