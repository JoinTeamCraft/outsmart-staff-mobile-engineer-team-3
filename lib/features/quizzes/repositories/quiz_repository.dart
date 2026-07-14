import '../../../core/errors/data_result.dart';
import '../models/quiz.dart';

abstract interface class QuizRepository {
  Future<DataResult<Quiz>> getQuizByLessonId(String lessonId);
}
