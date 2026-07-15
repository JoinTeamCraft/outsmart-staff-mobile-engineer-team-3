import 'dart:async';

import 'package:http/http.dart' as http;

import 'network_exception.dart';

/// Executes requests and normalizes transport errors into [NetworkException].
class NetworkExceptionHandler {
  const NetworkExceptionHandler({
    this.timeout = const Duration(seconds: 10),
  });

  final Duration timeout;

  Future<T> execute<T>(Future<T> Function() operation) async {
    try {
      return await operation().timeout(timeout);
    } on NetworkException {
      rethrow;
    } on TimeoutException catch (error, stackTrace) {
      throw NetworkException(
        'The request timed out.',
        cause: error,
        stackTrace: stackTrace,
      );
    } on http.ClientException catch (error, stackTrace) {
      throw NetworkException(
        'The request could not reach the server.',
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }
}
