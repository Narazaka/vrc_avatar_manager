import 'package:flutter/material.dart';
import 'package:glob/glob.dart';
import 'package:isar/isar.dart';
import 'package:vrc_avatar_manager/avatar_with_stat.dart';
import 'package:vrc_avatar_manager/db/condition_combinator.dart';
import 'package:vrc_avatar_manager/db/condition_match_type.dart';
import 'package:vrc_avatar_manager/db/tag_avatar.dart';
import 'package:vrc_avatar_manager/db/tag_condition.dart';
import 'package:vrc_avatar_manager/db/tag_condition_group.dart';
import 'package:vrc_avatar_manager/db/tag_target.dart';
import 'package:vrc_avatar_manager/db/tag_filter_context.dart';
import 'package:vrc_avatar_manager/db/tag_type.dart';
import 'package:collection/collection.dart';
import 'package:vrc_avatar_manager/db/tags_db.dart';
import 'package:vrc_avatar_manager/imposter.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

part 'tag.g.dart';

@collection
class Tag {
  static const Color defaultColor =
      Color(0xFF466D97); // Colors.blue seed theme primary value
  static const Color defaultInactiveColor = Color(0xFFFFFFFF);

  Id id = Isar.autoIncrement;

  int order = 0;

  int groupId = 0;

  bool requirePc = false;

  bool requireAndroid = false;

  @enumerated
  List<PerformanceRatings> ignorePcPerformanceRatings = [];

  @enumerated
  List<PerformanceRatings> ignoreAndroidPerformanceRatings = [];

  @ignore
  bool get hasPlatformRequirements => requirePc || requireAndroid;

  @ignore
  bool get hasPerformanceRequirements =>
      ignorePcPerformanceRatings.isNotEmpty ||
      ignoreAndroidPerformanceRatings.isNotEmpty;

  @enumerated
  FilterByImposter imposter = FilterByImposter.none;

  @ignore
  bool get hasRequirements =>
      hasPlatformRequirements ||
      hasPerformanceRequirements ||
      imposter != FilterByImposter.none;

  late String name;

  int color = defaultColor.value;

  @ignore
  int get validColor => color <= 0 ? defaultColor.value : color;

  int inactiveColor = defaultInactiveColor.value;

  @ignore
  int get validInactiveColor =>
      inactiveColor <= 0 ? defaultInactiveColor.value : inactiveColor;

  @enumerated
  late TagType type;

  @enumerated
  late TagTarget target;

  late String search;

  bool invert = false;

  bool caseSensitive = false;

  @enumerated
  ConditionCombinator groupCombinator = ConditionCombinator.and;
  List<TagConditionGroup> conditionGroups = [];

  @Backlink(to: 'tags')
  final tagAvatars = IsarLinks<TagAvatar>();

  @ignore
  Set<String> get avatarIds => tagAvatars.map((e) => e.avatarId).toSet();

  void init(String name, TagType type, TagTarget target, String search,
      bool caseSensitive) {
    this.name = name;
    this.type = type;
    this.target = target;
    this.search = search;
    this.caseSensitive = caseSensitive;
  }

  void empty() {
    name = "";
    color = defaultColor.value;
    inactiveColor = defaultInactiveColor.value;
    type = TagType.items;
    target = TagTarget.name;
    search = "";
    invert = false;
    caseSensitive = false;
    groupCombinator = ConditionCombinator.and;
    conditionGroups = [];
    requirePc = false;
    requireAndroid = false;
    ignorePcPerformanceRatings = [];
    ignoreAndroidPerformanceRatings = [];
    imposter = FilterByImposter.none;
  }

  void copyRequirementsFrom(Tag other) {
    requirePc = other.requirePc;
    requireAndroid = other.requireAndroid;
    ignorePcPerformanceRatings = other.ignorePcPerformanceRatings.toList();
    ignoreAndroidPerformanceRatings =
        other.ignoreAndroidPerformanceRatings.toList();
    imposter = other.imposter;
  }

  Future<void> toggleAvatar(String avatarId, TagsDb tagsDb) async {
    var tagAvatar =
        tagAvatars.firstWhereOrNull((ta) => ta.avatarId == avatarId);
    if (tagAvatar == null) {
      tagAvatar = await tagsDb.findOrCreateTagAvatar(avatarId);
      tagAvatars.add(tagAvatar);
    } else {
      tagAvatars.remove(tagAvatar);
    }
    await tagsDb.putLinked(this, tagAvatar);
  }

