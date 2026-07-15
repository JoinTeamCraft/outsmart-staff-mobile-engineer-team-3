/// A safe, UI-facing description of an error from the data layer.
sealed class AppFailure {
  const AppFailure(
    this.message, {
    this.cause,
    this.stackTrace,
  });

  final String message;
  final Object? cause;
  final StackTrace? stackTrace;
}

/// Indicates that a request failed before a response could be obtained.
final class NetworkFailure extends AppFailure {
  const NetworkFailure(
    super.message, {
    super.cause,
    super.stackTrace,
  });
}

/// Indicates that bundled application data could not be loaded.
final class AssetFailure extends AppFailure {
  const AssetFailure(
    super.message, {
    super.cause,
    super.stackTrace,
  });
}

/// Indicates that loaded data did not match the expected contract.
final class ParsingFailure extends AppFailure {
  const ParsingFailure(
    super.message, {
    super.cause,
    super.stackTrace,
  });
}

/// Indicates that the requested data does not exist.
final class NotFoundFailure extends AppFailure {
  const NotFoundFailure(
    super.message, {
    super.cause,
    super.stackTrace,
  });
}

/// Indicates an unexpected data-layer error that could not be classified.
final class UnknownFailure extends AppFailure {
  const UnknownFailure(
    super.message, {
    super.cause,
    super.stackTrace,
  });
}
