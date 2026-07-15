import 'app_failure.dart';

/// Represents either typed data or a classified failure from a repository.
sealed class DataResult<T> {
  const DataResult();
}

/// A successful repository result containing [data].
final class DataSuccess<T> extends DataResult<T> {
  const DataSuccess(this.data);

  final T data;
}

/// An unsuccessful repository result containing a safe [failure].
final class DataFailure<T> extends DataResult<T> {
  const DataFailure(this.failure);

  final AppFailure failure;
}
