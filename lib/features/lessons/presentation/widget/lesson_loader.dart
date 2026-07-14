import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:streaklearn/features/lessons/presentation/style/comic_style.dart';

/// A playful loading indicator drawn with a [CustomPainter]: three chunky,
/// outlined dots bouncing in sequence, matching the cartoon feed style.
class LessonLoader extends StatefulWidget {
  const LessonLoader({super.key, this.size = 64});

  /// Height of the loader in logical pixels (width scales from it).
  final double size;

  @override
  State<LessonLoader> createState() => _LessonLoaderState();
}

class _LessonLoaderState extends State<LessonLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: ComicStyle.loaderDuration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final frame = ComicStyle.frame(isDark);

    return SizedBox(
      width: widget.size * 2.4,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          painter:
              _BouncingDotsPainter(progress: _controller.value, frame: frame),
        ),
      ),
    );
  }
}

class _BouncingDotsPainter extends CustomPainter {
  _BouncingDotsPainter({required this.progress, required this.frame});

  final double progress;
  final Color frame;

  static const _colors = [ComicStyle.red, ComicStyle.blue, ComicStyle.yellow];

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.height * 0.15;
    final amplitude = size.height * 0.32;
    final baseY = size.height / 2 + amplitude / 2;
    final spacing = size.width / (_colors.length + 1);

    final border = Paint()
      ..color = frame
      ..style = PaintingStyle.stroke
      ..strokeWidth = ComicStyle.panelBorder;

    for (var i = 0; i < _colors.length; i++) {
      final phase = (progress + i * 0.18) % 1.0;
      final lift = (math.sin(phase * 2 * math.pi) + 1) / 2; // 0..1
      final center = Offset(spacing * (i + 1), baseY - amplitude * lift);

      canvas.drawCircle(center, radius, Paint()..color = _colors[i]);
      canvas.drawCircle(center, radius, border);
    }
  }

  @override
  bool shouldRepaint(_BouncingDotsPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.frame != frame;
}
