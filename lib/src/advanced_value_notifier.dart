import 'package:advanced_value_notifier/src/advanced_value.dart';
import 'package:flutter/foundation.dart';

/// Аn advanced ValueNotifier that is able to handle
/// three main states of AdvancedValue: content, loading, error
class AdvancedValueNotifier<T> extends ValueNotifier<AdvancedValue<T>> {
  /// A shortcut for inner value of AdvancedValue
  T? get innerValue => value.data;

  AdvancedValueNotifier.content(T initialData)
      : super(AdvancedValue<T>.content(initialData));

  AdvancedValueNotifier.loading([T? data])
      : super(AdvancedValue<T>.loading(data));

  AdvancedValueNotifier.error([T? data, Exception? e])
      : super(AdvancedValue<T>.error(data, e));

  void content(T data) {
    value = AdvancedValue<T>.content(data);
  }

  void loading([T? previousData]) {
    value = AdvancedValue<T>.loading(previousData);
  }

  void error([Exception? e, T? data]) {
    value = AdvancedValue<T>.error(data, e);
  }

  /// A shortcut to add listener to the ValueNotifier with the initial call of callback
  void addListenerAndCall(VoidCallback listener) {
    super.addListener(listener);
    listener.call();
  }
}
