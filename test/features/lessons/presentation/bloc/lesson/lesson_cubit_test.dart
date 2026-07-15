import 'package:flutter_test/flutter_test.dart';
import 'package:streaklearn/features/lessons/presentation/bloc/lesson/lesson_cubit.dart';

/// Short name of a [LessonState] variant, for readable assertions.
String _name(LessonState state) => state.when(
      initial: () => 'initial',
      loading: () => 'loading',
      loaded: (_) => 'loaded',
      error: (_) => 'error',
    );

void main() {
  group('LessonCubit', () {
    test('starts in the initial state', () {
      final cubit = LessonCubit();
      addTearDown(cubit.close);

      expect(_name(cubit.state), 'initial');
    });

    test('fetch() emits loading then loaded, in order', () async {
      final cubit = LessonCubit();
      addTearDown(cubit.close);

      final expectation = expectLater(
        cubit.stream,
        emitsInOrder([
          predicate<LessonState>((s) => _name(s) == 'loading'),
          predicate<LessonState>((s) => _name(s) == 'loaded'),
        ]),
      );

      await cubit.fetch();
      await expectation;
    });

    test('fetch() ends in a loaded state with a non-empty lesson list',
        () async {
      final cubit = LessonCubit();
      addTearDown(cubit.close);

      await cubit.fetch();

      final lessons = cubit.state.whenOrNull(loaded: (lessons) => lessons);
      expect(lessons, isNotNull);
      expect(lessons, isNotEmpty);
    });

    test('fetch() can be re-run and still resolves to loaded', () async {
      final cubit = LessonCubit();
      addTearDown(cubit.close);

      await cubit.fetch();
      await cubit.fetch();

      expect(_name(cubit.state), 'loaded');
    });
  });
}