  bool hasAllAvatars(Iterable<String> avatarIds) {
    var existAvatarIds = tagAvatars.map((ta) => ta.avatarId).toSet();
    return existAvatarIds.containsAll(avatarIds);
  }

  Future<void> addAvatars(Iterable<String> avatarIds, TagsDb tagsDb) async {
    var targetTagAvatars = await tagsDb.findOrCreateTagAvatars(avatarIds);
    tagAvatars.addAll(targetTagAvatars);
    await tagsDb.putLinkedAll(this, targetTagAvatars);
  }

  Future<void> removeAvatars(Iterable<String> avatarIds, TagsDb tagsDb) async {
    var targetTagAvatars = await tagsDb.findTagAvatars(avatarIds);
    tagAvatars.removeAll(targetTagAvatars);
    await tagsDb.putLinkedAll(this, targetTagAvatars);
  }

  Iterable<AvatarWithStat> filterAvatars(Iterable<AvatarWithStat> avatars, {TagFilterContext? context}) {
    switch (type) {
      case TagType.items:
        var ids = avatarIds;
        return avatars.where((avatar) => ids.contains(avatar.id));
      case TagType.simple:
        final requirementsFilter = _genRequirementsFilter();
        avatars = avatars.where(requirementsFilter);
        if (search.isEmpty) {
          return avatars;
        }
        var pick = _genPick();
        var matches = _genSimpleFilter();
        return avatars.where((avatar) => pick(avatar).any(matches));
      case TagType.regexp:
        final requirementsFilter = _genRequirementsFilter();
        avatars = avatars.where(requirementsFilter);
        if (search.isEmpty) {
          return avatars;
        }
        var pick = _genPick();
        var matches = _genRegexpFilter();
        return avatars.where((avatar) => pick(avatar).any(matches));
      case TagType.wildcard:
        final requirementsFilter = _genRequirementsFilter();
        avatars = avatars.where(requirementsFilter);
        if (search.isEmpty) {
          return avatars;
        }
        var pick = _genPick();
        var matches = _genWildcardFilter();
        return avatars.where((avatar) => pick(avatar).any(matches));
      case TagType.conditions:
        final requirementsFilter = _genRequirementsFilter();
        avatars = avatars.where(requirementsFilter);
        if (conditionGroups.isEmpty) return avatars;
        return avatars.where((avatar) => _matchesConditions(avatar, context));
    }
  }

  List<String> Function(AvatarWithStat) _genPick() => switch (target) {
        TagTarget.name => (AvatarWithStat avatar) => [avatar.name],
        TagTarget.description => (AvatarWithStat avatar) =>
            [avatar.avatar.description],
        TagTarget.nameOrDescription => (AvatarWithStat avatar) =>
            [avatar.name, avatar.avatar.description],
      };

  bool Function(String) _genSimpleFilter() {
    if (caseSensitive) {
      return invert
          ? (String s) => !s.contains(search)
          : (String s) => s.contains(search);
    } else {
      var lowerSearch = search.toLowerCase();
      return invert
          ? (String s) => !s.toLowerCase().contains(lowerSearch)
          : (String s) => s.toLowerCase().contains(lowerSearch);
    }
  }

  bool Function(String) _genRegexpFilter() {
    try {
      var regexp = RegExp(search, caseSensitive: caseSensitive);
      return invert
          ? (String s) => !regexp.hasMatch(s)
          : (String s) => regexp.hasMatch(s);
    } catch (e) {
      print("regexp error: $e");
      return (String s) => false;
    }
  }

  bool Function(String) _genWildcardFilter() {
    try {
      var glob = Glob(search, caseSensitive: caseSensitive);
      return invert
          ? (String s) => !glob.matches(s)
          : (String s) => glob.matches(s);
    } catch (e) {
      print("wildcard error: $e");
      return (String s) => false;
    }
  }

