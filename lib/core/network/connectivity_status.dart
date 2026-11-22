/// Los cuatro estados posibles de conexion de la pokeapi
enum ConnectivityStatus {
  /// Hay red y la API esta respondiendo
  conectado,

  /// No hay red disponible
  sinConexion,

  /// Existe red, pero la API no responde o respondio con un error
  servicioNoDisponible,

  /// Hay conexion, se esta sincronizando el catalogo
  sincronizando,
}
