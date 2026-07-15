import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:streaklearn/core/errors/data_result.dart';
import 'package:streaklearn/features/lessons/models/lesson.dart';
import 'package:streaklearn/features/lessons/repositories/lesson_repository.dart';

part 'lesson_state.dart';
part 'lesson_cubit.freezed.dart';

/// {@template lesson_cubit}
/// Manages the list of lessons lifecycle.
/// {@endtemplate}
class LessonCubit extends Cubit<LessonState> {
  /// {@macro lesson_cubit}
  LessonCubit(this._lessonRepository) : super(const LessonState.initial());

  final LessonRepository _lessonRepository;

  /// Fetches the list of lessons.
  Future<void> fetch() async {
    emit(const LessonState.loading());

    final result = await _lessonRepository.getLessons();
    switch (result) {
      case DataSuccess<List<Lesson>>(:final data):
        emit(LessonState.loaded(data));
      case DataFailure<List<Lesson>>(:final failure):
        emit(LessonState.error(failure.message));
    }
  }
}