  bool Function(AvatarWithStat) _genRequirementsFilter() {
    final ignorePc = ignorePcPerformanceRatings.toSet();
    final ignoreAndroid = ignoreAndroidPerformanceRatings.toSet();
    final filters = <bool Function(AvatarWithStat)>[
      if (requirePc && requireAndroid)
        (avatar) => avatar.hasCrossPlatform
      else if (requirePc)
        (avatar) => avatar.hasPc
      else if (requireAndroid)
        (avatar) => avatar.hasAndroid,
      if (ignorePc.isNotEmpty)
        (avatar) =>
            avatar.pc.performanceRating == null ||
            !ignorePc.contains(avatar.pc.performanceRating),
      if (ignoreAndroid.isNotEmpty)
        (avatar) =>
            avatar.android.performanceRating == null ||
            !ignoreAndroid.contains(avatar.android.performanceRating),
      if (imposter == FilterByImposter.haveImposter)
        (avatar) => avatar.hasImpostor
      else if (imposter == FilterByImposter.notHaveImposter)
        (avatar) => !avatar.hasImpostor,
    ];
    return (avatar) => filters.every((f) => f(avatar));
  }

  // --- conditions matching ---

  bool _matchesConditions(AvatarWithStat avatar, TagFilterContext? context) {
    switch (groupCombinator) {
      case ConditionCombinator.and:
        // CNF: all groups must pass, within each group any condition passes (OR)
        return conditionGroups.every((group) => _matchesGroupOr(avatar, group, context));
      case ConditionCombinator.or:
        // DNF: any group must pass, within each group all conditions pass (AND)
        return conditionGroups.any((group) => _matchesGroupAnd(avatar, group, context));
    }
  }

  bool _matchesGroupOr(AvatarWithStat avatar, TagConditionGroup group, TagFilterContext? context) {
    if (group.conditions.isEmpty) return true;
    return group.conditions.any((cond) => _matchesCondition(avatar, cond, context));
  }

  bool _matchesGroupAnd(AvatarWithStat avatar, TagConditionGroup group, TagFilterContext? context) {
    if (group.conditions.isEmpty) return true;
    return group.conditions.every((cond) => _matchesCondition(avatar, cond, context));
  }

  bool _matchesCondition(AvatarWithStat avatar, TagCondition cond, TagFilterContext? context) {
    if (cond.matchType == ConditionMatchType.matchesTag) {
      final tagId = int.tryParse(cond.search);
      if (tagId == null || context == null) return cond.invert;
      final matchedIds = context.resolveTagMatchSet(tagId);
      final matched = matchedIds.contains(avatar.id);
      return cond.invert ? !matched : matched;
    }

    final fields = switch (cond.target) {
      TagTarget.name => [avatar.name],
      TagTarget.description => [avatar.avatar.description],
      TagTarget.nameOrDescription => [avatar.name, avatar.avatar.description],
    };
    final filter = switch (cond.matchType) {
      ConditionMatchType.contains => _conditionStringFilter(cond, (s, q) => s.contains(q)),
      ConditionMatchType.startsWith => _conditionStringFilter(cond, (s, q) => s.startsWith(q)),
      ConditionMatchType.endsWith => _conditionStringFilter(cond, (s, q) => s.endsWith(q)),
      ConditionMatchType.exact => _conditionStringFilter(cond, (s, q) => s == q),
      ConditionMatchType.wildcard => _conditionWildcardFilter(cond),
      ConditionMatchType.regexp => _conditionRegexpFilter(cond),
      ConditionMatchType.matchesTag => throw StateError('unreachable'),
    };
    final matched = fields.any(filter);
    return cond.invert ? !matched : matched;
  }

  bool Function(String) _conditionStringFilter(
      TagCondition cond, bool Function(String s, String query) matcher) {
    if (cond.caseSensitive) {
      return (String s) => matcher(s, cond.search);
    } else {
      var lowerSearch = cond.search.toLowerCase();
      return (String s) => matcher(s.toLowerCase(), lowerSearch);
    }
  }

  bool Function(String) _conditionWildcardFilter(TagCondition cond) {
    try {
      var glob = Glob(cond.search, caseSensitive: cond.caseSensitive);
      return (String s) => glob.matches(s);
    } catch (e) {
      print("wildcard error: $e");
      return (String s) => false;
    }
  }

  bool Function(String) _conditionRegexpFilter(TagCondition cond) {
    try {
      var regexp = RegExp(cond.search, caseSensitive: cond.caseSensitive);
      return (String s) => regexp.hasMatch(s);
    } catch (e) {
      print("regexp error: $e");
      return (String s) => false;
    }
  }
}
