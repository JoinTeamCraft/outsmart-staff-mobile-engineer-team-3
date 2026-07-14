import 'package:flutter/material.dart';
import 'package:streaklearn/features/lessons/presentation/screen/lesson_screen.dart';
import 'core/theme/app_theme.dart';

class StreakLearnApp extends StatelessWidget {
  const StreakLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: - Need make a desition about the routing pattern in the app.
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
