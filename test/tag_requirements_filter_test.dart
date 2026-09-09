import 'package:flutter_test/flutter_test.dart';
import 'package:vrc_avatar_manager/avatar_with_stat.dart';
import 'package:vrc_avatar_manager/db/tag.dart';
import 'package:vrc_avatar_manager/db/tag_type.dart';
import 'package:vrc_avatar_manager/imposter.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

UnityPackage _pkg(String platform, {String? variant, PerformanceRatings? rating}) =>
    UnityPackage(
      id: 'unp_$platform${variant ?? ''}',
      assetVersion: 1,
      platform: platform,
      unityVersion: '2022.3.22f1',
      variant: variant,
      performanceRating: rating,
    );

AvatarWithStat _avatar(String name, Set<UnityPackage> packages) =>
    AvatarWithStat(Avatar(
      authorId: 'usr',
      authorName: 'a',
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
      description: '',
      id: 'avtr_$name',
      listingDate: null,
      performance: AvatarPerformance(),
      imageUrl: '',
      name: name,
      releaseStatus: ReleaseStatus.private,
      styles: AvatarStyles(),
      tags: const [],
      thumbnailImageUrl: '',
      unityPackageUrl: '',
      unityPackageUrlObject: AvatarUnityPackageUrlObject(),
      unityPackages: packages,
    ));

void main() {
  final pcOnly = _avatar('pc', {_pkg('standalonewindows', rating: PerformanceRatings.good)});
  final cross = _avatar('cross', {
    _pkg('standalonewindows', rating: PerformanceRatings.veryPoor),
    _pkg('android', rating: PerformanceRatings.poor),
  });
  final withImposter = _avatar('imp', {
    _pkg('standalonewindows'),
    _pkg('standalonewindows', variant: 'impostor'),
  });
  final all = [pcOnly, cross, withImposter];

  Tag filter() => Tag()
    ..empty()
    ..type = TagType.conditions;

  List<String> names(Tag tag) => tag.filterAvatars(all).map((a) => a.name).toList();

  test('no requirements passes everything', () {
    expect(names(filter()), ['pc', 'cross', 'imp']);
  });

  test('imposter', () {
    expect(names(filter()..imposter = FilterByImposter.haveImposter), ['imp']);
    expect(names(filter()..imposter = FilterByImposter.notHaveImposter), ['pc', 'cross']);
  });

  test('platform and performance combine with AND', () {
    expect(names(filter()..requireAndroid = true), ['cross']);
    expect(names(filter()..requirePc = true..requireAndroid = true), ['cross']);
    expect(
        names(filter()
          ..requirePc = true
          ..ignorePcPerformanceRatings = [PerformanceRatings.veryPoor]),
        ['pc', 'imp']);
  });
}
