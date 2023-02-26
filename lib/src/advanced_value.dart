typedef ValueChanged<T> = void Function(T value);

/// Универсальная модель для отображения базовых состояний UI.
///
/// * Гарантирует ненулевой результат [T].
/// * Явно гарантирует только 3 состояния: loading, content, error.
abstract class AdvancedValue<T> {
  bool get isError => this is AdvancedValueError;

  bool get isLoading => this is AdvancedValueLoading;

  T? get data => null;

  const AdvancedValue._();

  const factory AdvancedValue.content(T data) = AdvancedValueContent<T>;

  const factory AdvancedValue.loading([T? data]) = AdvancedValueLoading<T>;

  const factory AdvancedValue.error([T? data, Exception? e]) =
      AdvancedValueError<T>;
}

class AdvancedValueContent<T> extends AdvancedValue<T> {
  @override
  final T data;

  const AdvancedValueContent(this.data) : super._();
}

class AdvancedValueLoading<T> extends AdvancedValue<T> {
  @override
  final T? data;

  const AdvancedValueLoading([this.data]) : super._();
}

class AdvancedValueError<T> extends AdvancedValue<T> {
  @override
  final T? data;

  final Exception? e;

  const AdvancedValueError([this.data, this.e]) : super._();
}
