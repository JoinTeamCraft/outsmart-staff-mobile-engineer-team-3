import 'package:get_it/get_it.dart';
import 'package:streaklearn/core/network/api_client.dart';
import 'package:streaklearn/features/lessons/presentation/bloc/lesson/lesson_cubit.dart';
import 'package:streaklearn/features/lessons/repositories/asset_lesson_repository.dart';
import 'package:streaklearn/features/lessons/repositories/lesson_repository.dart';
import 'package:streaklearn/features/quiz/presentation/bloc/quiz/quiz_cubit.dart';
import 'package:streaklearn/features/quiz/repositories/asset_quiz_repository.dart';
import 'package:streaklearn/features/quiz/repositories/quiz_repository.dart';
import 'package:streaklearn/features/streaks/presentation/bloc/streak/streak_cubit.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
  locator.registerLazySingleton<LessonRepository>(
    () => AssetLessonRepository(locator<ApiClient>()),
  );
  locator.registerLazySingleton<QuizRepository>(
    () => AssetQuizRepository(locator<ApiClient>()),
  );

  locator.registerFactory<LessonCubit>(
    () => LessonCubit(locator<LessonRepository>()),
  );
  locator.registerFactory<QuizCubit>(
    () => QuizCubit(locator<QuizRepository>()),
  );
  locator.registerFactory<StreakCubit>(() => StreakCubit());
}
