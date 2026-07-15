import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_state.dart';
part 'quiz_cubit.freezed.dart';

/// {@template quiz_cubit}
/// The manager for the quiz state and lifecycle.
/// {@endtemplate}
class QuizCubit extends Cubit<QuizState> {
  /// {@macro quiz_cubit}
  ///
  /// Creates an instance of [QuizCubit].
  QuizCubit() : super(const QuizState.initial());
}
