import 'package:flutter/foundation.dart';

import '../network/network_exception.dart';
import 'app_failure.dart';

AppFailure mapDataException(Object error, StackTrace stackTrace) {
  if (error is NetworkException) {
    return NetworkFailure(
      error.message,
      cause: error.cause ?? error,
      stackTrace: error.stackTrace ?? stackTrace,
    );
  }
  if (error is FlutterError) {
    return AssetFailure(
      'The bundled data could not be loaded.',
      cause: error,
      stackTrace: stackTrace,
    );
  }
  if (error is FormatException || error is TypeError) {
    return ParsingFailure(
      'The received data has an invalid format.',
      cause: error,
      stackTrace: stackTrace,
    );
  }
  return UnknownFailure(
    'An unexpected data error occurred.',
    cause: error,
    stackTrace: stackTrace,
  );
}
