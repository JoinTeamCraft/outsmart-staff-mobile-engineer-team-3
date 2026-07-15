/// Immutable learning content parsed from the lesson API contract.
class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.topic,
    required this.thumbnail,
    required this.content,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: _requiredString(json, 'id'),
      title: _requiredString(json, 'title'),
      topic: _requiredString(json, 'topic'),
      thumbnail: _requiredString(json, 'thumbnail'),
      content: _requiredString(json, 'content'),
    );
  }

  final String id;
  final String title;
  final String topic;
  final String thumbnail;
  final String content;
}

String _requiredString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! String || value.trim().isEmpty) {
    throw FormatException('Expected a non-empty string for "$key".');
  }
  return value;
}
