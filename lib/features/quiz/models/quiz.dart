import 'question.dart';

/// Immutable collection of questions associated with a lesson.
class Quiz {
  Quiz({
    required this.lessonId,
    required List<Question> questions,
  }) : questions = List.unmodifiable(questions);

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final questions = json['questions'];
    if (questions is! List<dynamic>) {
      throw const FormatException('Expected a list for "questions".');
    }

    return Quiz(
      lessonId: _requiredString(json, 'lessonId'),
      questions: questions.map((question) {
        if (question is! Map<String, dynamic>) {
          throw const FormatException(
            'Expected each question to be a JSON object.',
          );
        }
        return Question.fromJson(question);
      }).toList(),
    );
  }

  final String lessonId;
  final List<Question> questions;
}

String _requiredString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! String || value.trim().isEmpty) {
    throw FormatException('Expected a non-empty string for "$key".');
  }
  return value;
}
