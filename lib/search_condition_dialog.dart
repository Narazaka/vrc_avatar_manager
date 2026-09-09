import 'package:flutter/material.dart';
import 'package:vrc_avatar_manager/db/tag.dart';
import 'package:vrc_avatar_manager/db/tag_target.dart';
import 'package:vrc_avatar_manager/db/tag_type.dart';
import 'package:vrc_avatar_manager/tag_condition_group_editor.dart';
import 'package:vrc_avatar_manager/tag_requirements_editor.dart';
import 'package:vrc_avatar_manager/tag_search_options_editor.dart';

class SearchConditionDialog extends StatefulWidget {
  const SearchConditionDialog(
      {super.key,
      required this.searchTag,
      required this.filterTag,
      required this.allTags,
      required this.onChanged});

  final Tag searchTag;
  final Tag filterTag;
  final List<Tag> allTags;
  final VoidCallback onChanged;

  static Future<void> show(BuildContext context, Tag searchTag, Tag filterTag,
      List<Tag> allTags, VoidCallback onChanged) {
    return showDialog(
      context: context,
      builder: (context) => SearchConditionDialog(
          searchTag: searchTag,
          filterTag: filterTag,
          allTags: allTags,
          onChanged: onChanged),
    );
  }

  @override
  State<SearchConditionDialog> createState() => _SearchConditionDialogState();
}

class _SearchConditionDialogState extends State<SearchConditionDialog> {
  void _changed([void Function()? edit]) {
    setState(() => edit?.call());
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final tag = widget.filterTag;
    return AlertDialog(
      title: const Text('詳細検索'),
      insetPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('検索欄', style: Theme.of(context).textTheme.titleSmall),
          ),
          TagSearchOptionsEditor(tag: widget.searchTag, onChanged: _changed),
          const Divider(),
          TagRequirementsEditor(tag: tag, onChanged: _changed),
          const Divider(),
          TagConditionGroupEditor(
            conditionGroups: tag.conditionGroups,
            groupCombinator: tag.groupCombinator,
            onGroupsChanged: (groups) =>
                _changed(() => tag.conditionGroups = groups),
            onCombinatorChanged: (c) => _changed(() => tag.groupCombinator = c),
            allTags: widget.allTags,
            currentTagId: tag.id,
          ),
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () => _changed(() {
            widget.searchTag
              ..type = TagType.simple
              ..target = TagTarget.name
              ..invert = false
              ..caseSensitive = false;
            tag.conditionGroups = [];
            tag.copyRequirementsFrom(Tag()..empty());
          }),
          child: const Text('クリア'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}
