import 'package:flutter/material.dart';
import 'package:vrc_avatar_manager/db/condition_combinator.dart';
import 'package:vrc_avatar_manager/db/condition_match_type.dart';
import 'package:vrc_avatar_manager/db/tag_condition.dart';
import 'package:vrc_avatar_manager/db/tag_condition_group.dart';
import 'package:vrc_avatar_manager/db/tag_target.dart';

class TagConditionGroupEditor extends StatefulWidget {
  const TagConditionGroupEditor({
    super.key,
    required this.conditionGroups,
    required this.groupCombinator,
    required this.onGroupsChanged,
    required this.onCombinatorChanged,
  });

  final List<TagConditionGroup> conditionGroups;
  final ConditionCombinator groupCombinator;
  final void Function(List<TagConditionGroup>) onGroupsChanged;
  final void Function(ConditionCombinator) onCombinatorChanged;

  @override
  State<TagConditionGroupEditor> createState() =>
      _TagConditionGroupEditorState();
}

class _TagConditionGroupEditorState extends State<TagConditionGroupEditor> {
  final Map<TagCondition, TextEditingController> _controllers = {};

  TextEditingController _getController(TagCondition cond) {
    return _controllers.putIfAbsent(
      cond,
      () => TextEditingController(text: cond.search),
    );
  }

  void _cleanupControllers() {
    final activeConditions = <TagCondition>{};
    for (final group in widget.conditionGroups) {
      activeConditions.addAll(group.conditions);
    }
    _controllers.removeWhere((cond, controller) {
      if (!activeConditions.contains(cond)) {
        controller.dispose();
        return true;
      }
      return false;
    });
  }

  @override
  void didUpdateWidget(covariant TagConditionGroupEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    _cleanupControllers();
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _notifyChanged() {
    widget.onGroupsChanged(widget.conditionGroups);
  }

  String get _innerLabel => widget.groupCombinator == ConditionCombinator.and
      ? 'グループ内: OR'
      : 'グループ内: AND';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('グループ間: '),
            SegmentedButton<ConditionCombinator>(
              segments: const [
                ButtonSegment(value: ConditionCombinator.and, label: Text('AND')),
                ButtonSegment(value: ConditionCombinator.or, label: Text('OR')),
              ],
              selected: {widget.groupCombinator},
              onSelectionChanged: (v) => widget.onCombinatorChanged(v.first),
            ),
            const SizedBox(width: 8),
            Text('（$_innerLabel）', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const SizedBox(height: 8),
        ...List.generate(widget.conditionGroups.length, (gi) {
          final group = widget.conditionGroups[gi];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('グループ ${gi + 1}',
                          style: Theme.of(context).textTheme.titleSmall),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        onPressed: () {
                          setState(() {
                            widget.conditionGroups.removeAt(gi);
                          });
                          _cleanupControllers();
                          _notifyChanged();
                        },
                        tooltip: 'グループを削除',
                      ),
                    ],
                  ),
                  ...List.generate(group.conditions.length, (ci) {
                    final cond = group.conditions[ci];
                    final controller = _getController(cond);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: DropdownButtonFormField<TagTarget>(
                                  initialValue: cond.target,
                                  decoration: const InputDecoration(
                                    labelText: '対象',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                  ),
                                  items: TagTarget.values
                                      .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            switch (e) {
                                              TagTarget.name => "名前",
                                              TagTarget.description => "説明",
                                              TagTarget.nameOrDescription =>
                                                "名前または説明",
                                            },
                                            style: const TextStyle(fontSize: 13),
                                          )))
                                      .toList(),
                                  onChanged: (v) {
                                    cond.target = v!;
                                    _notifyChanged();
                                  },
                                ),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<ConditionMatchType>(
                                  initialValue: cond.matchType,
                                  decoration: const InputDecoration(
                                    labelText: 'マッチ',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                  ),
                                  items: ConditionMatchType.values
                                      .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            switch (e) {
                                              ConditionMatchType.contains =>
                                                "部分一致",
                                              ConditionMatchType.regexp =>
                                                "正規表現",
                                            },
                                            style: const TextStyle(fontSize: 13),
                                          )))
                                      .toList(),
                                  onChanged: (v) {
                                    cond.matchType = v!;
                                    _notifyChanged();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                    labelText: '検索文字列',
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                  ),
                                  onChanged: (v) {
                                    cond.search = v;
                                    _notifyChanged();
                                  },
                                ),
                              ),
                              const SizedBox(width: 4),
                              FilterChip(
                                label: const Text('NOT',
                                    style: TextStyle(fontSize: 12)),
                                selected: cond.invert,
                                onSelected: (v) {
                                  setState(() {
                                    cond.invert = v;
                                  });
                                  _notifyChanged();
                                },
                              ),
                              FilterChip(
                                label: const Text('Aa',
                                    style: TextStyle(fontSize: 12)),
                                selected: cond.caseSensitive,
                                onSelected: (v) {
                                  setState(() {
                                    cond.caseSensitive = v;
                                  });
                                  _notifyChanged();
                                },
                                tooltip: '大文字小文字を区別',
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline,
                                    size: 20),
                                onPressed: () {
                                  setState(() {
                                    group.conditions.removeAt(ci);
                                  });
                                  _cleanupControllers();
                                  _notifyChanged();
                                },
                                tooltip: '条件を削除',
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  TextButton.icon(
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('条件を追加'),
                    onPressed: () {
                      setState(() {
                        group.conditions.add(TagCondition());
                      });
                      _notifyChanged();
                    },
                  ),
                ],
              ),
            ),
          );
        }),
        TextButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('グループを追加'),
          onPressed: () {
            setState(() {
              widget.conditionGroups.add(TagConditionGroup());
            });
            _notifyChanged();
          },
        ),
      ],
    );
  }
}
