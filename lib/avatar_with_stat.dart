import 'package:vrc_avatar_manager/avatar_stat.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:collection/collection.dart';

final _minDatetime = DateTime(2000);

// high num high priority
int _variantOrder(String? variant) {
  switch (variant) {
    case "security":
      return 9;
    case "standard":
    case null: // maybe same as standard?
      return 2;
    case "impostor":
      return 1;
    default:
      throw Exception("Unknown variant: $variant");
    // return 0;
  }
}

final _unityVersionPatchMarks = {
  "p": 30,
  "f": 20,
  "a": 10,
  "b": 0,
};
final _unityVersionPattern = RegExp(r"^(\d+)\.(\d+)\.(\d+)([pfab])(\d+)$");

int _unityVersionOrder(UnityPackage up) {
  var m = _unityVersionPattern.firstMatch(up.unityVersion);
  if (m == null) {
    throw Exception("Unknown unity version: ${up.unityVersion}");
  }
  // 5.6.3p1 -> 50603010
  // 2017.4.15f1 -> 20170415000
  // so...
  return int.parse(m.group(1)!) * 10000000 +
      int.parse(m.group(2)!) * 100000 +
      int.parse(m.group(3)!) * 1000 +
      _unityVersionPatchMarks[m.group(4)!]! +
      int.parse(m.group(5)!);
}

class AvatarWithStat {
  AvatarWithStat(this.avatar) {
    var ups = avatar.unityPackages.sorted((a, b) {
      final uv = _unityVersionOrder(a).compareTo(_unityVersionOrder(b));
      if (uv != 0) return -uv;
      final ca =
          (a.createdAt ?? _minDatetime).compareTo(b.createdAt ?? _minDatetime);
      if (ca != 0) return -ca;
      final vo = _variantOrder(a.variant).compareTo(_variantOrder(b.variant));
      return -vo;
    }).toList();
    pc = AvatarStat(
        main: ups.firstWhereOrNull((u) =>
            u.platform == "standalonewindows" && u.variant != "impostor"),
        impostor: ups.firstWhereOrNull((u) =>
            u.platform == "standalonewindows" && u.variant == "impostor"));
    android = AvatarStat(
        main: ups.firstWhereOrNull(
            (u) => u.platform == "android" && u.variant != "impostor"),
        impostor: ups.firstWhereOrNull(
            (u) => u.platform == "android" && u.variant == "impostor"));
  }

  final Avatar avatar;

  late final AvatarStat pc;
  late final AvatarStat android;

  bool get hasPc => pc.hasMain;
  bool get hasAndroid => android.hasMain;
  bool get hasCrossPlatform => hasPc && hasAndroid;
  bool get hasImpostor => pc.hasImpostor || android.hasImpostor;

  String get id => avatar.id;
  String get name => avatar.name;
  String get desctipion => avatar.description;
  String get thumbnailImageUrl => avatar.thumbnailImageUrl;
  ReleaseStatus get releaseStatus => avatar.releaseStatus;
  DateTime get createdAt => avatar.createdAt;
  DateTime get updatedAt => avatar.updatedAt;
  int get version => avatar.version;

  bool hasUnityPackageIdInMain(Iterable<String> ids) =>
      pc.hasMain && ids.contains(pc.main!.id) ||
      android.hasMain && ids.contains(android.main!.id);
  List<String> get mainUnityPackageIds =>
      [if (pc.hasMain) pc.main!.id, if (android.hasMain) android.main!.id];
}
