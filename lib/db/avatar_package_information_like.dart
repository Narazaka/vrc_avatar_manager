import 'package:isar/isar.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

abstract class AvatarPackageInformationLike {
  late Id id;

  late String avatarId;
  late String platform;
  late String unityPackageId;
  late int version;
  late int size;

  @ignore
  FileAnalysis? get analysis;
}
