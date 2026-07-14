import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaklearn/core/di/service_locator.dart';
import 'package:streaklearn/features/lessons/presentation/bloc/lesson/lesson_cubit.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen._({super.key});

  /// Creates an instance of [LessonScreen] with all required dependencies.
  static Widget create({Key? key}) {
    return BlocProvider(
      create: (context) => locator<LessonCubit>(),
      child: LessonScreen._(key: key),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Need make a decision about the localization of the app.
      appBar: AppBar(title: const Text('Lessons'), actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: context.read<LessonCubit>().fetch,
        ),
      ]),
      body: BlocBuilder<LessonCubit, LessonState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: () => const Center(child: Text('Data was loaded')),
          error: (message) => Center(child: Text('Error: $message')),
        ),
      ),
    );
  }
}
