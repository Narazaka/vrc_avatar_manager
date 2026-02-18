import 'package:vrc_avatar_manager/avatar_with_stat.dart';
import 'package:vrc_avatar_manager/db/tag.dart';

class TagFilterContext {
  final List<Tag> allTags;
  final List<AvatarWithStat> allAvatars;
  final Map<int, Set<String>> _resolvedTagAvatarIds = {};
  final Set<int> _evaluatingTagIds = {};

  TagFilterContext({required this.allTags, required this.allAvatars});

  Set<String> resolveTagMatchSet(int tagId) {
    final cached = _resolvedTagAvatarIds[tagId];
    if (cached != null) return cached;

    if (_evaluatingTagIds.contains(tagId)) {
      return {};
    }

    final tag = allTags.where((t) => t.id == tagId).firstOrNull;
    if (tag == null) return {};

    _evaluatingTagIds.add(tagId);
    final matched = tag.filterAvatars(allAvatars, context: this).map((a) => a.id).toSet();
    _evaluatingTagIds.remove(tagId);

    _resolvedTagAvatarIds[tagId] = matched;
    return matched;
  }
}
