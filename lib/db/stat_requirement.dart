import 'package:isar/isar.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

part 'stat_requirement.g.dart';

@embedded
class StatRequirement {
  String stat = '';
  @enumerated
  List<PerformanceRatings> ignorePc = [];
  @enumerated
  List<PerformanceRatings> ignoreAndroid = [];
  double? minPc;
  double? maxPc;
  double? minAndroid;
  double? maxAndroid;

  StatRequirement copy() => StatRequirement()
    ..stat = stat
    ..ignorePc = ignorePc.toList()
    ..ignoreAndroid = ignoreAndroid.toList()
    ..minPc = minPc
    ..maxPc = maxPc
    ..minAndroid = minAndroid
    ..maxAndroid = maxAndroid;
}
