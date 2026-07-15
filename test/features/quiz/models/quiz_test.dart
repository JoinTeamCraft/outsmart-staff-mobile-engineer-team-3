import 'package:flutter_test/flutter_test.dart';
import 'package:streaklearn/features/quiz/models/question.dart';
import 'package:streaklearn/features/quiz/models/quiz.dart';

void main() {
  group('Question.fromJson', () {
    test('creates a question and exposes immutable options', () {
      final question = Question.fromJson({
        'id': 'question-1',
        'question': 'What is a Flutter UI made from?',
        'options': ['Widgets', 'Activities'],
        'correctIndex': 0,
      });

      expect(question.prompt, 'What is a Flutter UI made from?');
      expect(question.options, ['Widgets', 'Activities']);
      expect(
        () => question.options.add('Views'),
        throwsUnsupportedError,
      );
    });

    test('throws FormatException for an invalid correct index', () {
      expect(
        () => Question.fromJson({
          'id': 'question-1',
          'question': 'What is a Flutter UI made from?',
          'options': ['Widgets', 'Activities'],
          'correctIndex': 2,
        }),
        throwsFormatException,
      );
    });
  });

  group('Quiz.fromJson', () {
    test('creates a quiz with typed immutable questions', () {
      final quiz = Quiz.fromJson({
        'lessonId': 'lesson-1',
        'questions': [
          {
            'id': 'question-1',
            'question': 'What is a Flutter UI made from?',
            'options': ['Widgets', 'Activities'],
            'correctIndex': 0,
          },
        ],
      });

      expect(quiz.lessonId, 'lesson-1');
      expect(quiz.questions.single, isA<Question>());
      expect(
        () => quiz.questions.add(
          Question(
            id: 'question-2',
            prompt: 'Another question',
            options: const ['Yes', 'No'],
            correctIndex: 0,
          ),
        ),
        throwsUnsupportedError,
      );
    });

    test('throws FormatException for a malformed question', () {
      expect(
        () => Quiz.fromJson({
          'lessonId': 'lesson-1',
          'questions': ['not-an-object'],
        }),
        throwsFormatException,
      );
    });
  });
}
