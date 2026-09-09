import 'package:flutter/material.dart';
import 'package:vrc_avatar_manager/db/stat_requirement.dart';
import 'package:vrc_avatar_manager/db/tag.dart';
import 'package:vrc_avatar_manager/performance_selector.dart';
import 'package:vrc_avatar_manager/performance_stats.dart';
import 'package:vrc_avatar_manager/requirement_selectors.dart';
import 'package:vrc_avatar_manager/vrc_icons.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class TagRequirementsEditor extends StatefulWidget {
  const TagRequirementsEditor(
      {super.key, required this.tag, required this.onChanged});

  final Tag tag;
  final VoidCallback onChanged;

  @override
  State<TagRequirementsEditor> createState() => _TagRequirementsEditorState();
}

class _TagRequirementsEditorState extends State<TagRequirementsEditor> {
  final Set<StatRequirement> _numericShown = {};

  Tag get tag => widget.tag;
  VoidCallback get onChanged => widget.onChanged;

  bool _showsNumeric(PerformanceStat stat, StatRequirement req) =>
      !stat.rankable ||
      _numericShown.contains(req) ||
      [req.minPc, req.maxPc, req.minAndroid, req.maxAndroid]
          .any((v) => v != null);

  static void _toggle<T>(List<T> list, T value) {
    list.contains(value) ? list.remove(value) : list.add(value);
  }

  Widget _rankSelector(List<PerformanceRatings> ignore) {
    return PerformanceRankSelector(
        selected: PerformanceRatings.values.toSet().difference(ignore.toSet()),
        onChanged: (p) {
          _toggle(ignore, p);
          onChanged();
        });
  }

  Widget _rankRow(Widget icon, List<PerformanceRatings> ignore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [icon, _rankSelector(ignore)],
    );
  }

  Widget _numberField(
      String label, double? value, void Function(double?) onChanged) {
    return SizedBox(
      width: 80,
      child: TextFormField(
        initialValue: value?.toString() ?? '',
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        ),
        onChanged: (v) {
          onChanged(double.tryParse(v));
          this.onChanged();
        },
      ),
    );
  }

  Widget _boolField(double? min, double? max,
      void Function(double? min, double? max) onChanged) {
    final current = min == 1
        ? true
        : max == 0
            ? false
            : null;
    return DropdownButton<bool?>(
      value: current,
      isDense: true,
      items: const [
        DropdownMenuItem(value: null, child: Text('指定なし')),
        DropdownMenuItem(value: true, child: Text('はい')),
        DropdownMenuItem(value: false, child: Text('いいえ')),
      ],
      onChanged: (v) {
        onChanged(v == true ? 1 : null, v == false ? 0 : null);
        this.onChanged();
      },
    );
  }

  Widget _platformCell(bool isPc, List<Widget> content) {
    if (content.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [isPc ? VrcIcons.pc : VrcIcons.android, ...content],
      ),
    );
  }

  Widget _rankCell(PerformanceStat stat, StatRequirement req,
      {required bool isPc}) {
    return _platformCell(isPc, [
      if (stat.rankableOn(isPc))
        _rankSelector(isPc ? req.ignorePc : req.ignoreAndroid),
    ]);
  }

  Widget _numericCell(PerformanceStat stat, StatRequirement req,
      {required bool isPc}) {
    final min = isPc ? req.minPc : req.minAndroid;
    final max = isPc ? req.maxPc : req.maxAndroid;
    void setMin(double? v) => isPc ? req.minPc = v : req.minAndroid = v;
    void setMax(double? v) => isPc ? req.maxPc = v : req.maxAndroid = v;
    return _platformCell(isPc, [
      if (stat.isBool)
        _boolField(min, max, (a, b) {
          setMin(a);
          setMax(b);
        })
      else ...[
        _numberField('下限', min, setMin),
        const Text('〜'),
        _numberField('上限', max, setMax),
        if (stat.unit.isNotEmpty) Text(stat.unit),
      ],
    ]);
  }

  Widget _statBlock(StatRequirement req) {
    final stat = performanceStatByKey(req.stat);
    return Column(
      key: ObjectKey(req),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            DropdownButton<String>(
              value: stat?.key,
              isDense: true,
              items: [
                for (final category in StatCategory.values) ...[
                  DropdownMenuItem(
                    enabled: false,
                    child: Text(category.label,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  for (final s in statsIn(filterablePerformanceStats, category))
                    DropdownMenuItem(
                        value: s.key,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(s.label,
                              style: const TextStyle(fontSize: 13)),
                        )),
                ],
              ],
              onChanged: (v) {
                req.stat = v!;
                onChanged();
              },
            ),
            if (stat != null && stat.rankable && stat.metric != null)
              IconButton(
                icon: const Icon(Icons.tune, size: 20),
                isSelected: _showsNumeric(stat, req),
                tooltip: '数値で指定',
                onPressed: () => setState(() {
                  if (_showsNumeric(stat, req)) {
                    _numericShown.remove(req);
                    req
                      ..minPc = null
                      ..maxPc = null
                      ..minAndroid = null
                      ..maxAndroid = null;
                    onChanged();
                  } else {
                    _numericShown.add(req);
                  }
                }),
              ),
            IconButton(
              icon: const Icon(Icons.remove_circle_outline, size: 20),
              onPressed: () {
                tag.statRequirements.remove(req);
                onChanged();
              },
            ),
          ],
        ),
        if (stat != null)
          Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              if (stat.rankable)
                TableRow(children: [
                  _rankCell(stat, req, isPc: true),
                  _rankCell(stat, req, isPc: false),
                ]),
              if (stat.metric != null && _showsNumeric(stat, req))
                TableRow(children: [
                  _numericCell(stat, req, isPc: true),
                  _numericCell(stat, req, isPc: false),
                ]),
            ],
          ),
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
        for (final req in tag.statRequirements) ...[
          const Divider(),
          _statBlock(req),
        ],
        TextButton.icon(
          icon: const Icon(Icons.add, size: 18),
          label: const Text('パフォーマンス詳細の項目を追加'),
          onPressed: () {
            tag.statRequirements.add(
                StatRequirement()..stat = filterablePerformanceStats.first.key);
            onChanged();
          },
        ),
      ],
    );
  }
}
