import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:streaklearn/core/constants/app_paddings.dart';
import 'package:streaklearn/features/lessons/domain/entity/lesson.dart';

/// A lesson card in the feed: a thumbnail, a colored category tag and a bold
/// title — a simplified take on the reference design.
class LessonCard extends StatelessWidget {
  const LessonCard({required this.lesson, super.key});

  final Lesson lesson;

  // TODO: - need to put it into the shared place.
  /// Radius of the card corners.
  static const double _radius = 20;

  /// Shadow parameters.
  static const double _shadowBlurRadius = 16;
  static final Color _shadowColor = Colors.black.withValues(alpha: 0.4);
  static const Offset _shadowOffset = Offset(0, 6);

  /// Title parameters.
  static const double _titleTextHeight = 1.1;
  static const int _titleMaxLines = 2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppPaddings.small),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: [
          BoxShadow(
            color: _shadowColor,
            blurRadius: _shadowBlurRadius,
            offset: _shadowOffset,
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          // TODO: Route to Lesson Detail/Quiz
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_radius),
            child: Padding(
              padding: const EdgeInsets.all(AppPaddings.medium),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Thumbnail(url: lesson.thumbnail),
                  const SizedBox(width: AppPaddings.medium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Pill(lesson.topic),
                        const SizedBox(height: AppPaddings.small),
                        Text(
                          lesson.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            height: _titleTextHeight,
                          ),
                          maxLines: _titleMaxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.url});

  final String url;

  // TODO: - need to put it into the shared place.
  /// Dimensions of the thumbnail.
  static const double _thumbSize = 64;

  /// Radius of the thumbnail corners.
  static const double _thumbRadius = 12;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_thumbRadius),
      child: SizedBox(
        width: _thumbSize,
        height: _thumbSize,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, url) => const _ImagePlaceholder(),
          errorWidget: (context, url, error) => const _ImagePlaceholder(),
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Icon(Icons.image_outlined, color: scheme.onSurfaceVariant),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.label);

  final String label;

// TODO: - need to put it into the shared place.
  /// Color of the pill background.
  static const Color _backgroundColor = Colors.blue;

  /// Color of the pill text.
  static const Color _textColor = Colors.white;

  /// Radius of the pill corners.
  static const double _borderRadius = 20;

  /// Font size of the pill text.
  static const double _fontSize = 12;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPaddings.small,
        vertical: AppPaddings.tiny,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _textColor,
          fontSize: _fontSize,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
