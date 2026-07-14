import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streaklearn/core/constants/app_paddings.dart';
import 'package:streaklearn/core/di/service_locator.dart';
import 'package:streaklearn/features/lessons/presentation/bloc/lesson/lesson_cubit.dart';
import 'package:streaklearn/features/lessons/presentation/widget/lesson_loader.dart';
import 'package:streaklearn/features/lessons/presentation/style/comic_style.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final frame = ComicStyle.frame(isDark);

    return Scaffold(
      backgroundColor: ComicStyle.background(isDark),
      // TODO: Decide on the app localization strategy.
      appBar: AppBar(
        backgroundColor: ComicStyle.header,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'LESSONS',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => context.read<LessonCubit>().fetch(),
          ),
        ],
        // Thick ink underline to match the panels.
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(ComicStyle.panelBorder),
          child: Container(height: ComicStyle.panelBorder, color: frame),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _HalftoneBackground(
                frame.withValues(alpha: ComicStyle.bgDotOpacity),
              ),
            ),
          ),
          BlocBuilder<LessonCubit, LessonState>(
            builder: (context, state) => state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: LessonLoader()),
              loaded: (lessons) => ListView.builder(
                padding: const EdgeInsets.all(AppPaddings.medium),
                itemCount: lessons.length,
                itemBuilder: (context, index) =>
                    LessonCard(lesson: lessons[index]),
              ),
              error: (message) => Center(child: Text('Error: $message')),
            ),
          ),
        ],
      ),
    );
  }
}

/// Comic-print halftone backdrop for the feed.
class _HalftoneBackground extends CustomPainter {
  const _HalftoneBackground(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const gap = ComicStyle.bgDotGap;
    for (double y = 12; y < size.height; y += gap) {
      for (double x = 12; x < size.width; x += gap) {
        canvas.drawCircle(Offset(x, y), ComicStyle.bgDotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_HalftoneBackground oldDelegate) =>
      oldDelegate.color != color;
}
