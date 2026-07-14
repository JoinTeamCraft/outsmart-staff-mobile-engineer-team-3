import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:streaklearn/core/constants/app_paddings.dart';
import 'package:streaklearn/features/lessons/domain/entity/lesson.dart';
import 'package:streaklearn/features/lessons/presentation/style/comic_style.dart';

/// A lesson panel in the feed, drawn like a Marvel-ish comic cell: thick ink
/// outline, hard offset shadow, halftone thumbnail and a bold action tag.
class LessonCard extends StatelessWidget {
  const LessonCard({required this.lesson, super.key});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final frame = ComicStyle.frame(isDark);
    final accent = ComicStyle.topicColor(lesson.topic);

    return Container(
      margin: const EdgeInsets.all(AppPaddings.small),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(ComicStyle.panelRadius),
        border: Border.all(color: frame, width: ComicStyle.panelBorder),
        boxShadow: [BoxShadow(color: frame, offset: ComicStyle.shadowOffset)],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(ComicStyle.panelRadius),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(ComicStyle.panelPadding),
            child: Row(
              children: [
                _Thumbnail(url: lesson.thumbnail, frame: frame, accent: accent),
                const SizedBox(width: AppPaddings.medium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TopicTag(
                          topic: lesson.topic, accent: accent, frame: frame),
                      const SizedBox(height: AppPaddings.small),
                      Text(
                        lesson.title.toUpperCase(),
                        style: ComicStyle.getCardTitleStyle(theme.textTheme),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppPaddings.small),
                Icon(Icons.chevron_right_rounded, color: frame),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.url,
    required this.frame,
    required this.accent,
  });

  final String url;
  final Color frame;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ComicStyle.thumbSize,
      height: ComicStyle.thumbSize,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(ComicStyle.thumbRadius),
        border: Border.all(color: frame, width: ComicStyle.panelBorder),
      ),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          accent.withValues(alpha: ComicStyle.duotoneOpacity),
          BlendMode.overlay,
        ),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(seconds: 1),
          imageBuilder: (context, imageProvider) => Image(
            image: imageProvider,
            fit: BoxFit.cover,
            gaplessPlayback: true,
          ),
          progressIndicatorBuilder: (context, url, progress) =>
              _Placeholder(accent: accent),
          errorWidget: (context, url, error) => _Placeholder(accent: accent),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: accent,
      child:
          Icon(Icons.auto_stories_rounded, color: ComicStyle.onColor(accent)),
    );
  }
}

class _TopicTag extends StatelessWidget {
  const _TopicTag({
    required this.topic,
    required this.accent,
    required this.frame,
  });

  final String topic;
  final Color accent;
  final Color frame;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: ComicStyle.tagTilt,
      child: Container(
        padding: const EdgeInsets.all(AppPaddings.small),
        decoration: BoxDecoration(
          color: accent,
          borderRadius: BorderRadius.circular(ComicStyle.tagRadius),
          border: Border.all(color: frame, width: ComicStyle.tagBorder),
        ),
        child: Text(
          topic.toUpperCase(),
          style: ComicStyle.getCardTagStyle(
            Theme.of(context).textTheme,
            accent: accent,
          ),
        ),
      ),
    );
  }
}

/// Small dot grid that mimics comic-print halftone shading.
class _HalftonePainter extends CustomPainter {
  const _HalftonePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const gap = ComicStyle.thumbDotGap;
    for (double y = 2; y < size.height; y += gap) {
      for (double x = 2; x < size.width; x += gap) {
        canvas.drawCircle(Offset(x, y), ComicStyle.thumbDotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_HalftonePainter oldDelegate) =>
      oldDelegate.color != color;
}
