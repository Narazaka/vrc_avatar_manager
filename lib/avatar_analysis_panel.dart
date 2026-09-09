import 'package:flutter/material.dart';
import 'package:vrc_avatar_manager/avatar_analysis_view.dart';
import 'package:vrc_avatar_manager/avatar_with_stat.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information_like.dart';

class AvatarAnalysisPanel extends StatelessWidget {
  const AvatarAnalysisPanel({
    super.key,
    required this.avatar,
    required this.pcAvatarPackageInformation,
    required this.androidAvatarPackageInformation,
  });

  final AvatarWithStat avatar;
  final AvatarPackageInformationLike? pcAvatarPackageInformation;
  final AvatarPackageInformationLike? androidAvatarPackageInformation;

  List<Widget> _view(AvatarPackageInformationLike? info, bool isPc) {
    final analysis = info?.analysis;
    if (analysis == null) {
      return const [];
    }
    return [
      AvatarAnalysisView(
        analysis: analysis,
        isPc: isPc,
        stale: info!.version != avatar.version,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final views = [
      ..._view(pcAvatarPackageInformation, true),
      ..._view(androidAvatarPackageInformation, false),
    ];
    if (views.isEmpty) {
      return const SizedBox.shrink();
    }
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final (i, view) in views.indexed) ...[
                if (i > 0) const SizedBox(width: 16),
                view,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
