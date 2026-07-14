import 'package:flutter_test/flutter_test.dart';
import 'package:streaklearn/core/errors/app_failure.dart';
import 'package:streaklearn/core/errors/data_result.dart';
import 'package:streaklearn/core/network/api_client.dart';
import 'package:streaklearn/features/quizzes/models/quiz.dart';
import 'package:streaklearn/features/quizzes/repositories/asset_quiz_repository.dart';

void main() {
  group('AssetQuizRepository', () {
    test('returns the typed quiz matching a lesson ID', () async {
      final repository = AssetQuizRepository(_clientReturning(_quizzesJson));

      final result = await repository.getQuizByLessonId('lesson-1');

      expect(result, isA<DataSuccess<Quiz>>());
      final quiz = (result as DataSuccess<Quiz>).data;
      expect(quiz.id, 'quiz-1');
      expect(quiz.questions.single.prompt, 'What is Flutter built from?');
    });

    test('returns NotFoundFailure for an unknown lesson', () async {
      final repository = AssetQuizRepository(_clientReturning(_quizzesJson));

      final result = await repository.getQuizByLessonId('lesson-404');

      expect(
        (result as DataFailure<Quiz>).failure,
        isA<NotFoundFailure>(),
      );
    });

    test('returns ParsingFailure for malformed quiz data', () async {
      final repository = AssetQuizRepository(
        _clientReturning('[{"id":"quiz-1"}]'),
      );

      final result = await repository.getQuizByLessonId('lesson-1');

      expect(
        (result as DataFailure<Quiz>).failure,
        isA<ParsingFailure>(),
      );
    });

    test('returns ParsingFailure when a lesson has duplicate quizzes',
        () async {
      final repository = AssetQuizRepository(
        _clientReturning('[$_quizJson,$_quizJson]'),
      );

      final result = await repository.getQuizByLessonId('lesson-1');

      expect(
        (result as DataFailure<Quiz>).failure,
        isA<ParsingFailure>(),
      );
    });
  });
}

ApiClient _clientReturning(String response) {
  return ApiClient(
    assetLoader: (_) async => response,
    latency: Duration.zero,
  );
}

const _quizzesJson = '[$_quizJson]';

const _quizJson = '''
  {
    "id": "quiz-1",
    "lessonId": "lesson-1",
    "questions": [
      {
        "id": "question-1",
        "question": "What is Flutter built from?",
        "options": ["Widgets", "Activities"],
        "correctIndex": 0
      }
    ]
  }
''';
