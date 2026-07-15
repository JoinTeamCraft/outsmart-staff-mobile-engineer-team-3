import '../../../core/errors/data_result.dart';
import '../models/lesson.dart';

/// Provides lesson data without exposing its underlying source.
abstract interface class LessonRepository {
  Future<DataResult<List<Lesson>>> getLessons();
}
