import 'package:flutter_test/flutter_test.dart';
import 'package:streaklearn/core/di/service_locator.dart';
import 'package:streaklearn/core/network/api_client.dart';
import 'package:streaklearn/features/lessons/repositories/asset_lesson_repository.dart';
import 'package:streaklearn/features/lessons/repositories/lesson_repository.dart';
import 'package:streaklearn/features/quizzes/repositories/asset_quiz_repository.dart';
import 'package:streaklearn/features/quizzes/repositories/quiz_repository.dart';

void main() {
  tearDown(() => locator.reset());

  test('registers the shared API client and repository interfaces', () {
    setupLocator();

    expect(locator<ApiClient>(), isA<ApiClient>());
    expect(locator<LessonRepository>(), isA<AssetLessonRepository>());
    expect(locator<QuizRepository>(), isA<AssetQuizRepository>());
    expect(locator<ApiClient>(), same(locator<ApiClient>()));
  });
}
