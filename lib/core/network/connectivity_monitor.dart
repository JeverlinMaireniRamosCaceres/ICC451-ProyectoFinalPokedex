import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'connectivity_status.dart';

/// Esta clase se encarga de observar la conexion real de la PokeAPI,
/// y avisa por un Stream cuando el estado cambia
class ConnectivityMonitor {
  static const String _endpoint = 'https://graphql.pokeapi.co/v1beta2';

  // Espera antes de evaluar un cambio de red, para evitar parpadeos
  static const Duration _debounce = Duration(seconds: 1);

  // Cada cuánto se vuelve a comprobar la API aunque la red no cambie.
  // No es muy frecuente porque la API tiene límite de peticiones
  static const Duration _periodicCheck = Duration(minutes: 2);

  final Connectivity _connectivity;
  final Dio _dio;

  final _controller = StreamController<ConnectivityStatus>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _debounceTimer;
  Timer? _periodicTimer;

  // Es null hasta que termina la primera comprobación
  ConnectivityStatus? _baseStatus;
  bool _isSyncing = false;
  ConnectivityStatus? _current;

  ConnectivityMonitor({Connectivity? connectivity, Dio? dio})
      : _connectivity = connectivity ?? Connectivity(),
        _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 5),
                receiveTimeout: const Duration(seconds: 5),
                headers: {'Content-Type': 'application/json'},
              ),
            );

  /// Stream que emite el estado cada vez que cambia.
  Stream<ConnectivityStatus> get statusStream => _controller.stream;

  /// Estado actual, para quien necesite consultarlo sin escuchar el Stream.
  ConnectivityStatus get currentStatus =>
      _current ?? ConnectivityStatus.offline;

  /// Empieza a vigilar la conexión. Se llama una vez al iniciar la app.
  Future<void> start() async {
    _subscription = _connectivity.onConnectivityChanged.listen((_) {
      // Si la red cambia varias veces seguidas, solo se evalúa la última
      _debounceTimer?.cancel();
      _debounceTimer = Timer(_debounce, checkNow);
    });

    _periodicTimer = Timer.periodic(_periodicCheck, (_) => checkNow());

    await checkNow();
  }

  /// Comprueba ahora mismo la red y la API.
  Future<void> checkNow() async {
    final results = await _connectivity.checkConnectivity();
    final hasNetwork = results.any((r) => r != ConnectivityResult.none);

    if (!hasNetwork) {
      _setBaseStatus(ConnectivityStatus.offline);
      return;
    }

    final apiAvailable = await _pingApi();
    _setBaseStatus(
      apiAvailable
          ? ConnectivityStatus.online
          : ConnectivityStatus.serviceUnavailable,
    );
  }

  /// La sincronización llama a este método al empezar (true) y al terminar (false).
  void setSyncing(bool value) {
    _isSyncing = value;
    _emit();
  }

  /// Envía la consulta GraphQL más pequeña posible para saber si la API responde.
  Future<bool> _pingApi() async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _endpoint,
        data: {'query': '{ __typename }'},
      );
      return response.statusCode == 200 && response.data?['data'] != null;
    } catch (e) {
      debugPrint('[Conectividad] La API no respondió $e');
      return false;
    }
  }

  void _setBaseStatus(ConnectivityStatus status) {
    _baseStatus = status;
    _emit();
  }

  /// Calcula el estado final y lo emite solo si cambió.
  void _emit() {
    final base = _baseStatus;

    // Todavía no se ha hecho la primera comprobación, no se muestra nada
    if (base == null) return;

    final next = base == ConnectivityStatus.online && _isSyncing
        ? ConnectivityStatus.syncing
        : base;

    if (next == _current) return;

    _current = next;
    debugPrint('[Conectividad] Estado $next');
    _controller.add(next);
  }

  /// Libera los recursos al cerrar la app.
  Future<void> dispose() async {
    _debounceTimer?.cancel();
    _periodicTimer?.cancel();
    await _subscription?.cancel();
    await _controller.close();
  }
}