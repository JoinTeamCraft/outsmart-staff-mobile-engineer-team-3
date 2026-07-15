import 'package:get_it/get_it.dart';

import '../../features/lessons/presentation/bloc/lesson/lesson_cubit.dart';
import '../../features/quiz/presentation/bloc/quiz/quiz_cubit.dart';
import '../../features/streaks/presentation/bloc/streak/streak_cubit.dart';
import '../network/api_client.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiClient>(() => ApiClient());

  locator.registerFactory<LessonCubit>(() => LessonCubit());
  locator.registerFactory<QuizCubit>(() => QuizCubit());
  locator.registerFactory<StreakCubit>(() => StreakCubit());
}
