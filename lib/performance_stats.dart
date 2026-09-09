import 'package:collection/collection.dart';
import 'package:filesize/filesize.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

const _mb = 1024 * 1024;

String _size(int bytes) => filesize(bytes, 1).replaceAll(" ", "");

String _bool(bool v) => v ? "はい" : "いいえ";

num _flag(bool v) => v ? 1 : 0;

enum StatCategory {
  summary("サマリ"),
  geometry("ジオメトリ"),
  dynamics("PhysBone とコンストレイント"),
  components("コンポーネントとエフェクト"),
  other("その他");

  const StatCategory(this.label);
  final String label;
}

class PerformanceStat {
  const PerformanceStat(
      this.key, this.category, this.label, this.tooltip, this.value,
      {this.metric,
      this.pc,
      this.android,
      this.rate,
      this.limitsList,
      this.limitFormat,
      this.unit = '',
      this.scale = 1,
      this.isBool = false});

  final String key;
  final StatCategory category;
  final String label;
  final String tooltip;
  final String unit;
  final num scale;
  final bool isBool;

  bool get rankable =>
      rate != null || (metric != null && (pc != null || android != null));
  bool rankableOn(bool isPc) =>
      rate != null || (metric != null && (isPc ? pc : android) != null);
  bool get filterable => rankable || metric != null;
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

final performanceStats = <PerformanceStat>[
  PerformanceStat("totalPolygons", StatCategory.summary, "三角ポリゴンの数",
      "Triangles", (a) => "${a.avatarStats.totalPolygons}",
      metric: (a) => a.avatarStats.totalPolygons,
      pc: [32000, 70000, 70000, 70000],
      android: [7500, 10000, 15000, 20000]),
  PerformanceStat("bounds", StatCategory.geometry, "範囲 (Bounds)", "Bounds Size",
      (a) => a.avatarStats.bounds.map((v) => v.toStringAsFixed(2)).join("x"),
      rate: (a) => _boundsRating(a.avatarStats.bounds),
      limitsList: _boundsLimitsList),
  PerformanceStat("skinnedMeshCount", StatCategory.geometry, "スキンドメッシュの数",
      "Skinned Meshes", (a) => "${a.avatarStats.skinnedMeshCount}",
      metric: (a) => a.avatarStats.skinnedMeshCount,
      pc: [1, 2, 8, 16],
      android: [1, 1, 2, 2]),
  PerformanceStat("meshCount", StatCategory.geometry, "基本メッシュの数",
      "Basic Meshes", (a) => "${a.avatarStats.meshCount}",
      metric: (a) => a.avatarStats.meshCount,
      pc: [4, 8, 16, 24],
      android: [1, 1, 2, 2]),
  PerformanceStat("materialSlotsUsed", StatCategory.geometry, "マテリアルスロットの数",
      "Material Slots", (a) => "${a.avatarStats.materialSlotsUsed}",
      metric: (a) => a.avatarStats.materialSlotsUsed,
      pc: [4, 8, 16, 32],
      android: [1, 1, 2, 4]),
  PerformanceStat("boneCount", StatCategory.geometry, "ボーンの数", "Bones",
      (a) => "${a.avatarStats.boneCount}",
      metric: (a) => a.avatarStats.boneCount,
      pc: [75, 150, 256, 400],
      android: [75, 90, 150, 150]),
  PerformanceStat("totalTextureUsage", StatCategory.summary, "テクスチャメモリー",
      "Texture Memory", (a) => _size(a.avatarStats.totalTextureUsage),
      metric: (a) => a.avatarStats.totalTextureUsage,
      pc: [40 * _mb, 75 * _mb, 110 * _mb, 150 * _mb],
      android: [10 * _mb, 18 * _mb, 25 * _mb, 40 * _mb],
      limitFormat: (v) => _size(v.toInt()),
      unit: 'MB',
      scale: _mb),
  PerformanceStat("fileSize", StatCategory.summary, "ダウンロードサイズ", "fileSize",
      (a) => _size(a.fileSize),
      metric: (a) => a.fileSize, unit: 'MB', scale: _mb),
  PerformanceStat("uncompressedSize", StatCategory.summary, "非圧縮サイズ",
      "uncompressedSize", (a) => _size(a.uncompressedSize),
      metric: (a) => a.uncompressedSize, unit: 'MB', scale: _mb),
  PerformanceStat(
      "physBoneComponentCount",
      StatCategory.dynamics,
      "PhysBone コンポーネントの数",
      "PhysBones Components",
      (a) => "${a.avatarStats.physBoneComponentCount}",
      metric: (a) => a.avatarStats.physBoneComponentCount,
      pc: [4, 8, 16, 32],
      android: [0, 4, 6, 8]),
  PerformanceStat(
      "physBoneTransformCount",
      StatCategory.dynamics,
      "PhysBone トランスフォームの数",
      "PhysBones Affected Transforms",
      (a) => "${a.avatarStats.physBoneTransformCount}",
      metric: (a) => a.avatarStats.physBoneTransformCount,
      pc: [16, 64, 128, 256],
      android: [0, 16, 32, 64]),
  PerformanceStat(
      "physBoneColliderCount",
      StatCategory.dynamics,
      "PhysBone コライダーの数",
      "PhysBones Colliders",
      (a) => "${a.avatarStats.physBoneColliderCount}",
      metric: (a) => a.avatarStats.physBoneColliderCount,
      pc: [4, 8, 16, 32],
      android: [0, 4, 8, 16]),
  PerformanceStat(
      "physBoneCollisionCheckCount",
      StatCategory.dynamics,
      "PhysBone 衝突チェックの数",
      "PhysBones Collision Check Count",
      (a) => "${a.avatarStats.physBoneCollisionCheckCount}",
      metric: (a) => a.avatarStats.physBoneCollisionCheckCount,
      pc: [32, 128, 256, 512],
      android: [0, 16, 32, 64]),
  PerformanceStat("contactCount", StatCategory.dynamics, "コンタクトの数", "Contacts",
      (a) => "${a.avatarStats.contactCount}",
      metric: (a) => a.avatarStats.contactCount,
      pc: [8, 16, 24, 32],
      android: [2, 4, 8, 16]),
  PerformanceStat("constraintCount", StatCategory.dynamics, "コンストレイントの数",
      "Constraint Count", (a) => "${a.avatarStats.constraintCount}",
      metric: (a) => a.avatarStats.constraintCount,
      pc: [100, 250, 300, 350],
      android: [30, 60, 120, 150]),
  PerformanceStat("constraintDepth", StatCategory.dynamics, "コンストレイントの深さ",
      "Constraint Depth", (a) => "${a.avatarStats.constraintDepth}",
      metric: (a) => a.avatarStats.constraintDepth,
      pc: [20, 50, 80, 100],
      android: [5, 15, 35, 50]),
  PerformanceStat("animatorCount", StatCategory.components, "アニメーターの数",
      "Animators", (a) => "${a.avatarStats.animatorCount}",
      metric: (a) => a.avatarStats.animatorCount,
      pc: [1, 4, 16, 32],
      android: [1, 1, 1, 2]),
  PerformanceStat(
      "particleSystemCount",
      StatCategory.components,
      "パーティクルシステムの数",
      "Particle Systems",
      (a) => "${a.avatarStats.particleSystemCount}",
      metric: (a) => a.avatarStats.particleSystemCount,
      pc: [0, 4, 8, 16],
      android: [0, 0, 0, 2]),
  PerformanceStat("totalMaxParticles", StatCategory.components, "最大パーティクルの数",
      "Total Particles Active", (a) => "${a.avatarStats.totalMaxParticles}",
      metric: (a) => a.avatarStats.totalMaxParticles,
      pc: [0, 300, 1000, 2500],
      android: [0, 0, 0, 200]),
  PerformanceStat(
      "meshParticleMaxPolygons",
      StatCategory.components,
      "メッシュパーティクルの三角ポリゴン数",
      "Mesh Particle Active Polys",
      (a) => "${a.avatarStats.meshParticleMaxPolygons}",
      metric: (a) => a.avatarStats.meshParticleMaxPolygons,
      pc: [0, 1000, 2000, 5000],
      android: [0, 0, 0, 400]),
  PerformanceStat("lightCount", StatCategory.components, "ライトの数", "Lights",
      (a) => "${a.avatarStats.lightCount}",
      metric: (a) => a.avatarStats.lightCount, pc: [0, 0, 0, 1]),
  PerformanceStat("audioSourceCount", StatCategory.components, "オーディオソースの数",
      "Audio Sources", (a) => "${a.avatarStats.audioSourceCount}",
      metric: (a) => a.avatarStats.audioSourceCount, pc: [1, 4, 8, 8]),
  PerformanceStat("raycastCount", StatCategory.components, "レイキャストの数",
      "Raycasts", (a) => a.avatarStats.raycastCount?.toString() ?? "-",
      metric: (a) => a.avatarStats.raycastCount ?? 0,
      pc: [1, 4, 8, 15],
      android: [1, 2, 4, 8]),
  PerformanceStat("clothCount", StatCategory.components, "Cloth メッシュの数",
      "Cloths", (a) => "${a.avatarStats.clothCount}",
      metric: (a) => a.avatarStats.clothCount, pc: [0, 1, 1, 1]),
  PerformanceStat(
      "totalClothVertices",
      StatCategory.components,
      "Cloth の最大頂点の数",
      "Total Cloth Vertices",
      (a) => "${a.avatarStats.totalClothVertices}",
      metric: (a) => a.avatarStats.totalClothVertices,
      pc: [0, 50, 100, 200]),
  PerformanceStat("trailRendererCount", StatCategory.components, "トレイルレンダラーの数",
      "Trail Renderers", (a) => "${a.avatarStats.trailRendererCount}",
      metric: (a) => a.avatarStats.trailRendererCount,
      pc: [1, 2, 4, 8],
      android: [0, 0, 0, 1]),
  PerformanceStat("lineRendererCount", StatCategory.components, "ラインレンダラーの数",
      "Line Renderers", (a) => "${a.avatarStats.lineRendererCount}",
      metric: (a) => a.avatarStats.lineRendererCount,
      pc: [1, 2, 4, 8],
      android: [0, 0, 0, 1]),
  PerformanceStat("physicsColliders", StatCategory.components, "コライダーの数",
      "Physics Colliders", (a) => "${a.avatarStats.physicsColliders}",
      metric: (a) => a.avatarStats.physicsColliders, pc: [0, 1, 8, 8]),
  PerformanceStat("physicsRigidbodies", StatCategory.components, "リジッドボディの数",
      "Physics Rigidbodies", (a) => "${a.avatarStats.physicsRigidbodies}",
      metric: (a) => a.avatarStats.physicsRigidbodies, pc: [0, 1, 8, 8]),
  PerformanceStat(
      "particleTrailsEnabled",
      StatCategory.components,
      "パーティクルトレイル",
      "Particle Trails Enabled",
      (a) => _bool(a.avatarStats.particleTrailsEnabled),
      metric: (a) => _flag(a.avatarStats.particleTrailsEnabled),
      isBool: true,
      pc: [0, 0, 1, 1],
      android: [0, 0, 0, 1],
      limitFormat: (v) => _bool(v != 0)),
  PerformanceStat(
      "particleCollisionEnabled",
      StatCategory.components,
      "パーティクルの衝突",
      "Particle Collision Enabled",
      (a) => _bool(a.avatarStats.particleCollisionEnabled),
      metric: (a) => _flag(a.avatarStats.particleCollisionEnabled),
      isBool: true,
      pc: [0, 0, 1, 1],
      android: [0, 0, 0, 1],
      limitFormat: (v) => _bool(v != 0)),
];

final extraPerformanceStats = <PerformanceStat>[
  PerformanceStat("totalVertices", StatCategory.other, "頂点の数", "totalVertices",
      (a) => "${a.avatarStats.totalVertices}",
      metric: (a) => a.avatarStats.totalVertices),
  PerformanceStat("blendShapeCount", StatCategory.other, "ブレンドシェイプの数",
      "blendShapeCount", (a) => "${a.avatarStats.blendShapeCount}",
      metric: (a) => a.avatarStats.blendShapeCount),
  PerformanceStat("materialCount", StatCategory.other, "マテリアル数",
      "materialCount", (a) => "${a.avatarStats.materialCount}",
      metric: (a) => a.avatarStats.materialCount),
  PerformanceStat(
      "skinnedMeshVertices",
      StatCategory.other,
      "SkinnedMeshRenderer頂点数",
      "skinnedMeshVertices",
      (a) => "${a.avatarStats.skinnedMeshVertices}",
      metric: (a) => a.avatarStats.skinnedMeshVertices),
  PerformanceStat("meshVertices", StatCategory.other, "MeshRenderer頂点数",
      "meshVertices", (a) => "${a.avatarStats.meshVertices}",
      metric: (a) => a.avatarStats.meshVertices),
  PerformanceStat(
      "skinnedMeshPolygons",
      StatCategory.other,
      "SkinnedMeshRendererポリゴン数",
      "skinnedMeshPolygons",
      (a) => "${a.avatarStats.skinnedMeshPolygons}",
      metric: (a) => a.avatarStats.skinnedMeshPolygons),
  PerformanceStat("meshPolygons", StatCategory.other, "MeshRendererポリゴン数",
      "meshPolygons", (a) => "${a.avatarStats.meshPolygons}",
      metric: (a) => a.avatarStats.meshPolygons),
  PerformanceStat("totalIndices", StatCategory.other, "インデックス数", "totalIndices",
      (a) => "${a.avatarStats.totalIndices}",
      metric: (a) => a.avatarStats.totalIndices),
  PerformanceStat(
      "skinnedMeshIndices",
      StatCategory.other,
      "SkinnedMeshRendererインデックス数",
      "skinnedMeshIndices",
      (a) => "${a.avatarStats.skinnedMeshIndices}",
      metric: (a) => a.avatarStats.skinnedMeshIndices),
  PerformanceStat("meshIndices", StatCategory.other, "MeshRendererインデックス数",
      "meshIndices", (a) => "${a.avatarStats.meshIndices}",
      metric: (a) => a.avatarStats.meshIndices),
  PerformanceStat("writeDefaultsUsed", StatCategory.other, "Write Defaults使用",
      "writeDefaultsUsed", (a) => _bool(a.avatarStats.writeDefaultsUsed),
      metric: (a) => _flag(a.avatarStats.writeDefaultsUsed), isBool: true),
  PerformanceStat("customExpressions", StatCategory.other, "Custom Expressions",
      "customExpressions", (a) => _bool(a.avatarStats.customExpressions),
      metric: (a) => _flag(a.avatarStats.customExpressions), isBool: true),
  PerformanceStat(
      "customizeAnimationLayers",
      StatCategory.other,
      "Customize Animation Layers",
      "customizeAnimationLayers",
      (a) => _bool(a.avatarStats.customizeAnimationLayers),
      metric: (a) => _flag(a.avatarStats.customizeAnimationLayers),
      isBool: true),
  PerformanceStat("enableEyeLook", StatCategory.other, "Eye Look有効",
      "enableEyeLook", (a) => _bool(a.avatarStats.enableEyeLook),
      metric: (a) => _flag(a.avatarStats.enableEyeLook), isBool: true),
  PerformanceStat("lipSync", StatCategory.other, "LipSync", "lipSync",
      (a) => "${a.avatarStats.lipSync}",
      metric: (a) => a.avatarStats.lipSync),
  PerformanceStat("cameraCount", StatCategory.other, "カメラ数", "cameraCount",
      (a) => a.avatarStats.cameraCount?.toString() ?? "-",
      metric: (a) => a.avatarStats.cameraCount ?? 0),
];

final filterablePerformanceStats = [
  ...performanceStats,
  ...extraPerformanceStats
].where((s) => s.filterable).toList();

PerformanceStat? performanceStatByKey(String key) =>
    filterablePerformanceStats.where((s) => s.key == key).firstOrNull;

List<PerformanceStat> statsIn(
        Iterable<PerformanceStat> stats, StatCategory category) =>
    stats.where((s) => s.category == category).toList();
