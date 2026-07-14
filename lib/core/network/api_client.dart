import 'package:flutter/services.dart';

import 'network_exception_handler.dart';
import 'network_failure_simulator.dart';

typedef AssetLoader = Future<String> Function(String path);

class ApiClient {
  ApiClient({
    AssetLoader? assetLoader,
    NetworkExceptionHandler? exceptionHandler,
    NetworkFailureSimulator? failureSimulator,
    this.latency = const Duration(milliseconds: 500),
  })  : _assetLoader = assetLoader ?? rootBundle.loadString,
        _exceptionHandler = exceptionHandler ?? const NetworkExceptionHandler(),
        _failureSimulator = failureSimulator ?? NetworkFailureSimulator();

  final AssetLoader _assetLoader;
  final NetworkExceptionHandler _exceptionHandler;
  final NetworkFailureSimulator _failureSimulator;
  final Duration latency;

  Future<String> getLessonsRaw() {
    return _loadAsset('assets/mock_data/lessons.json');
  }

  Future<String> getQuizzesRaw() {
    return _loadAsset('assets/mock_data/quizzes.json');
  }

  Future<String> _loadAsset(String path) {
    return _exceptionHandler.execute(() async {
      await Future<void>.delayed(latency);
      _failureSimulator.maybeThrow();
      return _assetLoader(path);
    });
  }
}
