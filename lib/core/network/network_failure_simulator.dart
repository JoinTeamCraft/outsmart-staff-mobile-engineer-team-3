import 'dart:math';

import 'network_exception.dart';

/// Injects configurable network failures for testing and local development.
class NetworkFailureSimulator {
  NetworkFailureSimulator({
    this.failureRate = 0,
    Random? random,
  }) : _random = random ?? Random() {
    if (failureRate < 0 || failureRate > 1) {
      throw RangeError.range(failureRate, 0, 1, 'failureRate');
    }
  }

  final double failureRate;
  final Random _random;

  void maybeThrow() {
    if (failureRate > 0 && _random.nextDouble() < failureRate) {
      throw const SimulatedNetworkException();
    }
  }
}
