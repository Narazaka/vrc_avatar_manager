import 'package:collection/collection.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:vrc_avatar_manager/avatar_view.dart';
import 'package:vrc_avatar_manager/vrc_icons.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

// アイコンは緑・橙・赤の3色しか無いので、色相はそのままに明度で5段階に分ける
const _excellentColor = Color(0xFF2FB418);
const _goodColor = Color(0xFF217E11);
const _mediumColor = Color(0xFFB18007);
const _poorColor = Color(0xFFCA351C);
const _veryPoorColor = Color(0xFF8F2614);
const _invalidColor = Colors.black38;

const _labelStyle = TextStyle(fontSize: 11);
const _extraLabelStyle = TextStyle(fontSize: 11, color: Colors.black54);
const _valueStyle =
    TextStyle(fontSize: 11, fontFeatures: [FontFeature.tabularFigures()]);
const _titleStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);

const _mb = 1024 * 1024;
const _gap = SizedBox(width: 6);

String _size(int bytes) => filesize(bytes, 1).replaceAll(" ", "");

String _bool(bool v) => v ? "はい" : "いいえ";

num _flag(bool v) => v ? 1 : 0;

class _Stat {
  const _Stat(this.label, this.tooltip, this.value,
      {this.metric,
      this.pc,
      this.android,
      this.rate,
      this.limitsList,
      this.limitFormat});

  final String label;
  final String tooltip;
  final String Function(FileAnalysis a) value;
  final num Function(FileAnalysis a)? metric;
  final List<num>? pc;
  final List<num>? android;

  final PerformanceRatings? Function(FileAnalysis a)? rate;

  final List<(PerformanceRatings, String)>? limitsList;

  final String Function(num v)? limitFormat;

  List<(PerformanceRatings, String)>? limits(bool isPc) {
    if (limitsList != null) {
      return limitsList;
    }
    final limits = isPc ? pc : android;
    if (limits == null) {
      return null;
    }
    final format = limitFormat ?? (v) => "$v";
    return [
      for (final (i, rating) in _rankOrder.indexed) (rating, format(limits[i]))
    ];
  }

  PerformanceRatings? rating(FileAnalysis a, bool isPc) {
    final rate = this.rate;
    if (rate != null) {
      return rate(a);
    }
    final limits = isPc ? pc : android;
    final metric = this.metric;
    if (limits == null || metric == null) {
      return null;
    }
    final v = metric(a);
    if (v <= limits[0]) return PerformanceRatings.excellent;
    if (v <= limits[1]) return PerformanceRatings.good;
    if (v <= limits[2]) return PerformanceRatings.medium;
    if (v <= limits[3]) return PerformanceRatings.poor;
    return PerformanceRatings.veryPoor;
  }
}

const _rankOrder = [
  PerformanceRatings.excellent,
  PerformanceRatings.good,
  PerformanceRatings.medium,
  PerformanceRatings.poor,
];

const _boundsLimits = <(PerformanceRatings, List<double>)>[
  (PerformanceRatings.excellent, [2.5, 2.5, 2.5]),
  (PerformanceRatings.good, [4, 4, 4]),
  (PerformanceRatings.medium, [5, 6, 5]),
  (PerformanceRatings.poor, [5, 6, 5]),
];

PerformanceRatings? _boundsRating(List<num> bounds) {
  if (bounds.length < 3) {
    return null;
  }
  for (final (rating, limits) in _boundsLimits) {
    if (bounds[0] <= limits[0] &&
        bounds[1] <= limits[1] &&
        bounds[2] <= limits[2]) {
      return rating;
    }
  }
  return PerformanceRatings.veryPoor;
}

final _boundsLimitsList = _boundsLimits
    .map((e) => (e.$1, e.$2.map((v) => v.toStringAsFixed(2)).join("x")))
    .toList();

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

