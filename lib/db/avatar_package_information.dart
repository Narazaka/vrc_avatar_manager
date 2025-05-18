import 'package:isar/isar.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information_like.dart';

part 'avatar_package_information.g.dart';

@Collection(ignore: {"avatarId", "platform"})
class AvatarPackageInformation implements AvatarPackageInformationLike {
  @override
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  @override
  late String unityPackageId;
  @override
  late int version;
  @override
  late int size;

  @override
  String avatarId = "";
  @override
  String platform = "";

  @override
  String toString() {
    return 'AvatarPackageInformation{unityPackageId: $unityPackageId, version: $version, size: $size}';
  }
}
