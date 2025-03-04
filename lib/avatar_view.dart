import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vrc_avatar_manager/avatar_with_stat.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information.dart';
import 'package:vrc_avatar_manager/image_cache_manager.dart';
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
  });

  final AvatarWithStat avatar;
  final AvatarPackageInformation? pcAvatarPackageInformation;
  final AvatarPackageInformation? androidAvatarPackageInformation;
  final bool selected;
  final bool detailed;
  final bool showHaveImposter;
  final bool showNotHaveImposter;
  final bool showTags;

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
        height: 220 + (detailed ? 70 : 0) + (showTags ? 20 : 0),
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
                  child: const material.Badge(
                    label: Text("i"),
                    textStyle: TextStyle(fontSize: 9),
                    backgroundColor: Colors.cyan,
                    largeSize: 9,
                  ),
                )
              else if (showNotHaveImposter && !avatar.hasImpostor)
                Tooltip(
                  message: "Impostorなし",
                  child: const material.Badge(
                    label: Text("i"),
                    textStyle: TextStyle(fontSize: 9),
                    largeSize: 9,
                  ),
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
          /*
          if (detailed)
            ElevatedButton(
                onPressed: () async {
                  final api = VrcApi.load("1");
                  final a = await api.avatar(avatar.id);
                  if (a == null) {
                    print("Failed to load avatar");
                    return;
                  }
                  final stat = AvatarWithStat(a);
                  if (stat.pc.main?.assetUrl == null) {
                    print("No asset url");
                    return;
                  }
                  final res = await api.fileSize(stat.pc.main!.assetUrl!);
                  if (res == null) {
                    print("Failed to get file");
                    return;
                  }
                  print("File size: $res");
                },
                child: Text("size")),
                */
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
        ]));
  }
}
