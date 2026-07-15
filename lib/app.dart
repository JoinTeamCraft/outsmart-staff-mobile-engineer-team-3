import 'package:flutter/material.dart';
import 'package:streaklearn/features/lessons/presentation/screen/lesson_screen.dart';
import 'core/theme/app_theme.dart';

class StreakLearnApp extends StatelessWidget {
  const StreakLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Decide on the app routing pattern.
    return MaterialApp(
      title: 'StreakLearn',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/lessons',
      routes: {
        '/lessons': (context) => LessonScreen.create(),
      },
    );
  }
}
