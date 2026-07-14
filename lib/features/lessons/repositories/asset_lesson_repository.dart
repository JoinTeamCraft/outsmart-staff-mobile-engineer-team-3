import 'dart:convert';

import '../../../core/errors/data_result.dart';
import '../../../core/errors/failure_mapper.dart';
import '../../../core/network/api_client.dart';
import '../models/lesson.dart';
import 'lesson_repository.dart';

final class AssetLessonRepository implements LessonRepository {
  const AssetLessonRepository(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<DataResult<List<Lesson>>> getLessons() async {
    try {
      final decoded = jsonDecode(await _apiClient.getLessonsRaw());
      if (decoded is! List<dynamic>) {
        throw const FormatException('Expected a list of lessons.');
      }

      final lessons = decoded.map((item) {
        if (item is! Map<String, dynamic>) {
          throw const FormatException(
            'Expected each lesson to be a JSON object.',
          );
        }
        return Lesson.fromJson(item);
      });

      return DataSuccess(List.unmodifiable(lessons));
    } catch (error, stackTrace) {
      return DataFailure(mapDataException(error, stackTrace));
    }
  }
}
