import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson.freezed.dart';

/// A single lesson rendered in the feed.
@freezed
abstract class Lesson with _$Lesson {
  const factory Lesson({
    required String id,
    required String title,
    required String topic,
    required String thumbnail,
    required String content,
  }) = _Lesson;
}
