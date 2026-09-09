import 'package:flutter/material.dart';
import 'package:vrc_avatar_manager/db/tag.dart';
import 'package:vrc_avatar_manager/performance_selector.dart';
import 'package:vrc_avatar_manager/requirement_selectors.dart';
import 'package:vrc_avatar_manager/vrc_icons.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class TagRequirementsEditor extends StatelessWidget {
  const TagRequirementsEditor(
      {super.key, required this.tag, required this.onChanged});

  final Tag tag;
  final VoidCallback onChanged;

  static void _toggle<T>(List<T> list, T value) {
    list.contains(value) ? list.remove(value) : list.add(value);
  }

  Widget _rankRow(Widget icon, List<PerformanceRatings> ignore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        PerformanceRankSelector(
            selected:
                PerformanceRatings.values.toSet().difference(ignore.toSet()),
            onChanged: (p) {
              _toggle(ignore, p);
              onChanged();
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlatformRequirementSelector(
              requirePc: tag.requirePc,
              requireAndroid: tag.requireAndroid,
              onChanged: (pc, android) {
                tag.requirePc = pc;
                tag.requireAndroid = android;
                onChanged();
              },
            ),
            const SizedBox(width: 8),
            ImposterSelector(
              value: tag.imposter,
              onChanged: (v) {
                tag.imposter = v;
                onChanged();
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        _rankRow(VrcIcons.pc, tag.ignorePcPerformanceRatings),
        _rankRow(VrcIcons.android, tag.ignoreAndroidPerformanceRatings),
      ],
    );
  }
}
