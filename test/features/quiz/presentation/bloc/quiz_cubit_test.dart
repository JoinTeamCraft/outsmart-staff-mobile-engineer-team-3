import 'package:flutter_test/flutter_test.dart';
import 'package:streaklearn/core/errors/app_failure.dart';
import 'package:streaklearn/core/errors/data_result.dart';
import 'package:streaklearn/features/quiz/models/question.dart';
import 'package:streaklearn/features/quiz/models/quiz.dart';
import 'package:streaklearn/features/quiz/presentation/bloc/quiz/quiz_cubit.dart';
import 'package:streaklearn/features/quiz/repositories/quiz_repository.dart';

void main() {
  final quiz = Quiz(
    lessonId: 'lesson-1',
    questions: [
      Question(
        id: 'question-1',
        prompt: 'What is Flutter built from?',
        options: const ['Widgets', 'Activities'],
        correctIndex: 0,
      ),
    ],
  );

  test('emits loading and loaded when repository succeeds', () async {
    final cubit = QuizCubit(
      _FakeQuizRepository(DataSuccess(quiz)),
    );
    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        const QuizState.loading(),
        QuizState.loaded(quiz),
      ]),
    );

    await cubit.fetchByLessonId('lesson-1');
    await expectation;
    await cubit.close();
  });

  test('emits loading and error when repository fails', () async {
    final cubit = QuizCubit(
      const _FakeQuizRepository(
        DataFailure(NotFoundFailure('Quiz not found.')),
      ),
    );
    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        const QuizState.loading(),
        const QuizState.error(message: 'Quiz not found.'),
      ]),
    );

    await cubit.fetchByLessonId('lesson-404');
    await expectation;
    await cubit.close();
  });
}

final class _FakeQuizRepository implements QuizRepository {
  const _FakeQuizRepository(this.result);

  final DataResult<Quiz> result;

  @override
  Future<DataResult<Quiz>> getQuizByLessonId(String lessonId) async => result;
}
