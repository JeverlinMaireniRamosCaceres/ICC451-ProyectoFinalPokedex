import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'connectivity_status.dart';

/// Esta clase se encarga de observar la conexion real de la pokeapi,
/// y avisa cuando el estado cambia
class ConnectivityMonitor {
  static const String _endpoint = 'https://graphql.pokeapi.co/v1beta2';

  // Espera antes de evaluar un cambio de red
  static const Duration _debounce = Duration(seconds: 1);

  // Se define el periodo en el que se vuelve a comprobar la API aunque la red no cambie
  // No es muy frecuente por el límite de peticiones de la API
  static const Duration _periodicCheck = Duration(minutes: 2);

  final Connectivity _connectivity;
  final Dio _dio;

  final _controller = StreamController<ConnectivityStatus>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _debounceTimer;
  Timer? _periodicTimer;

  // Es null hasta que se hace la primera comprobacion
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

  /// es el stream que lanza el estado cada vez que cambia
  Stream<ConnectivityStatus> get statusStream => _controller.stream;

  /// Es el estado actual, para consultarlo sin escuchar el stream
  ConnectivityStatus get currentStatus =>
      _current ?? ConnectivityStatus.offline;

  /// Comienza a vigilar la conexion
  /// Se llama cuando inicia la app
  Future<void> start() async {
    _subscription = _connectivity.onConnectivityChanged.listen((_) {
      // si la red cambia varias veces continuas, solo se considera la ultima
      _debounceTimer?.cancel();
      _debounceTimer = Timer(_debounce, checkNow);
    });

    _periodicTimer = Timer.periodic(_periodicCheck, (_) => checkNow());

    await checkNow();
  }

  /// Verifica en el momento la red y la API
  Future<void> checkNow() async {
    final results = await _connectivity.checkConnectivity();
    final hasNetwork = results.any((r) => r != ConnectivityResult.none);

    if (!hasNetwork) {
      _setBaseStatus(ConnectivityStatus.offline);
      return;
    }

    var apiAvailable = await _pingApi();
    // Si falla, se confirma con otro intento
    if (!apiAvailable) apiAvailable = await _pingApi();
    _setBaseStatus(
      apiAvailable
          ? ConnectivityStatus.online
          : ConnectivityStatus.serviceUnavailable,
    );
  }

  /// El coordinador llama este metodo cuando empieza a descargar y coloca el estado en true
  /// Cuando termina la descarga lo coloca en false
  /// De esta forma el indicador muestra sincronizando cuando se esta descargando
  void setSyncing(bool value) {
    _isSyncing = value;
    _emit();
  }

  /// Envia la consulta GraphQL más pequeña posible para saber si la API responde
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

  /// Calcula el estado final y lo emite solo si cambio
  void _emit() {
    final base = _baseStatus;

    // no se ha hecho la comprobacion, no muestra nada
    if (base == null) return;

    final next = base == ConnectivityStatus.online && _isSyncing
        ? ConnectivityStatus.syncing
        : base;

    if (next == _current) return;

    _current = next;
    debugPrint('[Conectividad] Estado $next');
    _controller.add(next);
  }

  /// Libera los recursos al cerrar la app
  Future<void> dispose() async {
    _debounceTimer?.cancel();
    _periodicTimer?.cancel();
    await _subscription?.cancel();
    await _controller.close();
  }
}