import 'dart:convert';

import '../../../core/errors/app_failure.dart';
import '../../../core/errors/data_result.dart';
import '../../../core/errors/failure_mapper.dart';
import '../../../core/network/api_client.dart';
import '../models/quiz.dart';
import 'quiz_repository.dart';

/// Reads bundled quiz JSON and resolves the quiz for a requested lesson.
final class AssetQuizRepository implements QuizRepository {
  const AssetQuizRepository(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<DataResult<Quiz>> getQuizByLessonId(String lessonId) async {
    try {
      final decoded = jsonDecode(await _apiClient.getQuizzesRaw());
      if (decoded is! List<dynamic>) {
        throw const FormatException('Expected a list of quizzes.');
      }

      final matches = decoded
          .map((item) {
            if (item is! Map<String, dynamic>) {
              throw const FormatException(
                'Expected each quiz to be a JSON object.',
              );
            }
            return Quiz.fromJson(item);
          })
          .where((quiz) => quiz.lessonId == lessonId)
          .toList();

      if (matches.isEmpty) {
        return DataFailure(
          NotFoundFailure('No quiz exists for lesson "$lessonId".'),
        );
      }
      if (matches.length > 1) {
        throw FormatException(
          'Multiple quizzes exist for lesson "$lessonId".',
        );
      }

      return DataSuccess(matches.single);
    } catch (error, stackTrace) {
      return DataFailure(mapDataException(error, stackTrace));
    }
  }
}
