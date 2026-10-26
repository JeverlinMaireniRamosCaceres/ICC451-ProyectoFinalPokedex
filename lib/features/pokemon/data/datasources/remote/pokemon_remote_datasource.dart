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
              // Tiempo máximo de espera para conectar y para recibir la respuesta
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: {'Content-Type': 'application/json'},
            ),
          );

  /// Solicita una pagina del catalogo
  /// [limit] indica cuantos pokemones se pueden traer
  /// [offset] indica desde cuál pokemon se empieza
  Future<PokemonPageDto> fetchPokemonPage({
    required int limit,
    required int offset,
  }) async {
    final variables = {'limit': limit, 'offset': offset};

    // Se imprime la consulta para poder visualizarla
    debugPrint('[GraphQL] CatalogoPokemon $variables');

    final response = await _dio.post<Map<String, dynamic>>(
      _endpoint,
      data: {'query': catalogoPokemonQuery, 'variables': variables},
    );

    final body = response.data;
    if (body == null) {
      throw const PokemonApiException('La API devolvió una respuesta vacía');
    }

    final data = body['data'] as Map<String, dynamic>?;
    final errors = body['errors'] as List<dynamic>?;

    // Si la API no devolvio datos, la peticion falla
    // Se muestra un error
    if (data == null) {
      final message = errors != null && errors.isNotEmpty
          ? (errors.first as Map<String, dynamic>)['message'] as String?
          : null;
      throw PokemonApiException(message ?? 'La API no devolvió datos');
    }

    // GraphQL puede devolver "data" y "errors" a la vez, que son errores parciales
    // Sucede cuando una parte de la consulta falla y el resto si funciono
    // En ese caso se imprimen los errores y se usan los datos que si llegaron
    if (errors != null && errors.isNotEmpty) {
      debugPrint('[GraphQL] Errores parciales $errors');
    }

    return PokemonPageDto.fromJson(data);
  }
}

/// Error que se lanza cuando la API responde pero no devuelve datos validos
class PokemonApiException implements Exception {
  final String message;

  const PokemonApiException(this.message);

  @override
  String toString() => 'PokemonApiException $message';
}
