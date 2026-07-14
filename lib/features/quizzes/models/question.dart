class Question {
  Question({
    required this.id,
    required this.prompt,
    required List<String> options,
    required this.correctIndex,
  }) : options = List.unmodifiable(options) {
    if (this.options.isEmpty) {
      throw ArgumentError.value(options, 'options', 'Must not be empty.');
    }
    if (correctIndex < 0 || correctIndex >= this.options.length) {
      throw RangeError.range(
        correctIndex,
        0,
        this.options.length - 1,
        'correctIndex',
      );
    }
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    final options = json['options'];
    if (options is! List<dynamic> ||
        options.any((option) => option is! String || option.trim().isEmpty)) {
      throw const FormatException(
        'Expected "options" to contain non-empty strings.',
      );
    }

    final correctIndex = json['correctIndex'];
    if (correctIndex is! int) {
      throw const FormatException('Expected an integer for "correctIndex".');
    }

    try {
      return Question(
        id: _requiredString(json, 'id'),
        prompt: _requiredString(json, 'question'),
        options: options.cast<String>(),
        correctIndex: correctIndex,
      );
    } on ArgumentError catch (error) {
      throw FormatException('Invalid question: ${error.message}');
    }
  }

  final String id;
  final String prompt;
  final List<String> options;
  final int correctIndex;
}

String _requiredString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! String || value.trim().isEmpty) {
    throw FormatException('Expected a non-empty string for "$key".');
  }
  return value;
}
