import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaklearn/core/constants/app_paddings.dart';
import 'package:streaklearn/core/di/service_locator.dart';
import 'package:streaklearn/features/lessons/presentation/bloc/lesson/lesson_cubit.dart';
import 'package:streaklearn/features/lessons/presentation/widget/lesson_card.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen._({super.key});

  /// Creates an instance of [LessonScreen] with all required dependencies.
  static Widget create({Key? key}) {
    return BlocProvider(
      create: (context) => locator<LessonCubit>()..fetch(),
      child: LessonScreen._(key: key),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Decide on the app localization strategy.
      appBar: AppBar(title: const Text('Lessons'), actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => context.read<LessonCubit>().fetch(),
        ),
      ]),
      body: BlocBuilder<LessonCubit, LessonState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (lessons) => ListView.builder(
            padding: const EdgeInsets.all(AppPaddings.medium),
            itemCount: lessons.length,
            itemBuilder: (context, index) => LessonCard(lesson: lessons[index]),
          ),
          error: (message) => Center(child: Text('Error: $message')),
        ),
      ),
    );
  }
}
