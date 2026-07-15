import '../../../core/errors/data_result.dart';
import '../models/quiz.dart';

/// Provides lesson-specific quizzes without exposing their data source.
abstract interface class QuizRepository {
  Future<DataResult<Quiz>> getQuizByLessonId(String lessonId);
}
