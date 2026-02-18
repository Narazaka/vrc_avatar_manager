import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vrc_avatar_manager/color_picker_dialog.dart';
import 'package:vrc_avatar_manager/db/condition_combinator.dart';
import 'package:vrc_avatar_manager/db/tag.dart';
import 'package:vrc_avatar_manager/db/tag_condition.dart';
import 'package:vrc_avatar_manager/db/tag_condition_group.dart';
import 'package:vrc_avatar_manager/db/tag_target.dart';
import 'package:vrc_avatar_manager/db/tag_type.dart';
import 'package:vrc_avatar_manager/db/tags_db.dart';
import 'package:vrc_avatar_manager/performance_selector.dart';
import 'package:vrc_avatar_manager/tag_button.dart';
import 'package:vrc_avatar_manager/tag_condition_group_editor.dart';
import 'package:vrc_avatar_manager/text_color_for.dart';
import 'package:vrc_avatar_manager/vrc_icons.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class TagEditDialog extends StatefulWidget {
  const TagEditDialog(
      {super.key,
      required this.tag,
      required this.isNew,
      required this.tagsDb,
      required this.allTags});
  final Tag tag;
  final bool isNew;
  final TagsDb tagsDb;
  final List<Tag> allTags;

  @override
  State<TagEditDialog> createState() => _TagEditDialogState();

  static Future<String?> show(
    BuildContext context,
    Tag tag,
    bool isNew,
    TagsDb tagsDb, {
    List<Tag> allTags = const [],
  }) async {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return TagEditDialog(tag: tag, isNew: isNew, tagsDb: tagsDb, allTags: allTags);
      },
    );
  }
}

