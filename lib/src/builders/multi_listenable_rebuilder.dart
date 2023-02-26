import 'package:flutter/material.dart';

/// Widget which rebuild when anyone of the listeners
/// in the [listenableList] changed.
class MultiListenableRebuilder extends StatefulWidget {
  final Iterable<Listenable> listenableList;

  final Widget Function(BuildContext context) builder;

  const MultiListenableRebuilder({
    super.key,
    required this.listenableList,
    required this.builder,
  });

  @override
  MultiListenableRebuilderState createState() => MultiListenableRebuilderState();
}

class MultiListenableRebuilderState extends State<MultiListenableRebuilder> {
  @override
  void initState() {
    super.initState();

    for (final listener in widget.listenableList) {
      listener.addListener(_update);
    }
  }

  @override
  void didUpdateWidget(covariant MultiListenableRebuilder oldWidget) {
    final newList = widget.listenableList;
    final oldList = oldWidget.listenableList;
    if (!identical(newList, oldList)) {
      for (final listener in oldList) {
        if (!newList.contains(listener)) {
          listener.removeListener(_update);
        }
      }

      for (final listener in newList) {
        if (!oldList.contains(listener)) {
          listener.addListener(_update);
        }
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    for (final listener in widget.listenableList) {
      listener.removeListener(_update);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);

  void _update() => setState(() {});
}
