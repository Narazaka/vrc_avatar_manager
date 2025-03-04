import 'package:flutter/material.dart';

class WrapWithHeight extends StatefulWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final Function(Size?) onSizeChanged;

  const WrapWithHeight(
      {super.key,
      required this.children,
      required this.onSizeChanged,
      this.spacing = 0.0,
      this.runSpacing = 0.0});

  @override
  State<WrapWithHeight> createState() => WrapWithHeightState();
}

class WrapWithHeightState extends State<WrapWithHeight> {
  @override
  void initState() {
    super.initState();
  }

  void _setSize() {
    widget.onSizeChanged(context.size);
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD");
    Future<void>.microtask(_setSize);
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.runSpacing,
      children: widget.children,
    );
  }
}
