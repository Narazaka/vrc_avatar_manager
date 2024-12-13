import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:vrc_avatar_manager/avatar_with_stat.dart';
import 'package:vrc_avatar_manager/db/tag_avatar.dart';
import 'package:vrc_avatar_manager/db/tag_target.dart';
import 'package:vrc_avatar_manager/db/tag_type.dart';
import 'package:collection/collection.dart';
import 'package:vrc_avatar_manager/db/tags_db.dart';
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

  @ignore
  bool get hasRequirements =>
      hasPlatformRequirements || hasPerformanceRequirements;

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
    caseSensitive = false;
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

  Iterable<AvatarWithStat> filterAvatars(Iterable<AvatarWithStat> avatars) {
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
        var contains = _genSimpleFilter();
        return avatars.where((avatar) => contains(pick(avatar)));
      case TagType.regexp:
        final requirementsFilter = _genRequirementsFilter();
        avatars = avatars.where(requirementsFilter);
        if (search.isEmpty) {
          return avatars;
        }
        var pick = _genPick();
        var contains = _genRegexpFilter();
        return avatars.where((avatar) => contains(pick(avatar)));
    }
  }

  String Function(AvatarWithStat) _genPick() => switch (target) {
        TagTarget.name => (AvatarWithStat avatar) => avatar.name,
        TagTarget.description => (AvatarWithStat avatar) =>
            avatar.avatar.description,
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
    var regexp = RegExp(search, caseSensitive: caseSensitive);
    return invert
        ? (String s) => !regexp.hasMatch(s)
        : (String s) => regexp.hasMatch(s);
  }

  bool Function(AvatarWithStat) _genRequirementsFilter() {
    if (!hasRequirements) {
      return (AvatarWithStat avatar) => true;
    }
    var platformFilter = _genPlatformRequirementsFilter();
    var performanceFilter = _genPerformanceRequirementsFilter();
    if (platformFilter != null && performanceFilter != null) {
      return (AvatarWithStat avatar) =>
          platformFilter(avatar) && performanceFilter(avatar);
    } else if (platformFilter != null) {
      return platformFilter;
    } else {
      return performanceFilter!;
    }
  }

  bool Function(AvatarWithStat)? _genPlatformRequirementsFilter() {
    if (!hasPlatformRequirements) {
      return null;
    }
    if (requirePc && requireAndroid) {
      return (AvatarWithStat avatar) => avatar.hasCrossPlatform;
    } else if (requirePc) {
      return (AvatarWithStat avatar) => avatar.hasPc;
    } else {
      return (AvatarWithStat avatar) => avatar.hasAndroid;
    }
  }

  bool Function(AvatarWithStat)? _genPerformanceRequirementsFilter() {
    if (!hasPerformanceRequirements) {
      return null;
    }
    var ignorePc = ignorePcPerformanceRatings.toSet();
    var ignoreAndroid = ignoreAndroidPerformanceRatings.toSet();
    if (ignorePc.isNotEmpty && ignoreAndroid.isNotEmpty) {
      return (AvatarWithStat avatar) =>
          (avatar.pc.performanceRating == null ||
              !ignorePc.contains(avatar.pc.performanceRating)) &&
          (avatar.android.performanceRating == null ||
              !ignoreAndroid.contains(avatar.android.performanceRating));
    } else if (ignorePc.isNotEmpty) {
      return (AvatarWithStat avatar) =>
          avatar.pc.performanceRating == null ||
          !ignorePc.contains(avatar.pc.performanceRating);
    } else {
      return (AvatarWithStat avatar) =>
          avatar.android.performanceRating == null ||
          !ignoreAndroid.contains(avatar.android.performanceRating);
    }
  }
}
