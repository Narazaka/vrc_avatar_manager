import 'package:flutter/material.dart';

final _defaultSelectedStyle = IconButton.styleFrom(
  backgroundColor: Colors.green,
  foregroundColor: Colors.white,
);

class TagCompanionButton extends IconButton {
  TagCompanionButton({
    super.key,
    required super.icon,
    required super.onPressed,
    super.iconSize = 16,
    bool selected = false,
    ButtonStyle? selectedStyle,
  }) : super(
          constraints: const BoxConstraints(),
          style: selected ? (selectedStyle ?? _defaultSelectedStyle) : null,
        );
}
