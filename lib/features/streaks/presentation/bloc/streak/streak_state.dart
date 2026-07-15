part of 'streak_cubit.dart';

/// Represents the possible states of the [StreakCubit].
@freezed
class StreakState with _$StreakState {
  /// Initial state when the streak counter is first initialized.
  const factory StreakState.initial() = _Initial;

  /// State indicating that the streak data is currently being fetched or synced.
  const factory StreakState.loading() = _Loading;

  /// State when the streak data is successfully loaded.
  // TODO: Add the Streak entity.
  const factory StreakState.loaded() = _Loaded;

  /// State when an error occurs during streak operations.
  ///
  /// The [message] provides details about the failure.
  const factory StreakState.error({required String message}) = _Error;
}
