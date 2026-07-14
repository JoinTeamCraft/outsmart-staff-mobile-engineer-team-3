import 'app_failure.dart';

sealed class DataResult<T> {
  const DataResult();
}

final class DataSuccess<T> extends DataResult<T> {
  const DataSuccess(this.data);

  final T data;
}

final class DataFailure<T> extends DataResult<T> {
  const DataFailure(this.failure);

  final AppFailure failure;
}
