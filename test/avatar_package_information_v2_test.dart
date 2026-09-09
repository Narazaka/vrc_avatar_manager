import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information_v2.dart';

Map<String, dynamic> _validJson() => {
      'avatarStats': {
        'animatorCount': 3,
        'audioSourceCount': 2,
        'blendShapeCount': 412,
        'boneCount': 231,
        'bounds': [1.2, 1.9, 0.7],
        'cameraCount': 0,
        'clothCount': 1,
        'constraintCount': 12,
        'constraintDepth': 3,
        'contactCount': 8,
        'customExpressions': true,
        'customizeAnimationLayers': true,
        'enableEyeLook': true,
        'lightCount': 0,
        'lineRendererCount': 0,
        'lipSync': 1,
        'materialCount': 14,
        'materialSlotsUsed': 18,
        'meshCount': 4,
        'meshIndices': 30000,
        'meshParticleMaxPolygons': 0,
        'meshPolygons': 10000,
        'meshVertices': 12000,
        'particleCollisionEnabled': false,
        'particleSystemCount': 2,
        'particleTrailsEnabled': false,
        'physBoneColliderCount': 9,
        'physBoneCollisionCheckCount': 120,
        'physBoneComponentCount': 24,
        'physBoneTransformCount': 180,
        'physicsColliders': 0,
        'physicsRigidbodies': 0,
        'raycastCount': 0,
        'skinnedMeshCount': 6,
        'skinnedMeshIndices': 210000,
        'skinnedMeshPolygons': 70000,
        'skinnedMeshVertices': 80000,
        'totalClothVertices': 300,
        'totalIndices': 240000,
        'totalMaxParticles': 500,
        'totalPolygons': 80000,
        'totalTextureUsage': 134217728,
        'totalVertices': 92000,
        'trailRendererCount': 0,
        'writeDefaultsUsed': false,
      },
      'created_at': '2026-01-01T00:00:00.000Z',
      'fileSize': 52428800,
      'performanceRating': 'Medium',
      'success': true,
      'uncompressedSize': 157286400,
    };

AvatarPackageInformationV2 _stored(String? json) => AvatarPackageInformationV2()
  ..avatarId = 'avtr_test'
  ..platform = 'standalonewindows'
  ..unityPackageId = 'unp_test'
  ..version = 1
  ..size = 52428800
  ..analysisJson = json;

void main() {
  test('正常な JSON は型付きで復元される', () {
    final it = _stored(jsonEncode(_validJson()));
    expect(it.analysis!.avatarStats.totalPolygons, 80000);
    expect(it.analysis!.fileSize, 52428800);
    expect(it.analysis!.performanceRating, 'Medium');
  });

  test('analysis setter は JSON に往復できる', () {
    final source = _stored(jsonEncode(_validJson())).analysis!;
    final it = _stored(null)..analysis = source;
    expect(it.analysisJson, isNotNull);
    expect(it.analysis!.avatarStats.physBoneTransformCount, 180);
  });

  test('未取得なら null', () {
    expect(_stored(null).analysis, isNull);
  });

  test('必須項目が消えても落ちずに null', () {
    final json = _validJson();
    (json['avatarStats'] as Map).remove('totalPolygons');
    expect(_stored(jsonEncode(json)).analysis, isNull);
  });

  test('項目の型が変わっても落ちずに null', () {
    final json = _validJson();
    (json['avatarStats'] as Map)['totalPolygons'] = 'とても多い';
    expect(_stored(jsonEncode(json)).analysis, isNull);
  });

  test('avatarStats ごと消えても落ちずに null', () {
    final json = _validJson()..remove('avatarStats');
    expect(_stored(jsonEncode(json)).analysis, isNull);
  });

  test('JSON として壊れていても落ちずに null', () {
    expect(_stored('{壊れている').analysis, isNull);
  });

  test('項目が増えるだけなら復元できる', () {
    final json = _validJson();
    json['someBrandNewField'] = 42;
    (json['avatarStats'] as Map)['someBrandNewStat'] = 42;
    expect(
        _stored(jsonEncode(json)).analysis!.avatarStats.totalPolygons, 80000);
  });

  test('復元結果はキャッシュされ、失敗も繰り返しデコードしない', () {
    final ok = _stored(jsonEncode(_validJson()));
    expect(identical(ok.analysis, ok.analysis), isTrue);

    final ng = _stored('{壊れている');
    expect(ng.analysis, isNull);
    ng.analysisJson = jsonEncode(_validJson()); // 直接書き換えても再デコードしない
    expect(ng.analysis, isNull);
  });
}
