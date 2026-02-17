import 'package:isar/isar.dart';
import 'package:vrc_avatar_manager/db/condition_match_type.dart';
import 'package:vrc_avatar_manager/db/tag_target.dart';

part 'tag_condition.g.dart';

@embedded
class TagCondition {
  @enumerated
  TagTarget target = TagTarget.name;
  @enumerated
  ConditionMatchType matchType = ConditionMatchType.contains;
  String search = '';
  bool invert = false;
  bool caseSensitive = false;
}
