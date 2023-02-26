import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Builder for UI part presentation using two [ValueListenable].
class DoubleValueListenableBuilder<F, S> extends StatefulWidget {
  final ValueListenable<F> firstValue;

  final ValueListenable<S> secondValue;

  final Widget Function(BuildContext context, F firstValue, S secondValue) builder;

  const DoubleValueListenableBuilder({
    super.key,
    required this.firstValue,
    required this.secondValue,
    required this.builder,
  });

  @override
  State<DoubleValueListenableBuilder<F, S>> createState() => _DoubleValueListenableBuilderState<F, S>();
}

class _DoubleValueListenableBuilderState<F, S> extends State<DoubleValueListenableBuilder<F, S>> {
  @override
  void initState() {
    super.initState();

    widget.firstValue.addListener(_update);
    widget.secondValue.addListener(_update);
  }

  @override
  void didUpdateWidget(DoubleValueListenableBuilder<F, S> oldWidget) {
    if (oldWidget.firstValue != widget.firstValue) {
      oldWidget.firstValue.removeListener(_update);
      widget.firstValue.addListener(_update);
    }
    if (oldWidget.secondValue != widget.secondValue) {
      oldWidget.secondValue.removeListener(_update);
      widget.secondValue.addListener(_update);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.firstValue.removeListener(_update);
    widget.secondValue.removeListener(_update);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        widget.firstValue.value,
        widget.secondValue.value,
      );

  void _update() => setState(() {});
}
