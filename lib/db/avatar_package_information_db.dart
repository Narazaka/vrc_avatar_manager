import 'dart:io';

import 'package:isar/isar.dart';
import 'package:vrc_avatar_manager/app_dir.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information_like.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information_v2.dart';
import 'package:vrc_avatar_manager/prefs.dart';

class AvatarPackageInformationDb {
  static AvatarPackageInformationDb? _instance;
  const AvatarPackageInformationDb._(this.isar);

  final Isar isar;

  static Future<AvatarPackageInformationDb> get instance async {
    var dir = "${AppDir.dir}/.avatar_package_informations";
    await Directory(dir).create(recursive: true);
    return _instance ??= AvatarPackageInformationDb._(await Isar.open(
        [AvatarPackageInformationSchema, AvatarPackageInformationV2Schema],
        directory: dir, name: 'avatar_package_informations'));
  }

  Future<int> getCount() async {
    return isar.avatarPackageInformations.where().count();
  }

  Future<List<AvatarPackageInformationLike>> getAllBy(
      Iterable<({String avatarId, String platform, String unityPackageId})>
          ids) async {
    var v2Informations = await isar.avatarPackageInformationV2s
        .where()
        .filter()
        .anyOf(
            ids,
            (q, id) => q
                .avatarIdEqualTo(id.avatarId)
                .and()
                .platformEqualTo(id.platform))
        .findAll();
    var exists = v2Informations.map((v) => (v.avatarId, v.platform)).toSet();
    var avatarByUnityPackageId = {
      for (var v
          in ids.where((id) => !exists.contains((id.avatarId, id.platform))))
        v.unityPackageId: v
    };
    var v1 = await isar.avatarPackageInformations
        .where()
        .filter()
        .anyOf(
            avatarByUnityPackageId.keys, (q, id) => q.unityPackageIdEqualTo(id))
        .findAll();
    for (var v in v1) {
      var id = avatarByUnityPackageId[v.unityPackageId]!;
      v.avatarId = id.avatarId;
      v.platform = id.platform;
    }
    return [...v2Informations, ...v1];
  }

  Future<void> put(AvatarPackageInformationV2 item) async {
    await isar.writeTxn(() async {
      await isar.avatarPackageInformationV2s.putByAvatarIdPlatform(item);
    });
  }

  Future<void> deleteAllV1(List<String> unityPackageIds) async {
    await isar.writeTxn(() async {
      await isar.avatarPackageInformations
          .deleteAllByUnityPackageId(unityPackageIds);
    });
  }

  Future<void> clear() async {
    await isar.writeTxn(() async {
      await isar.avatarPackageInformations.clear();
      await isar.avatarPackageInformationV2s.clear();
    });
  }

  Future<void> migrate() async {
    final prefs = await Prefs.instance;
    final avatarPackageInformationDbUnityPackageSelectBugFixed =
        await prefs.avatarPackageInformationDbUnityPackageSelectBugFixed;
    if (!avatarPackageInformationDbUnityPackageSelectBugFixed &&
        await getCount() == 0) {
      // まっさらなら
      await prefs.setAvatarPackageInformationDbUnityPackageSelectBugFixed(true);
    }
  }
}
