import 'package:flutter/material.dart';
import 'package:my_value_listenable_builder/my_change_notifier.dart';

class MyValueListenableBuilder<T> extends StatefulWidget {
  const MyValueListenableBuilder({
    super.key,
    required this.valueListenable,
    required this.builder,
    this.child,
    this.rebuildWhen,
    this.onRebuild,
  });

  final MyValueListenable<T> valueListenable;

  final Widget Function(BuildContext context, T value, Widget? child) builder;

  final Widget? child;

  final bool Function(T oldValue, T newValue)? rebuildWhen;

  final void Function()? onRebuild;

  @override
  State<MyValueListenableBuilder<T>> createState() =>
      _MyValueListenableBuilderState<T>();
}

class _MyValueListenableBuilderState<T>
    extends State<MyValueListenableBuilder<T>> {
  late T value;

  void _valueChanged() {
    if (widget.rebuildWhen?.call(value, widget.valueListenable.value) ?? true) {
      setState(() {
        widget.onRebuild?.call();
        value = widget.valueListenable.value;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    value = widget.valueListenable.value;
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, widget.child);
  }
}
