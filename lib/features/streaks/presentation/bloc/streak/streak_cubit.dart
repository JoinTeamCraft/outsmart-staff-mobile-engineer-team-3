import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_state.dart';
part 'streak_cubit.freezed.dart';

/// {@template streak_cubit}
/// A manager for user streak state and lifecycle.
/// {@endtemplate}
class StreakCubit extends Cubit<StreakState> {
  /// {@macro streak_cubit}
  ///
  /// Creates an instance of [StreakCubit].
  StreakCubit() : super(const StreakState.initial());
}
