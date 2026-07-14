import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:streaklearn/features/lessons/domain/entity/lesson.dart';

part 'lesson_state.dart';
part 'lesson_cubit.freezed.dart';

/// {@template lesson_cubit}
/// Manages the list of lessons lifecycle.
/// {@endtemplate}
class LessonCubit extends Cubit<LessonState> {
  /// {@macro lesson_cubit}
  LessonCubit() : super(const LessonState.initial());

  /// Fetches the list of lessons and exposes them via [LessonState.loaded].
  Future<void> fetch() async {
    emit(const LessonState.loading());
    // TODO: Replace with real data (repository / ApiClient) once available.
    await Future.delayed(const Duration(milliseconds: 600));
    emit(LessonState.loaded(_mockLessons));
  }
}

// TODO: Mock data — remove once real lesson data is wired in.
List<Lesson> get _mockLessons {
  const lessons = [
    Lesson(
      id: 'lesson-1',
      title: 'Flutter Basics & Widgets',
      topic: 'Fundamentals',
      thumbnail:
          'https://images.unsplash.com/photo-1618401471353-b98aedd07871?w=200',
      content: 'In Flutter, everything is a widget.',
    ),
    Lesson(
      id: 'lesson-2',
      title: 'Asynchronous Programming in Dart',
      topic: 'Dart',
      thumbnail:
          'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=200',
      content: 'Dart uses Futures and Streams to handle asynchronous work.',
    ),
    Lesson(
      id: 'lesson-3',
      title: 'State Management with Providers',
      topic: 'State Management',
      thumbnail:
          'https://images.unsplash.com/photo-1507238691740-187a5b1d37b8?w=200',
      content: 'State management is the practice of managing changes to data.',
    ),
  ];

  return List.generate(30, (i) => lessons[i % lessons.length]);
}
