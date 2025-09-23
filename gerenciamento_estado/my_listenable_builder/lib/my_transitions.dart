import 'package:flutter/material.dart';
import 'package:my_listenable_builder/my_change_notifier.dart';

abstract class MyAnimatedWidget extends StatefulWidget {
  const MyAnimatedWidget({super.key, required this.listenable});

  final MyListenable listenable;

  @override
  State<MyAnimatedWidget> createState() => _MyAnimatedWidgetState();

  @protected
  Widget build(BuildContext context);
}

class _MyAnimatedWidgetState extends State<MyAnimatedWidget> {
  void _handleChange() {
    if (!mounted) return;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    widget.listenable.addListener(_handleChange);
  }

  @override
  void dispose() {
    widget.listenable.removeListener(_handleChange);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context);
}

class MyListenableBuilder extends MyAnimatedWidget {
  const MyListenableBuilder({
    super.key,
    required super.listenable,
    required this.builder,
    this.child,
  });

  final Widget Function(BuildContext content, Widget? child) builder;

  final Widget? child;

  @override
  Widget build(BuildContext context) => builder(context, child);
}