class _TagEditDialogState extends State<TagEditDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _groupIdController = TextEditingController();
  Color _color = Colors.white;
  Color _inactiveColor = Colors.white;
  TagType _type = TagType.items;
  TagTarget _target = TagTarget.name;
  final _searchController = TextEditingController();
  bool _invert = false;
  bool _caseSensitive = false;
  ConditionCombinator _groupCombinator = ConditionCombinator.and;
  List<TagConditionGroup> _conditionGroups = [];
  bool _showRequirements = false;
  bool _requirePc = false;
  bool _requireAndroid = false;
  Set<PerformanceRatings> _ignorePcPerformanceRatings = {};
  Set<PerformanceRatings> _ignoreAndroidPerformanceRatings = {};

  @override
  void dispose() {
    _nameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.tag.name;
    _groupIdController.text = widget.tag.groupId.toString();
    _color = Color(widget.tag.validColor);
    _inactiveColor = Color(widget.tag.validInactiveColor);
    _type = widget.tag.type;
    _target = widget.tag.target;
    _searchController.text = widget.tag.search;
    _invert = widget.tag.invert;
    _caseSensitive = widget.tag.caseSensitive;
    _groupCombinator = widget.tag.groupCombinator;
    _conditionGroups = widget.tag.conditionGroups
        .map((g) => TagConditionGroup()
          ..conditions = g.conditions
              .map((c) => TagCondition()
                ..target = c.target
                ..matchType = c.matchType
                ..search = c.search
                ..invert = c.invert
                ..caseSensitive = c.caseSensitive)
              .toList())
        .toList();
    _showRequirements = widget.tag.hasRequirements;
    _requirePc = widget.tag.requirePc;
    _requireAndroid = widget.tag.requireAndroid;
    _ignorePcPerformanceRatings = widget.tag.ignorePcPerformanceRatings.toSet();
    _ignoreAndroidPerformanceRatings =
        widget.tag.ignoreAndroidPerformanceRatings.toSet();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '名前',
              ),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<TagType>(
              decoration: const InputDecoration(
                labelText: 'タイプ',
              ),
              initialValue: _type,
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
              items: TagType.values
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(switch (e) {
                        TagType.items => "リスト",
                        TagType.simple => "文字列検索",
                        TagType.regexp => "正規表現検索",
                        TagType.wildcard => "ワイルドカード検索",
                        TagType.conditions => "条件検索",
                      })))
                  .toList(),
            ),
            TextFormField(
              controller: _groupIdController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'タググループ(択一選択時)',
              ),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            if (_type == TagType.simple || _type == TagType.regexp || _type == TagType.wildcard)
              DropdownButtonFormField<TagTarget>(
                decoration: const InputDecoration(
                  labelText: '検索対象',
                ),
                initialValue: _target,
                onChanged: (value) {
                  setState(() {
                    _target = value!;
                  });
                },
                items: TagTarget.values
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(switch (e) {
                          TagTarget.name => "名前",
                          TagTarget.description => "説明",
                          TagTarget.nameOrDescription => "名前または説明",
                        })))
                    .toList(),
              ),
            if (_type == TagType.simple || _type == TagType.regexp || _type == TagType.wildcard)
              TextFormField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: '検索文字列',
                ),
              ),
            if (_type == TagType.simple || _type == TagType.regexp || _type == TagType.wildcard)
              CheckboxListTile(
                value: _invert,
                onChanged: (value) {
                  setState(() {
                    _invert = value!;
                  });
                },
                title: const Text("NOT条件"),
              ),
            if (_type == TagType.simple || _type == TagType.regexp || _type == TagType.wildcard)
              CheckboxListTile(
                value: _caseSensitive,
                onChanged: (value) {
                  setState(() {
                    _caseSensitive = value!;
                  });
                },
                title: const Text("大文字小文字を区別する"),
              ),
            if (_type == TagType.conditions)
              TagConditionGroupEditor(
                conditionGroups: _conditionGroups,
                groupCombinator: _groupCombinator,
                onGroupsChanged: (groups) {
                  setState(() {
                    _conditionGroups = groups;
                  });
                },
                onCombinatorChanged: (combinator) {
                  setState(() {
                    _groupCombinator = combinator;
                  });
                },
                allTags: widget.allTags,
                currentTagId: widget.tag.id,
              ),
            const SizedBox(height: 8),
            if (_type != TagType.items) ExpansionTile(
                title: const Text("必要パフォーマンス"),
                initiallyExpanded: _showRequirements,
                children: [
                  ToggleButtons(
                    isSelected: [
                      _requirePc && !_requireAndroid,
                      !_requirePc && _requireAndroid,
                      _requirePc && _requireAndroid,
                    ],
                    onPressed: (int index) {
                      setState(() {
                        switch (index) {
                          case 0:
                            if (_requirePc && !_requireAndroid) {
                              _requirePc = false;
                            } else {
                              _requirePc = true;
                              _requireAndroid = false;
                            }
                            break;
                          case 1:
                            if (!_requirePc && _requireAndroid) {
                              _requireAndroid = false;
                            } else {
                              _requirePc = false;
                              _requireAndroid = true;
                            }
                            break;
                          case 2:
                            if (_requirePc && _requireAndroid) {
                              _requirePc = false;
                              _requireAndroid = false;
                            } else {
                              _requirePc = true;
                              _requireAndroid = true;
                            }
                            break;
                        }
                      });
                    },
                    children: [
                      Tooltip(message: "PC対応アバターを表示", child: VrcIcons.pc),
                      Tooltip(
                          message: "Android対応アバターを表示", child: VrcIcons.android),
                      Tooltip(
                          message: "PC/Android両対応アバターを表示",
                          child: VrcIcons.crossPlatform),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VrcIcons.pc,
                      PerformanceRankSelector(
                          selected: PerformanceRatings.values
                              .toSet()
                              .difference(_ignorePcPerformanceRatings),
                          onChanged: (p) {
                            setState(() {
                              _ignorePcPerformanceRatings.contains(p)
                                  ? _ignorePcPerformanceRatings.remove(p)
                                  : _ignorePcPerformanceRatings.add(p);
                            });
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VrcIcons.android,
                      PerformanceRankSelector(
                          selected: PerformanceRatings.values
                              .toSet()
                              .difference(_ignoreAndroidPerformanceRatings),
                          onChanged: (p) {
                            setState(() {
                              _ignoreAndroidPerformanceRatings.contains(p)
                                  ? _ignoreAndroidPerformanceRatings.remove(p)
                                  : _ignoreAndroidPerformanceRatings.add(p);
                            });
                          })
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                TagButton(
                    tag: Tag()
                      ..empty()
                      ..name = "有効時色"
                      ..color = _color.value
                      ..inactiveColor = _inactiveColor.value,
                    onPressed: () async {
                      var color = await ColorPickerDialog.show(context, _color,
                          defaultColor: Tag.defaultColor);
                      if (color != null) {
                        setState(() {
                          _color = color;
                        });
                      }
                    },
                    selected: true),
                TagButton(
                    tag: Tag()
                      ..empty()
                      ..name = "無効時色"
                      ..color = _color.value
                      ..inactiveColor = _inactiveColor.value,
                    onPressed: () async {
                      var color = await ColorPickerDialog.show(
                          context, _inactiveColor,
                          defaultColor: Tag.defaultInactiveColor);
                      if (color != null) {
                        setState(() {
                          _inactiveColor = color;
                        });
                      }
                    },
                    selected: false)
              ],
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    _inactiveColor = _color.inactiveColor;
                  });
                },
                child: const Text("有効時色から無効時色を自動計算")),
            TextButton(
                onPressed: () {
                  setState(() {
                    _inactiveColor = Colors.white;
                  });
                },
                child: const Text("無効時色は白")),
          ]))),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) {
              return;
            }

            widget.tag
              ..name = _nameController.text
              ..groupId = int.tryParse(_groupIdController.text) ?? 0
              ..color = _color.value
              ..inactiveColor = _inactiveColor.value
              ..type = _type
              ..target = _target
              ..search = _searchController.text
              ..invert = _invert
              ..caseSensitive = _caseSensitive
              ..groupCombinator = _groupCombinator
              ..conditionGroups = _conditionGroups
              ..requirePc = _requirePc
              ..requireAndroid = _requireAndroid
              ..ignorePcPerformanceRatings =
                  _ignorePcPerformanceRatings.toList()
              ..ignoreAndroidPerformanceRatings =
                  _ignoreAndroidPerformanceRatings.toList();
            await widget.tagsDb.put(widget.tag);

            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, foregroundColor: Colors.white),
          child: const Text('OK'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        if (!widget.isNew)
          ElevatedButton(
            onPressed: () async {
              await widget.tagsDb.delete(widget.tag);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Delete'),
          ),
      ],
    );
  }
}
