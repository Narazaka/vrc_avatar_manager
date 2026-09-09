import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vrc_avatar_manager/avatar_view.dart';
import 'package:vrc_avatar_manager/performance_stats.dart';
import 'package:vrc_avatar_manager/vrc_icons.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

// VRChat 本体のパフォーマンス表示から採取した色
const _excellentColor = Color(0xFF34B31E);
const _goodColor = Color(0xFF1E780E);
const _mediumColor = Color(0xFFDBA532);
const _poorColor = Color(0xFFE55A42);
const _veryPoorColor = Color(0xFFB32000);

const _labelStyle = TextStyle(fontSize: 11);
const _extraLabelStyle = TextStyle(fontSize: 11, color: Colors.black54);
const _valueStyle =
    TextStyle(fontSize: 11, fontFeatures: [FontFeature.tabularFigures()]);
const _titleStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);

const _gap = SizedBox(width: 6);

Color? _ratingColor(PerformanceRatings? rating) {
  switch (rating) {
    case PerformanceRatings.excellent:
      return _excellentColor;
    case PerformanceRatings.good:
      return _goodColor;
    case PerformanceRatings.medium:
      return _mediumColor;
    case PerformanceRatings.poor:
      return _poorColor;
    case PerformanceRatings.veryPoor:
      return _veryPoorColor;
    default:
      return null;
  }
}

class AvatarAnalysisView extends StatefulWidget {
  const AvatarAnalysisView({
    super.key,
    required this.analysis,
    required this.isPc,
    required this.stale,
  });

  final FileAnalysis analysis;
  final bool isPc;
  final bool stale;

  @override
  State<AvatarAnalysisView> createState() => _AvatarAnalysisViewState();
}

class _AvatarAnalysisViewState extends State<AvatarAnalysisView> {
  bool _extraExpanded = false;

  Widget _row(PerformanceStat stat, TextStyle labelStyle) {
    final rating = stat.rating(widget.analysis, widget.isPc);
    final color =
        _ratingColor(rating)?.withValues(alpha: widget.stale ? 0.4 : 1);
    final limits = stat.limits(widget.isPc);
    final value = Text(stat.value(widget.analysis),
        style: _valueStyle.copyWith(color: color ?? labelStyle.color));
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        width: 16,
        height: 14,
        child: rating == null
            ? null
            : Opacity(
                opacity: widget.stale ? 0.4 : 1,
                child: FittedBox(child: AvatarView.performanceIcon(rating))),
      ),
      Tooltip(
        message: stat.tooltip,
        child: Text(stat.label,
            style:
                color == null ? labelStyle : labelStyle.copyWith(color: color)),
      ),
      _gap,
      if (limits == null)
        value
      else
        Tooltip(
          richMessage: TextSpan(children: [
            for (final (i, (rating, text)) in limits.indexed)
              TextSpan(
                  text: "${i > 0 ? "\n" : ""}${rating.value}: $text",
                  style: _valueStyle.copyWith(color: _ratingColor(rating))),
          ]),
          // 既定の暗い背景ではランクの色が読めない
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(4),
          ),
          child: value,
        ),
    ]);
  }

  List<Widget> _grouped(List<PerformanceStat> stats, TextStyle labelStyle) {
    return [
      for (final category in StatCategory.values)
        if (stats.any((s) => s.category == category)) ...[
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(category.label, style: _titleStyle),
          ),
          for (final stat in statsIn(stats, category)) _row(stat, labelStyle),
        ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final overall = PerformanceRatings.values
        .firstWhereOrNull((r) => r.value == widget.analysis.performanceRating);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          widget.isPc ? VrcIcons.pc : VrcIcons.android,
          if (overall != null) AvatarView.performanceIcon(overall),
        ]),
        ..._grouped(performanceStats, _labelStyle),
        InkWell(
          onTap: () => setState(() => _extraExpanded = !_extraExpanded),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(_extraExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                size: 16),
            const Text("参考情報", style: _titleStyle),
          ]),
        ),
        if (_extraExpanded)
          ..._grouped(extraPerformanceStats, _extraLabelStyle),
      ],
    );
  }
}
