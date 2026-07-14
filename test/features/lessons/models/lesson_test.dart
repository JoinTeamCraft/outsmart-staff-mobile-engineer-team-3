import 'package:flutter_test/flutter_test.dart';
import 'package:streaklearn/features/lessons/models/lesson.dart';

void main() {
  group('Lesson.fromJson', () {
    test('creates a lesson from valid JSON', () {
      final lesson = Lesson.fromJson({
        'id': 'lesson-1',
        'title': 'Flutter Basics',
        'topic': 'Fundamentals',
        'thumbnail': 'https://example.com/flutter.png',
        'content': 'Everything is a widget.',
      });

      expect(lesson.id, 'lesson-1');
      expect(lesson.title, 'Flutter Basics');
      expect(lesson.topic, 'Fundamentals');
      expect(lesson.thumbnail, 'https://example.com/flutter.png');
      expect(lesson.content, 'Everything is a widget.');
    });

    test('throws FormatException when a required field is missing', () {
      expect(
        () => Lesson.fromJson({
          'id': 'lesson-1',
          'topic': 'Fundamentals',
          'thumbnail': 'https://example.com/flutter.png',
          'content': 'Everything is a widget.',
        }),
        throwsFormatException,
      );
    });

    test('throws FormatException when a required string is empty', () {
      expect(
        () => Lesson.fromJson({
          'id': 'lesson-1',
          'title': ' ',
          'topic': 'Fundamentals',
          'thumbnail': 'https://example.com/flutter.png',
          'content': 'Everything is a widget.',
        }),
        throwsFormatException,
      );
    });
  });
}