final _stats = <_Stat>[
  _Stat("ポリゴン数", "Triangles", (a) => "${a.avatarStats.totalPolygons}",
      metric: (a) => a.avatarStats.totalPolygons,
      pc: [32000, 70000, 70000, 70000],
      android: [7500, 10000, 15000, 20000]),
  _Stat("Boundsサイズ", "Bounds Size",
      (a) => a.avatarStats.bounds.map((v) => v.toStringAsFixed(2)).join("x"),
      rate: (a) => _boundsRating(a.avatarStats.bounds),
      limitsList: _boundsLimitsList),
  _Stat("テクスチャメモリ", "Texture Memory",
      (a) => _size(a.avatarStats.totalTextureUsage),
      metric: (a) => a.avatarStats.totalTextureUsage,
      pc: [40 * _mb, 75 * _mb, 110 * _mb, 150 * _mb],
      android: [10 * _mb, 18 * _mb, 25 * _mb, 40 * _mb],
      limitFormat: (v) => _size(v.toInt())),
  _Stat("SkinnedMeshRenderer数", "Skinned Meshes",
      (a) => "${a.avatarStats.skinnedMeshCount}",
      metric: (a) => a.avatarStats.skinnedMeshCount,
      pc: [1, 2, 8, 16],
      android: [1, 1, 2, 2]),
  _Stat("MeshRenderer数", "Basic Meshes", (a) => "${a.avatarStats.meshCount}",
      metric: (a) => a.avatarStats.meshCount,
      pc: [4, 8, 16, 24],
      android: [1, 1, 2, 2]),
  _Stat("マテリアルスロット数", "Material Slots",
      (a) => "${a.avatarStats.materialSlotsUsed}",
      metric: (a) => a.avatarStats.materialSlotsUsed,
      pc: [4, 8, 16, 32],
      android: [1, 1, 2, 4]),
  _Stat("PhysBoneコンポーネント数", "PhysBones Components",
      (a) => "${a.avatarStats.physBoneComponentCount}",
      metric: (a) => a.avatarStats.physBoneComponentCount,
      pc: [4, 8, 16, 32],
      android: [0, 4, 6, 8]),
  _Stat("PhysBone影響ボーン数", "PhysBones Affected Transforms",
      (a) => "${a.avatarStats.physBoneTransformCount}",
      metric: (a) => a.avatarStats.physBoneTransformCount,
      pc: [16, 64, 128, 256],
      android: [0, 16, 32, 64]),
  _Stat("PhysBoneコライダー数", "PhysBones Colliders",
      (a) => "${a.avatarStats.physBoneColliderCount}",
      metric: (a) => a.avatarStats.physBoneColliderCount,
      pc: [4, 8, 16, 32],
      android: [0, 4, 8, 16]),
  _Stat("PhysBone衝突判定数", "PhysBones Collision Check Count",
      (a) => "${a.avatarStats.physBoneCollisionCheckCount}",
      metric: (a) => a.avatarStats.physBoneCollisionCheckCount,
      pc: [32, 128, 256, 512],
      android: [0, 16, 32, 64]),
  _Stat("Contact数", "Contacts", (a) => "${a.avatarStats.contactCount}",
      metric: (a) => a.avatarStats.contactCount,
      pc: [8, 16, 24, 32],
      android: [2, 4, 8, 16]),
  _Stat("Constraint数", "Constraint Count",
      (a) => "${a.avatarStats.constraintCount}",
      metric: (a) => a.avatarStats.constraintCount,
      pc: [100, 250, 300, 350],
      android: [30, 60, 120, 150]),
  _Stat("Constraint深度", "Constraint Depth",
      (a) => "${a.avatarStats.constraintDepth}",
      metric: (a) => a.avatarStats.constraintDepth,
      pc: [20, 50, 80, 100],
      android: [5, 15, 35, 50]),
  _Stat("Animator数", "Animators", (a) => "${a.avatarStats.animatorCount}",
      metric: (a) => a.avatarStats.animatorCount,
      pc: [1, 4, 16, 32],
      android: [1, 1, 1, 2]),
  _Stat("ボーン数", "Bones", (a) => "${a.avatarStats.boneCount}",
      metric: (a) => a.avatarStats.boneCount,
      pc: [75, 150, 256, 400],
      android: [75, 90, 150, 150]),
  _Stat("ライト数", "Lights", (a) => "${a.avatarStats.lightCount}",
      metric: (a) => a.avatarStats.lightCount, pc: [0, 0, 0, 1]),
  _Stat("ParticleSystem数", "Particle Systems",
      (a) => "${a.avatarStats.particleSystemCount}",
      metric: (a) => a.avatarStats.particleSystemCount,
      pc: [0, 4, 8, 16],
      android: [0, 0, 0, 2]),
  _Stat("パーティクル数", "Total Particles Active",
      (a) => "${a.avatarStats.totalMaxParticles}",
      metric: (a) => a.avatarStats.totalMaxParticles,
      pc: [0, 300, 1000, 2500],
      android: [0, 0, 0, 200]),
  _Stat("メッシュパーティクルポリゴン数", "Mesh Particle Active Polys",
      (a) => "${a.avatarStats.meshParticleMaxPolygons}",
      metric: (a) => a.avatarStats.meshParticleMaxPolygons,
      pc: [0, 1000, 2000, 5000],
      android: [0, 0, 0, 400]),
  _Stat("パーティクルTrail有効", "Particle Trails Enabled",
      (a) => _bool(a.avatarStats.particleTrailsEnabled),
      metric: (a) => _flag(a.avatarStats.particleTrailsEnabled),
      pc: [0, 0, 1, 1],
      android: [0, 0, 0, 1],
      limitFormat: (v) => _bool(v != 0)),
  _Stat("パーティクルCollision有効", "Particle Collision Enabled",
      (a) => _bool(a.avatarStats.particleCollisionEnabled),
      metric: (a) => _flag(a.avatarStats.particleCollisionEnabled),
      pc: [0, 0, 1, 1],
      android: [0, 0, 0, 1],
      limitFormat: (v) => _bool(v != 0)),
  _Stat("TrailRenderer数", "Trail Renderers",
      (a) => "${a.avatarStats.trailRendererCount}",
      metric: (a) => a.avatarStats.trailRendererCount,
      pc: [1, 2, 4, 8],
      android: [0, 0, 0, 1]),
  _Stat("LineRenderer数", "Line Renderers",
      (a) => "${a.avatarStats.lineRendererCount}",
      metric: (a) => a.avatarStats.lineRendererCount,
      pc: [1, 2, 4, 8],
      android: [0, 0, 0, 1]),
  _Stat("Raycast数", "Raycasts",
      (a) => a.avatarStats.raycastCount?.toString() ?? "-",
      metric: (a) => a.avatarStats.raycastCount ?? 0,
      pc: [1, 4, 8, 15],
      android: [1, 2, 4, 8]),
  _Stat("Cloth数", "Cloths", (a) => "${a.avatarStats.clothCount}",
      metric: (a) => a.avatarStats.clothCount, pc: [0, 1, 1, 1]),
  _Stat("Cloth頂点数", "Total Cloth Vertices",
      (a) => "${a.avatarStats.totalClothVertices}",
      metric: (a) => a.avatarStats.totalClothVertices, pc: [0, 50, 100, 200]),
  _Stat("物理コライダー数", "Physics Colliders",
      (a) => "${a.avatarStats.physicsColliders}",
      metric: (a) => a.avatarStats.physicsColliders, pc: [0, 1, 8, 8]),
  _Stat("Rigidbody数", "Physics Rigidbodies",
      (a) => "${a.avatarStats.physicsRigidbodies}",
      metric: (a) => a.avatarStats.physicsRigidbodies, pc: [0, 1, 8, 8]),
  _Stat("AudioSource数", "Audio Sources",
      (a) => "${a.avatarStats.audioSourceCount}",
      metric: (a) => a.avatarStats.audioSourceCount, pc: [1, 4, 8, 8]),
  _Stat("ダウンロードサイズ", "fileSize", (a) => _size(a.fileSize)),
  _Stat("非圧縮サイズ", "uncompressedSize", (a) => _size(a.uncompressedSize)),
];

