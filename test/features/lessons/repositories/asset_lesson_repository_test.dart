import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streaklearn/core/errors/app_failure.dart';
import 'package:streaklearn/core/errors/data_result.dart';
import 'package:streaklearn/core/network/api_client.dart';
import 'package:streaklearn/core/network/network_failure_simulator.dart';
import 'package:streaklearn/features/lessons/models/lesson.dart';
import 'package:streaklearn/features/lessons/repositories/asset_lesson_repository.dart';

void main() {
  group('AssetLessonRepository', () {
    test('returns typed lessons from valid JSON', () async {
      final repository = AssetLessonRepository(
        _clientReturning('''
          [
            {
              "id": "lesson-1",
              "title": "Flutter Basics",
              "topic": "Fundamentals",
              "thumbnail": "https://example.com/flutter.png",
              "content": "Everything is a widget."
            }
          ]
        '''),
      );

      final result = await repository.getLessons();

      expect(result, isA<DataSuccess<List<Lesson>>>());
      final lessons = (result as DataSuccess<List<Lesson>>).data;
      expect(lessons.single.id, 'lesson-1');
      expect(() => lessons.add(lessons.single), throwsUnsupportedError);
    });

    test('returns ParsingFailure for malformed JSON', () async {
      final repository = AssetLessonRepository(
        _clientReturning('{"lessons": []}'),
      );

      final result = await repository.getLessons();

      expect(
        (result as DataFailure<List<Lesson>>).failure,
        isA<ParsingFailure>(),
      );
    });

    test('returns NetworkFailure for a simulated failure', () async {
      final repository = AssetLessonRepository(
        ApiClient(
          assetLoader: (_) async => '[]',
          failureSimulator: NetworkFailureSimulator(failureRate: 1),
          latency: Duration.zero,
        ),
      );

      final result = await repository.getLessons();

      expect(
        (result as DataFailure<List<Lesson>>).failure,
        isA<NetworkFailure>(),
      );
    });

    test('returns AssetFailure when bundled data cannot be loaded', () async {
      final repository = AssetLessonRepository(
        ApiClient(
          assetLoader: (_) async => throw FlutterError('Missing asset'),
          latency: Duration.zero,
        ),
      );

      final result = await repository.getLessons();

      expect(
        (result as DataFailure<List<Lesson>>).failure,
        isA<AssetFailure>(),
      );
    });

    test('returns UnknownFailure for an unexpected client error', () async {
      final repository = AssetLessonRepository(
        ApiClient(
          assetLoader: (_) async => throw StateError('Unexpected'),
          latency: Duration.zero,
        ),
      );

      final result = await repository.getLessons();

      final failure = (result as DataFailure<List<Lesson>>).failure;
      expect(failure, isA<UnknownFailure>());
      expect(failure.cause, isA<StateError>());
      expect(failure.stackTrace, isNotNull);
    });
  });
}

ApiClient _clientReturning(String response) {
  return ApiClient(
    assetLoader: (_) async => response,
    latency: Duration.zero,
  );
}
