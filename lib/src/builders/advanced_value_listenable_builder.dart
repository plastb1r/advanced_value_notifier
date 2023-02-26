import 'package:advanced_value_notifier/src/advanced_value.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef LoadingBuilder<T> = Widget Function(
  BuildContext context,
  T? data,
);

typedef ContentBuilder<T> = Widget Function(
  BuildContext context,
  T data,
);

typedef ErrorBuilder<T> = Widget Function(
  BuildContext context,
  Exception? e,
  T? data,
);

class AdvancedListenableBuilder<T> extends StatelessWidget {
  final ValueListenable<AdvancedValue<T>> advancedValueListenable;

  final ContentBuilder<T> builder;

  final LoadingBuilder<T> loadingBuilder;

  final ErrorBuilder<T> errorBuilder;

  const AdvancedListenableBuilder({
    super.key,
    required this.advancedValueListenable,
    required this.builder,
    required this.loadingBuilder,
    required this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AdvancedValue<T>>(
      valueListenable: advancedValueListenable,
      builder: (context, value, _) {
        if (value is AdvancedValueError<T>) {
          return errorBuilder(context, value.e, value.data);
        }

        if (value is AdvancedValueLoading<T>) {
          return loadingBuilder(context, value.data);
        }

        if (value is AdvancedValueContent<T>) {
          return builder(context, value.data);
        }

        throw StateError('Wrong value type of $value');
      },
    );
  }
}
