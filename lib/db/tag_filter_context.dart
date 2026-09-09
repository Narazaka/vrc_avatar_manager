import 'package:vrc_avatar_manager/avatar_with_stat.dart';
import 'package:vrc_avatar_manager/db/tag.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class TagFilterContext {
  final List<Tag> allTags;
  final List<AvatarWithStat> allAvatars;
  final FileAnalysis? Function(String avatarId, String platform) analysisOf;
  final Map<int, Set<String>> _resolvedTagAvatarIds = {};
  final Set<int> _evaluatingTagIds = {};

  TagFilterContext(
      {required this.allTags,
      required this.allAvatars,
      this.analysisOf = _noAnalysis});

  static FileAnalysis? _noAnalysis(String avatarId, String platform) => null;

  Set<String> resolveTagMatchSet(int tagId) {
    final cached = _resolvedTagAvatarIds[tagId];
    if (cached != null) return cached;

    if (_evaluatingTagIds.contains(tagId)) {
      return {};
    }

    final tag = allTags.where((t) => t.id == tagId).firstOrNull;
    if (tag == null) return {};

    _evaluatingTagIds.add(tagId);
    final matched =
        tag.filterAvatars(allAvatars, context: this).map((a) => a.id).toSet();
    _evaluatingTagIds.remove(tagId);

    _resolvedTagAvatarIds[tagId] = matched;
    return matched;
  }
}
