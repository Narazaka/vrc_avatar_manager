import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information_v2.dart';

import 'file_analysis_fixture.dart';

AvatarPackageInformationV2 _stored(String? json) => AvatarPackageInformationV2()
  ..avatarId = 'avtr_test'
  ..platform = 'standalonewindows'
  ..unityPackageId = 'unp_test'
  ..version = 1
  ..size = 52428800
  ..analysisJson = json;

void main() {
  test('正常な JSON は型付きで復元される', () {
    final it = _stored(jsonEncode(validFileAnalysisJson()));
    expect(it.analysis!.avatarStats.totalPolygons, 80000);
    expect(it.analysis!.fileSize, 52428800);
    expect(it.analysis!.performanceRating, 'Medium');
  });

  test('analysis setter は JSON に往復できる', () {
    final source = _stored(jsonEncode(validFileAnalysisJson())).analysis!;
    final it = _stored(null)..analysis = source;
    expect(it.analysisJson, isNotNull);
    expect(it.analysis!.avatarStats.physBoneTransformCount, 180);
  });

  test('未取得なら null', () {
    expect(_stored(null).analysis, isNull);
  });

  test('必須項目が消えても落ちずに null', () {
    final json = validFileAnalysisJson();
    (json['avatarStats'] as Map).remove('totalPolygons');
    expect(_stored(jsonEncode(json)).analysis, isNull);
  });

  test('項目の型が変わっても落ちずに null', () {
    final json = validFileAnalysisJson();
    (json['avatarStats'] as Map)['totalPolygons'] = 'とても多い';
    expect(_stored(jsonEncode(json)).analysis, isNull);
  });

  test('avatarStats ごと消えても落ちずに null', () {
    final json = validFileAnalysisJson()..remove('avatarStats');
    expect(_stored(jsonEncode(json)).analysis, isNull);
  });

  test('JSON として壊れていても落ちずに null', () {
    expect(_stored('{壊れている').analysis, isNull);
  });

  test('項目が増えるだけなら復元できる', () {
    final json = validFileAnalysisJson();
    json['someBrandNewField'] = 42;
    (json['avatarStats'] as Map)['someBrandNewStat'] = 42;
    expect(
        _stored(jsonEncode(json)).analysis!.avatarStats.totalPolygons, 80000);
  });

  test('復元結果はキャッシュされ、失敗も繰り返しデコードしない', () {
    final ok = _stored(jsonEncode(validFileAnalysisJson()));
    expect(identical(ok.analysis, ok.analysis), isTrue);

    final ng = _stored('{壊れている');
    expect(ng.analysis, isNull);
    ng.analysisJson = jsonEncode(validFileAnalysisJson()); // 直接書き換えても再デコードしない
    expect(ng.analysis, isNull);
  });
}