final _extraStats = <_Stat>[
  _Stat("マテリアル数", "materialCount", (a) => "${a.avatarStats.materialCount}"),
  _Stat("BlendShape数", "blendShapeCount",
      (a) => "${a.avatarStats.blendShapeCount}"),
  _Stat("頂点数", "totalVertices", (a) => "${a.avatarStats.totalVertices}"),
  _Stat("SkinnedMeshRenderer頂点数", "skinnedMeshVertices",
      (a) => "${a.avatarStats.skinnedMeshVertices}"),
  _Stat("MeshRenderer頂点数", "meshVertices",
      (a) => "${a.avatarStats.meshVertices}"),
  _Stat("SkinnedMeshRendererポリゴン数", "skinnedMeshPolygons",
      (a) => "${a.avatarStats.skinnedMeshPolygons}"),
  _Stat("MeshRendererポリゴン数", "meshPolygons",
      (a) => "${a.avatarStats.meshPolygons}"),
  _Stat("インデックス数", "totalIndices", (a) => "${a.avatarStats.totalIndices}"),
  _Stat("SkinnedMeshRendererインデックス数", "skinnedMeshIndices",
      (a) => "${a.avatarStats.skinnedMeshIndices}"),
  _Stat("MeshRendererインデックス数", "meshIndices",
      (a) => "${a.avatarStats.meshIndices}"),
  _Stat("Write Defaults使用", "writeDefaultsUsed",
      (a) => _bool(a.avatarStats.writeDefaultsUsed)),
  _Stat("Custom Expressions", "customExpressions",
      (a) => _bool(a.avatarStats.customExpressions)),
  _Stat("Customize Animation Layers", "customizeAnimationLayers",
      (a) => _bool(a.avatarStats.customizeAnimationLayers)),
  _Stat(
      "Eye Look有効", "enableEyeLook", (a) => _bool(a.avatarStats.enableEyeLook)),
  _Stat("LipSync", "lipSync", (a) => "${a.avatarStats.lipSync}"),
  _Stat("カメラ数", "cameraCount",
      (a) => a.avatarStats.cameraCount?.toString() ?? "-"),
];

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

  Widget _row(_Stat stat, TextStyle labelStyle) {
    final color = widget.stale
        ? _invalidColor
        : _ratingColor(stat.rating(widget.analysis, widget.isPc));
    final limits = stat.limits(widget.isPc);
    final value = Text(stat.value(widget.analysis),
        style: _valueStyle.copyWith(color: color ?? labelStyle.color));
    return Row(mainAxisSize: MainAxisSize.min, children: [
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
        for (final stat in _stats) _row(stat, _labelStyle),
        InkWell(
          onTap: () => setState(() => _extraExpanded = !_extraExpanded),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(_extraExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                size: 16),
            const Text("参考情報", style: _titleStyle),
          ]),
        ),
        if (_extraExpanded)
          for (final stat in _extraStats) _row(stat, _extraLabelStyle),
      ],
    );
  }
}
