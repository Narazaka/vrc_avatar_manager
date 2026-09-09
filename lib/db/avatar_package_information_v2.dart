import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information_like.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

part 'avatar_package_information_v2.g.dart';

@collection
class AvatarPackageInformationV2 implements AvatarPackageInformationLike {
  @override
  Id id = Isar.autoIncrement;

  @Index(composite: [CompositeIndex('platform')], unique: true)
  @override
  late String avatarId;
  @override
  late String platform;
  @override
  late String unityPackageId;
  @override
  late int version;
  @override
  late int size;

  String? analysisJson;

  FileAnalysis? _analysis;
  bool _decoded = false;

  @ignore
  @override
  FileAnalysis? get analysis {
    if (_decoded) {
      return _analysis;
    }
    _decoded = true;
    final json = analysisJson;
    if (json == null) {
      return null;
    }
    try {
      _analysis =
          FileAnalysis.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (e) {
      // 復元できなければ未取得扱いにして取り直させる
      print("[AvatarPackageInformationV2] analysis decode failed "
          "($avatarId $platform): $e");
    }
    return _analysis;
  }

  set analysis(FileAnalysis? value) {
    _analysis = value;
    _decoded = true;
    analysisJson = value == null ? null : jsonEncode(value.toJson());
  }

  @override
  String toString() {
    return 'AvatarPackageInformation{avatarId: $avatarId, platform: $platform, unityPackageId: $unityPackageId, version: $version, size: $size}';
  }
}
