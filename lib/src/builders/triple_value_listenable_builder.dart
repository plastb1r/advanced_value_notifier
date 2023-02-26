import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Builder for UI part presentation using two [ValueListenable].
class TripleValueListenableBuilder<F, S, T> extends StatefulWidget {
  final ValueListenable<F> firstListenable;

  final ValueListenable<S> secondListenable;

  final ValueListenable<T> thirdListenable;

  final Widget Function(BuildContext context, F firstValue, S secondValue, T thirdValue) builder;

  const TripleValueListenableBuilder({
    super.key,
    required this.firstListenable,
    required this.secondListenable,
    required this.thirdListenable,
    required this.builder,
  });

  @override
  State<TripleValueListenableBuilder<F, S, T>> createState() => _TripleValueListenableBuilderState<F, S, T>();
}

class _TripleValueListenableBuilderState<F, S, T> extends State<TripleValueListenableBuilder<F, S, T>> {
  @override
  void initState() {
    super.initState();

    widget.firstListenable.addListener(_update);
    widget.secondListenable.addListener(_update);
    widget.thirdListenable.addListener(_update);
  }

  @override
  void didUpdateWidget(TripleValueListenableBuilder<F, S, T> oldWidget) {
    if (oldWidget.firstListenable != widget.firstListenable) {
      oldWidget.firstListenable.removeListener(_update);
      widget.firstListenable.addListener(_update);
    }
    if (oldWidget.secondListenable != widget.secondListenable) {
      oldWidget.secondListenable.removeListener(_update);
      widget.secondListenable.addListener(_update);
    }
    if (oldWidget.thirdListenable != widget.thirdListenable) {
      oldWidget.thirdListenable.removeListener(_update);
      widget.thirdListenable.addListener(_update);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.firstListenable.removeListener(_update);
    widget.secondListenable.removeListener(_update);
    widget.thirdListenable.removeListener(_update);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        widget.firstListenable.value,
        widget.secondListenable.value,
        widget.thirdListenable.value,
      );

  void _update() => setState(() {});
}
