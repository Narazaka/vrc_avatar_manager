import 'package:isar/isar.dart';

part 'avatar_package_information.g.dart';

@collection
class AvatarPackageInformation {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String unityPackageId;
  late int version;
  late int size;

  @override
  String toString() {
    return 'AvatarPackageInformation{unityPackageId: $unityPackageId, version: $version, size: $size}';
  }
}
