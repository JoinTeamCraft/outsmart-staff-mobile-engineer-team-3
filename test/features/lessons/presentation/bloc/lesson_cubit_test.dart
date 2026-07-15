import 'package:flutter_test/flutter_test.dart';
import 'package:streaklearn/core/errors/app_failure.dart';
import 'package:streaklearn/core/errors/data_result.dart';
import 'package:streaklearn/features/lessons/models/lesson.dart';
import 'package:streaklearn/features/lessons/presentation/bloc/lesson/lesson_cubit.dart';
import 'package:streaklearn/features/lessons/repositories/lesson_repository.dart';

void main() {
  const lesson = Lesson(
    id: 'lesson-1',
    title: 'Flutter Basics',
    topic: 'Fundamentals',
    thumbnail: 'https://example.com/flutter.png',
    content: 'Everything is a widget.',
  );

  test('emits loading and loaded when repository succeeds', () async {
    final cubit = LessonCubit(
      const _FakeLessonRepository(DataSuccess([lesson])),
    );
    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        const LessonState.loading(),
        const LessonState.loaded([lesson]),
      ]),
    );

    await cubit.fetch();
    await expectation;
    await cubit.close();
  });

  test('emits loading and error when repository fails', () async {
    final cubit = LessonCubit(
      const _FakeLessonRepository(
        DataFailure(NetworkFailure('Unable to load lessons.')),
      ),
    );
    final expectation = expectLater(
      cubit.stream,
      emitsInOrder([
        const LessonState.loading(),
        const LessonState.error('Unable to load lessons.'),
      ]),
    );

    await cubit.fetch();
    await expectation;
    await cubit.close();
  });
}

final class _FakeLessonRepository implements LessonRepository {
  const _FakeLessonRepository(this.result);

  final DataResult<List<Lesson>> result;

  @override
  Future<DataResult<List<Lesson>>> getLessons() async => result;
}
