import 'dart:io';

import 'package:isar/isar.dart';
import 'package:vrc_avatar_manager/app_dir.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information.dart';
import 'package:vrc_avatar_manager/prefs.dart';

class AvatarPackageInformationDb {
  static AvatarPackageInformationDb? _instance;
  const AvatarPackageInformationDb._(this.isar);

  final Isar isar;

  static Future<AvatarPackageInformationDb> get instance async {
    var dir = "${AppDir.dir}/.avatar_package_informations";
    await Directory(dir).create(recursive: true);
    return _instance ??= AvatarPackageInformationDb._(await Isar.open(
        [AvatarPackageInformationSchema],
        directory: dir, name: 'avatar_package_informations'));
  }

  Future<int> getCount() async {
    return isar.avatarPackageInformations.where().count();
  }

  Future<List<AvatarPackageInformation>> getAll() async {
    return isar.avatarPackageInformations.where().findAll();
  }

  Future<List<AvatarPackageInformation>> getAllByUnitypackageIdVersions(
      Iterable<(String, int)> idVersions) async {
    return isar.avatarPackageInformations
        .where()
        .filter()
        .anyOf(
            idVersions,
            (q, idVersion) => q
                .unityPackageIdEqualTo(idVersion.$1)
                .and()
                .versionEqualTo(idVersion.$2))
        .findAll();
  }

  Future<void> put(AvatarPackageInformation account) async {
    await isar.writeTxn(() async {
      await isar.avatarPackageInformations.putByUnityPackageId(account);
    });
  }

  Future<void> deleteAll(List<String> unityPackageIds) async {
    await isar.writeTxn(() async {
      await isar.avatarPackageInformations
          .deleteAllByUnityPackageId(unityPackageIds);
    });
  }

  Future<void> clear() async {
    await isar.writeTxn(() async {
      await isar.avatarPackageInformations.clear();
    });
  }

  Stream<void> watchAccounts({fireImmediately = false}) {
    return isar.avatarPackageInformations
        .watchLazy(fireImmediately: fireImmediately);
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
