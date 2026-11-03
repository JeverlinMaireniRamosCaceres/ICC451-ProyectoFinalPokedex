/// Los cuatro estados posibles de conexion de la pokeapi
enum ConnectivityStatus {
  /// Hay red y la API esta respondiendo
  online,

  /// No hay red disponible
  offline,

  /// Existe red, pero la API no responde o respondio con un error
  serviceUnavailable,

  /// Hay conexion, se esta sincronizando el catalogo
  syncing,
}
