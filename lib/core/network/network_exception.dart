/// A typed exception for connectivity and request execution failures.
class NetworkException implements Exception {
  const NetworkException(
    this.message, {
    this.cause,
    this.stackTrace,
  });

  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  String toString() => 'NetworkException: $message';
}

/// A deterministic network exception used to exercise failure paths.
final class SimulatedNetworkException extends NetworkException {
  const SimulatedNetworkException()
      : super('A simulated network failure occurred.');
}
