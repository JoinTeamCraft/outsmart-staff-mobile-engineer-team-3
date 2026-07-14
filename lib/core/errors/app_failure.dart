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

final class NetworkFailure extends AppFailure {
  const NetworkFailure(
    super.message, {
    super.cause,
    super.stackTrace,
  });
}

final class AssetFailure extends AppFailure {
  const AssetFailure(
    super.message, {
    super.cause,
    super.stackTrace,
  });
}

final class ParsingFailure extends AppFailure {
  const ParsingFailure(
    super.message, {
    super.cause,
    super.stackTrace,
  });
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure(
    super.message, {
    super.cause,
    super.stackTrace,
  });
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure(
    super.message, {
    super.cause,
    super.stackTrace,
  });
}
