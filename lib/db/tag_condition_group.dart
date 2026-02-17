import 'package:isar/isar.dart';
import 'package:vrc_avatar_manager/db/tag_condition.dart';

part 'tag_condition_group.g.dart';

@embedded
class TagConditionGroup {
  List<TagCondition> conditions = [];
}
