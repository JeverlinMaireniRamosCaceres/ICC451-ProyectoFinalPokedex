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
  static const Duration _revisionPeriodica = Duration(minutes: 2);

  final Connectivity _conectividad;
  final Dio _dio;

  final _controlador = StreamController<ConnectivityStatus>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _suscripcion;
  Timer? _temporizadorDebounce;
  Timer? _temporizadorPeriodico;

  // Es null hasta que se hace la primera comprobacion
  ConnectivityStatus? _estadoBase;
  bool _estaSincronizando = false;
  ConnectivityStatus? _actual;

  ConnectivityMonitor({Connectivity? conectividad, Dio? dio})
      : _conectividad = conectividad ?? Connectivity(),
        _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 5),
                receiveTimeout: const Duration(seconds: 5),
                headers: {'Content-Type': 'application/json'},
              ),
            );

  /// es el stream que lanza el estado cada vez que cambia
  Stream<ConnectivityStatus> get flujoEstado => _controlador.stream;

  /// Es el estado actual, para consultarlo sin escuchar el stream
  ConnectivityStatus get estadoActual =>
      _actual ?? ConnectivityStatus.sinConexion;

  /// Comienza a vigilar la conexion
  /// Se llama cuando inicia la app
  Future<void> iniciar() async {
    _suscripcion = _conectividad.onConnectivityChanged.listen((_) {
      // si la red cambia varias veces continuas, solo se considera la ultima
      _temporizadorDebounce?.cancel();
      _temporizadorDebounce = Timer(_debounce, revisarAhora);
    });

    _temporizadorPeriodico = Timer.periodic(_revisionPeriodica, (_) => revisarAhora());

    await revisarAhora();
  }

  /// Verifica en el momento la red y la API
  Future<void> revisarAhora() async {
    final resultados = await _conectividad.checkConnectivity();
    final hayRed = resultados.any((r) => r != ConnectivityResult.none);

    if (!hayRed) {
      _cambiarEstadoBase(ConnectivityStatus.sinConexion);
      return;
    }

    var apiDisponible = await _hacerPing();
    // Si falla, se confirma con otro intento
    if (!apiDisponible) apiDisponible = await _hacerPing();
    _cambiarEstadoBase(
      apiDisponible
          ? ConnectivityStatus.conectado
          : ConnectivityStatus.servicioNoDisponible,
    );
  }

  /// El coordinador llama este metodo cuando empieza a descargar y coloca el estado en true
  /// Cuando termina la descarga lo coloca en false
  /// De esta forma el indicador muestra sincronizando cuando se esta descargando
  void cambiarSincronizando(bool valor) {
    _estaSincronizando = valor;
    _emitir();
  }

  /// Envia la consulta GraphQL más pequeña posible para saber si la API responde
  Future<bool> _hacerPing() async {
    try {
      final respuesta = await _dio.post<Map<String, dynamic>>(
        _endpoint,
        data: {'query': '{ __typename }'},
      );
      return respuesta.statusCode == 200 && respuesta.data?['data'] != null;
    } catch (e) {
      debugPrint('[Conectividad] La API no respondió $e');
      return false;
    }
  }

  void _cambiarEstadoBase(ConnectivityStatus estado) {
    _estadoBase = estado;
    _emitir();
  }

  /// Calcula el estado final y lo emite solo si cambio
  void _emitir() {
    final base = _estadoBase;

    // no se ha hecho la comprobacion, no muestra nada
    if (base == null) return;

    final siguiente = base == ConnectivityStatus.conectado && _estaSincronizando
        ? ConnectivityStatus.sincronizando
        : base;

    if (siguiente == _actual) return;

    _actual = siguiente;
    debugPrint('[Conectividad] Estado $siguiente');
    _controlador.add(siguiente);
  }

  /// Libera los recursos al cerrar la app
  Future<void> dispose() async {
    _temporizadorDebounce?.cancel();
    _temporizadorPeriodico?.cancel();
    await _suscripcion?.cancel();
    await _controlador.close();
  }
}