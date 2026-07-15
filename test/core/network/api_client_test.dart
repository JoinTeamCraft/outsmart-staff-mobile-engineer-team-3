import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:streaklearn/core/network/api_client.dart';
import 'package:streaklearn/core/network/network_exception.dart';
import 'package:streaklearn/core/network/network_exception_handler.dart';
import 'package:streaklearn/core/network/network_failure_simulator.dart';

void main() {
  group('ApiClient', () {
    test('loads lesson data through the injected asset loader', () async {
      String? requestedPath;
      final client = ApiClient(
        assetLoader: (path) async {
          requestedPath = path;
          return '[{"id":"lesson-1"}]';
        },
        latency: Duration.zero,
      );

      final response = await client.getLessonsRaw();

      expect(response, '[{"id":"lesson-1"}]');
      expect(requestedPath, 'assets/mock_data/lessons.json');
    });

    test('throws a typed exception when failure simulation is enabled',
        () async {
      final client = ApiClient(
        assetLoader: (_) async => '[]',
        failureSimulator: NetworkFailureSimulator(failureRate: 1),
        latency: Duration.zero,
      );

      expect(
        client.getQuizzesRaw,
        throwsA(isA<SimulatedNetworkException>()),
      );
    });

    test('does not hide asset loading errors', () async {
      final error = FlutterError('Asset not found');
      final client = ApiClient(
        assetLoader: (_) async => throw error,
        latency: Duration.zero,
      );

      expect(client.getLessonsRaw, throwsA(same(error)));
    });
  });

  group('NetworkExceptionHandler', () {
    test('maps timeouts to NetworkException', () async {
      const handler = NetworkExceptionHandler(
        timeout: Duration(milliseconds: 1),
      );

      expect(
        () => handler.execute(() async {
          await Future<void>.delayed(const Duration(milliseconds: 20));
          return 'late response';
        }),
        throwsA(
          isA<NetworkException>()
              .having(
                  (error) => error.message, 'message', contains('timed out'))
              .having((error) => error.cause, 'cause', isA<TimeoutException>()),
        ),
      );
    });

    test('maps HTTP client failures to NetworkException', () async {
      const handler = NetworkExceptionHandler();

      expect(
        () => handler.execute<String>(
          () async => throw http.ClientException('Connection closed'),
        ),
        throwsA(
          isA<NetworkException>()
              .having(
                (error) => error.message,
                'message',
                contains('reach the server'),
              )
              .having(
                (error) => error.cause,
                'cause',
                isA<http.ClientException>(),
              ),
        ),
      );
    });
  });
}
