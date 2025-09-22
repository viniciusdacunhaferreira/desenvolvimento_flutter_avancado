sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok<T>._internal;

  const factory Result.error(Exception error) = Error<T>._internal;
}

final class Ok<T> extends Result<T> {
  const Ok._internal(this.value);

  final T value;
}

final class Error<T> extends Result<T> {
  const Error._internal(this.error);

  final Exception error;
}

extension OkResultExtension on Object {
  Result toOkResult() => Result.ok(this);
}

extension ErrorResultExtension on Exception {
  Result toErrorResult() => Result.error(this);
}

extension AsResultExtension<T> on Result<T> {
  Ok<T> get asOk => this as Ok<T>;

  Error<T> get asError => this as Error<T>;
}
