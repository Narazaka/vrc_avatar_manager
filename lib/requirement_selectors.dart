import 'package:flutter/material.dart';
import 'package:vrc_avatar_manager/imposter.dart';
import 'package:vrc_avatar_manager/small_icon_button.dart';
import 'package:vrc_avatar_manager/vrc_icons.dart';

class PlatformRequirementSelector extends StatelessWidget {
  const PlatformRequirementSelector({
    super.key,
    required this.requirePc,
    required this.requireAndroid,
    required this.onChanged,
  });

  final bool requirePc;
  final bool requireAndroid;
  final void Function(bool requirePc, bool requireAndroid) onChanged;

  static const _choices = [(true, false), (false, true), (true, true)];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [
        for (final (pc, android) in _choices)
          requirePc == pc && requireAndroid == android
      ],
      onPressed: (index) {
        final (pc, android) = _choices[index];
        if (requirePc == pc && requireAndroid == android) {
          onChanged(false, false);
        } else {
          onChanged(pc, android);
        }
      },
      children: [
        Tooltip(message: "PC対応アバターを表示", child: VrcIcons.pc),
        Tooltip(message: "Android対応アバターを表示", child: VrcIcons.android),
        Tooltip(
            message: "PC/Android両対応アバターを表示", child: VrcIcons.crossPlatform),
      ],
    );
  }
}

class ImposterSelector extends StatelessWidget {
  const ImposterSelector(
      {super.key, required this.value, required this.onChanged});

  final FilterByImposter value;
  final void Function(FilterByImposter) onChanged;

  @override
  Widget build(BuildContext context) {
    Widget button(FilterByImposter target, String message, Widget active,
        Widget inactive) {
      return Tooltip(
        message: message,
        child: SmallIconButton(
          icon: value == target ? active : inactive,
          onPressed: () =>
              onChanged(value == target ? FilterByImposter.none : target),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        button(FilterByImposter.haveImposter, "Imposterありのアバターを表示",
            hasImposterBadge, hasImposterInactiveBadge),
        button(FilterByImposter.notHaveImposter, "Imposterなしのアバターを表示",
            noImposterBadge, noImposterInactiveBadge),
      ],
    );
  }
}
