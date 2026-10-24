sealed class Failure implements Exception {
  const Failure(this.message);

  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sin conexión a internet']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'La solicitud tardó demasiado']);
}

class GraphQLFailure extends Failure {
  const GraphQLFailure([super.message = 'Error en la respuesta del servidor']);
}

class RateLimitFailure extends Failure {
  const RateLimitFailure([
    super.message = 'Demasiadas solicitudes, intenta más tarde',
  ]);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Ocurrió un error inesperado']);
}
