import 'package:flutter_test/flutter_test.dart';
import 'package:vrc_avatar_manager/avatar_with_stat.dart';
import 'package:vrc_avatar_manager/db/stat_requirement.dart';
import 'package:vrc_avatar_manager/db/tag.dart';
import 'package:vrc_avatar_manager/db/tag_filter_context.dart';
import 'package:vrc_avatar_manager/db/tag_type.dart';
import 'package:vrc_avatar_manager/imposter.dart';
import 'package:vrc_avatar_manager/performance_stats.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

import 'file_analysis_fixture.dart';

UnityPackage _pkg(String platform,
        {String? variant, PerformanceRatings? rating}) =>
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
  final pcOnly = _avatar(
      'pc', {_pkg('standalonewindows', rating: PerformanceRatings.good)});
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

  List<String> names(Tag tag) =>
      tag.filterAvatars(all).map((a) => a.name).toList();

  test('no requirements passes everything', () {
    expect(names(filter()), ['pc', 'cross', 'imp']);
  });

  test('imposter', () {
    expect(names(filter()..imposter = FilterByImposter.haveImposter), ['imp']);
    expect(names(filter()..imposter = FilterByImposter.notHaveImposter),
        ['pc', 'cross']);
  });

  test('platform and performance combine with AND', () {
    expect(names(filter()..requireAndroid = true), ['cross']);
    expect(
        names(filter()
          ..requirePc = true
          ..requireAndroid = true),
        ['cross']);
    expect(
        names(filter()
          ..requirePc = true
          ..ignorePcPerformanceRatings = [PerformanceRatings.veryPoor]),
        ['pc', 'imp']);
  });

  test('stat requirement uses analysis from context, passes unanalyzed', () {
    final analysis = FileAnalysis.fromJson(validFileAnalysisJson());
    expect(performanceStatByKey('totalPolygons')!.rating(analysis, true),
        PerformanceRatings.veryPoor);
    final context = TagFilterContext(
        allTags: [],
        allAvatars: all,
        analysisOf: (id, platform) =>
            id == pcOnly.id && platform == 'standalonewindows'
                ? analysis
                : null);
    final tag = filter()
      ..statRequirements = [
        StatRequirement()
          ..stat = 'totalPolygons'
          ..ignorePc = [PerformanceRatings.veryPoor]
      ];
    expect(tag.filterAvatars(all, context: context).map((a) => a.name),
        ['cross', 'imp']);
    expect(names(tag), ['pc', 'cross', 'imp']);
  });

  test('stat keys are unique', () {
    final keys =
        [...performanceStats, ...extraPerformanceStats].map((s) => s.key);
    expect(keys.toSet().length, keys.length);
  });

  test('unknown stat key is ignored', () {
    final tag = filter()
      ..statRequirements = [
        StatRequirement()
          ..stat = 'Triangles'
          ..ignorePc = PerformanceRatings.values.toList()
      ];
    final context = TagFilterContext(allTags: [], allAvatars: all);
    expect(tag.filterAvatars(all, context: context).map((a) => a.name),
        ['pc', 'cross', 'imp']);
  });

  test('numeric bounds use the stat unit scale', () {
    final analysis = FileAnalysis.fromJson(validFileAnalysisJson());
    final context = TagFilterContext(
        allTags: [],
        allAvatars: all,
        analysisOf: (id, platform) =>
            id == pcOnly.id && platform == 'standalonewindows'
                ? analysis
                : null);
    Tag withBounds(String stat, {double? min, double? max}) => filter()
      ..statRequirements = [
        StatRequirement()
          ..stat = stat
          ..minPc = min
          ..maxPc = max
      ];
    List<String> run(Tag tag) =>
        tag.filterAvatars(all, context: context).map((a) => a.name).toList();
    expect(
        run(withBounds('totalPolygons', max: 80000)), ['pc', 'cross', 'imp']);
    expect(run(withBounds('totalPolygons', max: 79999)), ['cross', 'imp']);
    expect(run(withBounds('totalPolygons', min: 80001)), ['cross', 'imp']);
    expect(run(withBounds('fileSize', max: 50)), ['pc', 'cross', 'imp']);
    expect(run(withBounds('fileSize', max: 49)), ['cross', 'imp']);
  });
}
