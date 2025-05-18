import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrc_avatar_manager/avatar_with_stat.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information_like.dart';
import 'package:vrc_avatar_manager/image_cache_manager.dart';
import 'package:vrc_avatar_manager/imposter.dart';
import 'package:vrc_avatar_manager/small_icon_button.dart';
import 'package:vrc_avatar_manager/vrc_api.dart';
import 'package:vrc_avatar_manager/vrc_icons.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

final dateFormat = DateFormat('y-MM-dd');

const _sizeTextStyle = TextStyle(fontSize: 10);
const _sizeTextInvalidStyle = TextStyle(fontSize: 10, color: Colors.black38);

final _tagStrings = {
  "content_horror": "ホラー",
  "content_gore": "ゴア",
  "content_sex": "性的",
  "content_adult": "成人向",
  "content_violence": "暴力",
  "author_quest_fallback": "Fallback",
};

class AvatarView extends StatelessWidget {
  const AvatarView({
    super.key,
    required this.avatar,
    required this.pcAvatarPackageInformation,
    required this.androidAvatarPackageInformation,
    this.selected = false,
    this.detailed = false,
    this.showHaveImposter = true,
    this.showNotHaveImposter = true,
    this.showTags = true,
    this.api,
  });

  final AvatarWithStat avatar;
  final AvatarPackageInformationLike? pcAvatarPackageInformation;
  final AvatarPackageInformationLike? androidAvatarPackageInformation;
  final bool selected;
  final bool detailed;
  final bool showHaveImposter;
  final bool showNotHaveImposter;
  final bool showTags;
  final VrcApi? api;

  static Image performanceIcon(PerformanceRatings p) {
    switch (p) {
      case PerformanceRatings.excellent:
        return VrcIcons.excellent;
      case PerformanceRatings.good:
        return VrcIcons.good;
      case PerformanceRatings.medium:
        return VrcIcons.medium;
      case PerformanceRatings.poor:
        return VrcIcons.poor;
      case PerformanceRatings.veryPoor:
        return VrcIcons.verypoor;
      default:
        return VrcIcons.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = SizedBox(
        width: 200,
        height: 150,
        child: CachedNetworkImage(
          imageUrl: avatar.thumbnailImageUrl,
          httpHeaders: {"user-agent": VrcApi.userAgentString},
          fadeOutDuration: const Duration(milliseconds: 200),
          fadeInDuration: const Duration(milliseconds: 200),
          errorWidget: (context, url, error) {
            print(error);
            return const Icon(Icons.error);
          },
          cacheManager: ImageCacheManager.instance,
        ));
    return Container(
        width: 200,
        height: 220 +
            (detailed ? 70 : 0) +
            (showTags ? 20 : 0) +
            (detailed && api != null ? 40 : 0),
        color: selected ? Colors.green : null,
        child: Column(children: [
          if (avatar.releaseStatus == ReleaseStatus.public)
            material.Badge(
              label: const Text("Public"),
              backgroundColor: Colors.blue,
              offset: const Offset(-20, -4),
              child: image,
            )
          else
            image,
          if (detailed)
            SelectionArea(child: Text(avatar.name))
          else
            Text(avatar.name),
          Row(
            children: [
              if (avatar.pc.hasMain) VrcIcons.pc,
              if (avatar.pc.performanceRating != null)
                performanceIcon(avatar.pc.performanceRating!),
              if (pcAvatarPackageInformation != null)
                Text(
                  filesize(pcAvatarPackageInformation!.size, 1)
                      .replaceAll(" ", ""),
                  style: pcAvatarPackageInformation!.version == avatar.version
                      ? _sizeTextStyle
                      : _sizeTextInvalidStyle,
                ),
              if (avatar.android.hasMain) VrcIcons.android,
              if (avatar.android.performanceRating != null)
                performanceIcon(avatar.android.performanceRating!),
              if (androidAvatarPackageInformation != null)
                Text(
                  filesize(androidAvatarPackageInformation!.size, 1)
                      .replaceAll(" ", ""),
                  style:
                      androidAvatarPackageInformation!.version == avatar.version
                          ? _sizeTextStyle
                          : _sizeTextInvalidStyle,
                ),
              if ((showHaveImposter && avatar.hasImpostor))
                Tooltip(
                  message: "Impostorあり",
                  child: hasImposterBadge,
                )
              else if (showNotHaveImposter && !avatar.hasImpostor)
                Tooltip(
                  message: "Impostorなし",
                  child: noImposterBadge,
                ),
            ],
          ),
          if (showTags)
            Row(
              children: [
                if (showTags)
                  Wrap(
                    spacing: 2,
                    children: avatar.avatar.tags
                        .map((e) => material.Badge(
                              label: Text(_tagStrings[e] ?? e),
                              textStyle: TextStyle(fontSize: 10),
                              backgroundColor: Colors.red,
                            ))
                        .toList(),
                  ),
              ],
            ),
          if (detailed)
            Text(avatar.desctipion,
                maxLines: 1, overflow: TextOverflow.ellipsis),
          if (detailed)
            Text("作成: ${dateFormat.format(avatar.createdAt.toLocal())}"),
          if (detailed)
            Text("更新: ${dateFormat.format(avatar.updatedAt.toLocal())}"),
          if (detailed)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text: JsonEncoder.withIndent("  ")
                              .convert(avatar.avatar.toJson())));
                    },
                    child: const Text("Copy JSON")),
                TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: avatar.id));
                    },
                    child: const Text("Copy ID")),
                SmallIconButton(
                    onPressed: () {
                      launchUrl(Uri.parse(
                          "https://vrchat.com/home/avatar/${avatar.id}"));
                    },
                    icon: Icon(Icons.open_in_new)),
              ],
            ),
          if (detailed && api != null && avatar.hasImpostor)
            TextButton(
                onPressed: () {
                  _showActionDialog(context, "Imposterを削除", "本当に削除しますか？",
                      "Imposterの削除に成功しました", "Imposterの削除に失敗しました", () async {
                    return (await api!.deleteImposter(avatar.id), null);
                  });
                },
                child: const Text("Imposterを削除")),
          if (detailed && api != null && !avatar.hasImpostor)
            TextButton(
                onPressed: () {
                  _showActionDialog(
                      context,
                      "Imposterを作成",
                      "本当に作成しますか？",
                      "Imposterの作成がスケジュールされました",
                      "Imposterの作成に失敗しました", () async {
                    var newAvatar = await api!.avatar(avatar.id);
                    if (newAvatar == null) {
                      return (false, "アバターの取得に失敗しました");
                    }
                    var newAvatarWithStat = AvatarWithStat(newAvatar);
                    if (newAvatarWithStat.hasImpostor) {
                      return (true, "Imposterがすでに存在します");
                    }
                    return (await api!.enqueueImposter(avatar.id), null);
                  });
                },
                child: const Text("Imposterを作成")),
        ]));
  }

  Future<void> _showActionDialog(
    BuildContext context,
    String title,
    String message,
    String successMessage,
    String errorMessage,
    Future<(bool, String?)> Function() onOk,
  ) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("キャンセル"),
            ),
            TextButton(
              onPressed: () async {
                final (success, message) = await onOk();
                if (!success) {
                  _showError(message ?? errorMessage, context);
                } else {
                  _showInfo(message ?? successMessage, context);
                }
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showInfo(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showError(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
        backgroundColor: Colors.red,
      ),
    );
  }
}
