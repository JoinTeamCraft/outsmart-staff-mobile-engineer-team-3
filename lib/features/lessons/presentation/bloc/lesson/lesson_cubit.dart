import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_state.dart';
part 'lesson_cubit.freezed.dart';

/// {@template lesson_cubit}
/// Manages the list of lessons lifecycle.
/// {@endtemplate}
class LessonCubit extends Cubit<LessonState> {
  /// {@macro lesson_cubit}
  LessonCubit() : super(const LessonState.initial()) {
    fetch();
  }

  /// Fetches the list of lessons.
  Future<void> fetch() async {
    emit(const LessonState.loading());
    // TODO: Remove this after mock server is ready.
    await Future.delayed(const Duration(seconds: 1));

    emit(Random().nextBool()
        ? const LessonState.loaded()
        : const LessonState.error('Something went wrong'));
  }
}
