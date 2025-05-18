import 'package:isar/isar.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information_like.dart';

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

  @override
  String toString() {
    return 'AvatarPackageInformation{avatarId: $avatarId, platform: $platform, unityPackageId: $unityPackageId, version: $version, size: $size}';
  }
}
