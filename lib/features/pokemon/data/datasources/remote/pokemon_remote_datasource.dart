import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/errors/failure.dart';
import '../../dtos/pokemon_detail_dto.dart';
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
    final datos = await _consultar(
      'CatalogoPokemon',
      catalogoPokemonQuery,
      {'limit': limite, 'offset': offset},
    );
    return PokemonPageDto.fromJson(datos);
  }

  /// Solicita el detalle de un Pokemon por su id
  Future<PokemonDetailDto> obtenerDetallePokemon(int id) async {
    final datos = await _consultar(
      'DetallePokemon',
      detallePokemonQuery,
      {'id': id},
    );

    // la API devuelve una lista, con un solo Pokemon si el id existe
    final lista = datos['pokemon'] as List<dynamic>? ?? [];
    if (lista.isEmpty) {
      throw const GraphQLFailure('No se encontró el Pokémon');
    }
    return PokemonDetailDto.fromJson(lista.first as Map<String, dynamic>);
  }

  /// Envia una query a la API y devuelve la parte "data" de la respuesta
  /// Lo usan el catalogo y el detalle
  Future<Map<String, dynamic>> _consultar(
      String nombre,
      String query,
      Map<String, dynamic> variables,
      ) async {
    // Se imprime la consulta para poder visualizarla
    debugPrint('[GraphQL] $nombre $variables');

    // en GraphQL todas las peticiones van a la misma url
    // y la consulta va en el cuerpo de la peticion,
    // por eso se usa POST junto con las variables
    final Response<Map<String, dynamic>> respuesta;
    try {
      respuesta = await _dio.post<Map<String, dynamic>>(
        _endpoint,
        data: {'query': query, 'variables': variables},
      );
    } on DioException catch (e) {
      throw _convertirError(e);
    }

    final cuerpo = respuesta.data;
    if (cuerpo == null) {
      throw const GraphQLFailure();
    }

    final datos = cuerpo['data'] as Map<String, dynamic>?;
    final errores = cuerpo['errors'] as List<dynamic>?;

    // Si la API no devolvio datos, la peticion falla
    // El mensaje tecnico de la API se imprime y al usuario le llega uno en español
    if (datos == null) {
      final mensaje = errores != null && errores.isNotEmpty
          ? (errores.first as Map<String, dynamic>)['message'] as String?
          : null;
      debugPrint('[GraphQL] Error $mensaje');
      throw const GraphQLFailure();
    }

    // GraphQL puede devolver "data" y "errors" a la vez, que son errores parciales
    // Sucede cuando una parte de la consulta falla y el resto si funciono
    // En ese caso se imprimen los errores y se usan los datos que si llegaron
    if (errores != null && errores.isNotEmpty) {
      debugPrint('[GraphQL] Errores parciales $errores');
    }

    return datos;
  }

  /// Convierte el error de Dio en un Failure con un mensaje para el usuario
  Failure _convertirError(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => const TimeoutFailure(),
      DioExceptionType.connectionError => const NetworkFailure(),
      DioExceptionType.badResponse when e.response?.statusCode == 429 =>
      const RateLimitFailure(),
      DioExceptionType.badResponse => const GraphQLFailure(),
      _ => const UnknownFailure(),
    };
  }
}