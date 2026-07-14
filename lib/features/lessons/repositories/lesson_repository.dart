import '../../../core/errors/data_result.dart';
import '../models/lesson.dart';

abstract interface class LessonRepository {
  Future<DataResult<List<Lesson>>> getLessons();
}
