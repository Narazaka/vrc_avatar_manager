import 'package:flutter/material.dart';
import 'package:vrc_avatar_manager/db/tag.dart';
import 'package:vrc_avatar_manager/db/tag_target.dart';
import 'package:vrc_avatar_manager/db/tag_type.dart';

class TagSearchOptionsEditor extends StatelessWidget {
  const TagSearchOptionsEditor(
      {super.key, required this.tag, required this.onChanged});

  final Tag tag;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        SegmentedButton<TagType>(
          segments: const [
            ButtonSegment(value: TagType.simple, label: Text('文字列')),
            ButtonSegment(value: TagType.regexp, label: Text('正規表現')),
            ButtonSegment(value: TagType.wildcard, label: Text('ワイルドカード')),
          ],
          selected: {tag.type},
          onSelectionChanged: (v) {
            tag.type = v.first;
            onChanged();
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            DropdownButton<TagTarget>(
              value: tag.target,
              items: TagTarget.values
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(switch (e) {
                        TagTarget.name => "名前",
                        TagTarget.description => "説明",
                        TagTarget.nameOrDescription => "名前または説明",
                      })))
                  .toList(),
              onChanged: (v) {
                tag.target = v!;
                onChanged();
              },
            ),
            FilterChip(
              label: const Text('NOT'),
              selected: tag.invert,
              onSelected: (v) {
                tag.invert = v;
                onChanged();
              },
            ),
            FilterChip(
              label: const Text('Aa'),
              tooltip: '大文字小文字を区別',
              selected: tag.caseSensitive,
              onSelected: (v) {
                tag.caseSensitive = v;
                onChanged();
              },
            ),
          ],
        ),
      ],
    );
  }
}
