import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vrc_avatar_manager/avatar_view.dart';
import 'package:vrc_avatar_manager/avatar_with_stat.dart';
import 'package:vrc_avatar_manager/clickable_view.dart';
import 'package:vrc_avatar_manager/custom_scroll_behaviour.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information_db.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information_like.dart';
import 'package:vrc_avatar_manager/db/avatar_package_information_v2.dart';
import 'package:vrc_avatar_manager/db/tag.dart';
import 'package:vrc_avatar_manager/db/tag_type.dart';
import 'package:vrc_avatar_manager/db/tags_db.dart';
import 'package:vrc_avatar_manager/imposter.dart';
import 'package:vrc_avatar_manager/order_dialog.dart';
import 'package:vrc_avatar_manager/performance_selector.dart';
import 'package:vrc_avatar_manager/prefs.dart';
import 'package:vrc_avatar_manager/setting_dialog.dart';
import 'package:vrc_avatar_manager/small_icon_button.dart';
import 'package:vrc_avatar_manager/vrc_osc.dart';
import 'package:vrc_avatar_manager/wrap_with_height.dart';
import 'package:vrc_avatar_manager/sort_by.dart';
import 'package:vrc_avatar_manager/tag_button.dart';
import 'package:vrc_avatar_manager/tag_companion_button.dart';
import 'package:vrc_avatar_manager/tag_edit_dialog.dart';
import 'package:vrc_avatar_manager/vrc_api.dart';
import 'package:vrc_avatar_manager/vrc_icons.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class AvatarsPage extends StatefulWidget {
  const AvatarsPage({super.key, required this.accountId});

  final String accountId;

  @override
  State<AvatarsPage> createState() => _AvatarsPageState();
}

class _AvatarsPageState extends State<AvatarsPage> {
  late Timer _avatarSizeTimer;
  late final VrcApi _api;
  late final TagsDb _tagsDb;
  bool _tagsDbLoaded = false;
  late final AvatarPackageInformationDb _avatarPackageInformationDb;
  bool _avatarPackageInformationDbLoaded = false;

  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  bool _searchFocused = false;

  final MapValueSet<String, AvatarWithStat> _avatars =
      MapValueSet({}, (avatar) => avatar.id);

  MapValueSet<String, AvatarWithStat> _newAvatars =
      MapValueSet({}, (avatar) => avatar.id);

  List<AvatarWithStat> _sortedAvatars = [];

  final Map<({String avatarId, String platform}), AvatarPackageInformationLike>
      _avatarPackageInformations = {};
  final Set<({String avatarId, String platform})>
      _erroredAvatarPackageInformations = {};

  bool _confirmWhenChangeAvatar = false;
  bool _useOsc = false;
  bool _ascending = false;
  SortBy _sortBy = SortBy.createdAt;
  bool _editTagAvatars = false;
  bool _editTags = false;
  Tag? _editTagAvatarTag;
  bool _selectSingleTag = false;
  bool _showHaveImposter = false;
  bool _showNotHaveImposter = false;
  bool _showTags = false;
  bool _multiLineTagsView = false;
  FilterByImposter _filterByImposter = FilterByImposter.none;

  double _tagsHeight = 50;

  final Set<PerformanceRatings> _pcPerformanceBlocks = {};
  final Set<PerformanceRatings> _androidPerformanceBlocks = {};
  String _search = "";
  final List<bool> _isPlatformSelected = [false, false, false];
  final Set<int> _selectedTagIds = {};
  List<Tag> _tags = [];
  Iterable<Tag> get _selectedTags =>
      _tags.where((tag) => _selectedTagIds.contains(tag.id));

  @override
  void initState() {
    super.initState();
    _avatarSizeTimer = Timer.periodic(Duration(seconds: 8), _fetchAvatarSize);
    _searchFocusNode.addListener(() {
      setState(() {
        _searchFocused = _searchFocusNode.hasFocus;
      });
    });
    _api = VrcApi.load(widget.accountId);
    _ensureDb().then((_) {
      setState(() {
        _tagsDbLoaded = true;
        _avatarPackageInformationDbLoaded = true;
      });
      _loadAvatars();
      _watchTagsDb();
    });
    _restoreSettings();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _avatarSizeTimer.cancel();
    super.dispose();
  }

  void _restoreSettings() async {
    final prefs = await Prefs.instance;
    var confirmWhenChangeAvatar = await prefs.confirmWhenChangeAvatar;
    var useOsc = await prefs.useOsc;
    var selectSingleTag = await prefs.selectSingleTag;
    var ascending = await prefs.ascending;
    var sortBy = await prefs.sortBy;
    await _restoreSettingsInDialog();
    setState(() {
      _confirmWhenChangeAvatar = confirmWhenChangeAvatar;
      _useOsc = useOsc;
      _selectSingleTag = selectSingleTag;
      _ascending = ascending;
      _sortBy = sortBy;
      _sortAvatars();
    });
  }

  Future<void> _ensureDb() async {
    _tagsDb = await TagsDb.instance(widget.accountId);
    await _tagsDb.migrate();
    _avatarPackageInformationDb = await AvatarPackageInformationDb.instance;
    await _avatarPackageInformationDb.migrate();
  }

  void _sortAvatars() {
    var comparator = _ascending
        ? <T extends Comparable<T>>(T a, T b) => a.compareTo(b)
        : <T extends Comparable<T>>(T a, T b) => b.compareTo(a);
    _sortedAvatars = switch (_sortBy) {
      SortBy.createdAt => _avatars.sorted((a, b) =>
          comparator(a.createdAt, b.createdAt) * 10 +
          comparator(a.updatedAt, b.updatedAt)),
      SortBy.updatedAt => _avatars.sorted((a, b) =>
          comparator(a.updatedAt, b.updatedAt) * 10 +
          comparator(a.createdAt, b.createdAt)),
      SortBy.name => _avatars.sorted((a, b) =>
          comparator(a.name, b.name) * 100 +
          comparator(a.createdAt, b.createdAt) * 10 +
          comparator(a.updatedAt, b.updatedAt)),
      SortBy.pcSize => _avatars.sorted((a, b) =>
          comparator<num>(
                  (_avatarPackageInformations[(avatarId: a.id, platform: AvatarWithStat.platformPc)]
                          ?.size ??
                      0),
                  (_avatarPackageInformations[(avatarId: b.id, platform: AvatarWithStat.platformPc)]
                          ?.size ??
                      0)) *
              10000 +
          comparator<num>(
                  (_avatarPackageInformations[(
                        avatarId: a.id,
                        platform: AvatarWithStat.platformAndroid
                      )]
                          ?.size ??
                      0),
                  (_avatarPackageInformations[(
                        avatarId: b.id,
                        platform: AvatarWithStat.platformAndroid
                      )]
                          ?.size ??
                      0)) *
              1000 +
          comparator(a.createdAt, b.createdAt) * 10 +
          comparator(a.updatedAt, b.updatedAt)),
      SortBy.androidSize => _avatars.sorted((a, b) =>
          comparator<num>(
                  (_avatarPackageInformations[(
                        avatarId: a.id,
                        platform: AvatarWithStat.platformAndroid
                      )]
                          ?.size ??
                      0),
                  (_avatarPackageInformations[(
                        avatarId: b.id,
                        platform: AvatarWithStat.platformAndroid
                      )]
                          ?.size ??
                      0)) *
              10000 +
          comparator<num>(
                  (_avatarPackageInformations[(avatarId: a.id, platform: AvatarWithStat.platformPc)]
                          ?.size ??
                      0),
                  (_avatarPackageInformations[(avatarId: b.id, platform: AvatarWithStat.platformPc)]?.size ?? 0)) *
              1000 +
          comparator(a.createdAt, b.createdAt) * 10 +
          comparator(a.updatedAt, b.updatedAt)),
    };
  }

  bool get _loadingAvatars => _avatars.length != _newAvatars.length;

  void _loadAvatars() async {
    _newAvatars =
        MapValueSet<String, AvatarWithStat>({}, (avatar) => avatar.id);
    var page = 1;
    while (true) {
      var avatars = await _api.avatars(page);
      if (avatars == null) {
        break;
      } else {
        if (avatars.isEmpty) {
          break;
        }
        var avatarStats =
            avatars.map((avatar) => AvatarWithStat(avatar)).toList();
        _newAvatars.addAll(avatarStats);
        final aps = await _avatarPackageInformationDb.getAllBy({
          ...avatarStats.where((avatar) => avatar.hasPc).map((avatar) => (
                avatarId: avatar.id,
                platform: avatar.pc.main!.platform,
                unityPackageId: avatar.pc.main!.id
              )),
          ...avatarStats.where((avatar) => avatar.hasAndroid).map((avatar) => (
                avatarId: avatar.id,
                platform: avatar.android.main!.platform,
                unityPackageId: avatar.android.main!.id
              )),
        });
        setState(() {
          _avatars.addAll(avatarStats);
          _avatarPackageInformations.addEntries(aps.map((ap) =>
              MapEntry((avatarId: ap.avatarId, platform: ap.platform), ap)));
          _sortAvatars();
        });
      }
      page++;
    }
    setState(() {
      _avatars.clear();
      _avatars.addAll(_newAvatars);
      _sortAvatars();
    });
  }

  void _watchTagsDb() async {
    _tagsDb.watchTags(fireImmediately: true).listen((_) {
      _loadTags();
    });
    _tagsDb.watchTagAvatars(fireImmediately: true).listen((_) {
      _loadTags();
    });
  }

  void _loadTags() async {
    var tags = await _tagsDb.getAll();
    setState(() {
      _tags = tags;
      if (_editTagAvatarTag != null) {
        _editTagAvatarTag =
            tags.firstWhereOrNull((tag) => tag.id == _editTagAvatarTag!.id);
      }
    });
  }

  void _toggleTag(Tag tag) {
    setState(() {
      if (_selectedTagIds.contains(tag.id)) {
        _selectedTagIds.remove(tag.id);
      } else {
        if (_selectSingleTag) {
          _selectedTagIds.removeAll(
              _tags.where((t) => t.groupId == tag.groupId).map((t) => t.id));
        }
        _selectedTagIds.add(tag.id);
      }
    });
  }

  void _toggleAllAvatarsToTag() async {
    if (_editTagAvatarTag == null) {
      return;
    }
    var avatarIds = _filteredAvatars.map((a) => a.id).toSet();
    var isAdd = !_editTagAvatarTag!.hasAllAvatars(avatarIds);
    var text = isAdd ? "追加" : "削除";
    var confirmed = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("全てのアバターを$textしますか？"),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text("フィルタされた ${avatarIds.length} 個のアバターを全て"),
              Text(
                text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    color: Colors.red),
              ),
              const Text("しますか？")
            ]),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Yes")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text("No")),
            ],
          );
        });
    if (confirmed != true) {
      return;
    }
    if (isAdd) {
      await _editTagAvatarTag!.addAvatars(avatarIds, _tagsDb);
    } else {
      await _editTagAvatarTag!.removeAvatars(avatarIds, _tagsDb);
    }
  }

  Future<void> _changeAvatar(String id) async {
    if (_confirmWhenChangeAvatar) {
      var avatar = _avatars.firstWhereOrNull((avatar) => avatar.id == id);
      var confirmed = await showDialog<bool>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text("アバター変更"),
                content: avatar == null
                    ? const Text("?")
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AvatarView(
                            avatar: avatar,
                            detailed: true,
                            pcAvatarPackageInformation:
                                _avatarPackageInformations[(
                              avatarId: avatar.id,
                              platform: AvatarWithStat.platformPc
                            )],
                            androidAvatarPackageInformation:
                                _avatarPackageInformations[(
                              avatarId: avatar.id,
                              platform: AvatarWithStat.platformAndroid
                            )],
                            showHaveImposter: _showHaveImposter,
                            showNotHaveImposter: _showNotHaveImposter,
                            showTags: _showTags,
                          ),
                          SizedBox(
                              width: 200,
                              child: Tooltip(
                                  message:
                                      "OSCを使用してアバターをより素早く変更します（VRChat起動時のみ）",
                                  child: CheckboxListTile(
                                      title: const Text("OSCを使用"),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      value: _useOsc,
                                      onChanged: (value) async {
                                        setState(() {
                                          _useOsc = value ?? false;
                                        });
                                        final prefs = await Prefs.instance;
                                        await prefs.setUseOsc(_useOsc);
                                      }))),
                        ],
                      ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Yes"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("No"),
                  ),
                ],
              );
            },
          );
        },
      );

      if (confirmed != true) {
        return;
      }
    }

    if (_useOsc) {
      await _doChangeAvatarOSC(id);
    } else {
      await _doChangeAvatar(id);
    }
  }

  Future<void> _doChangeAvatar(String id) async {
    var res = await _api.changeAvatar(id);
    if (res.succeeded) {
      _showInfo("Avatar changed");
    } else {
      _showError("Avatar change failed!");
      print(res.failure);
    }
  }

  Future<void> _doChangeAvatarOSC(String id) async {
    await VrcOsc().sendAvatar(id);
    _showInfo("Avatar changed");
  }

  void _toggleTagAvatar(String id) async {
    if (_editTagAvatarTag == null) {
      return;
    }
    await _editTagAvatarTag!.toggleAvatar(id, _tagsDb);
  }

  void _setConfirmWhenChangeAvatar(bool? value) async {
    final prefs = await Prefs.instance;
    setState(() {
      _confirmWhenChangeAvatar = value ?? false;
    });
    await prefs.setConfirmWhenChangeAvatar(_confirmWhenChangeAvatar);
  }

  Future<void> _restoreSettingsInDialog() async {
    final prefs = await Prefs.instance;
    var useOsc = await prefs.useOsc;
    var showHaveImposter = await prefs.showHaveImposter;
    var showNotHaveImposter = await prefs.showNotHaveImposter;
    var showTags = await prefs.showTags;
    var multiLineTagsView = await prefs.multiLineTagsView;
    setState(() {
      _useOsc = useOsc;
      _showHaveImposter = showHaveImposter;
      _showNotHaveImposter = showNotHaveImposter;
      _showTags = showTags;
      _multiLineTagsView = multiLineTagsView;
      if (!_multiLineTagsView) {
        _tagsHeight = 50;
      }
    });
  }

  void _showJson() async {
    await showDialog(
        context: context,
        builder: (context) {
          final json = JsonEncoder.withIndent("  ")
              .convert(_filteredAvatars.map((a) => a.avatar).toList());
          final controller = TextEditingController(text: json);
          return AlertDialog(
            title: const Text("JSON"),
            content: TextField(
              controller: controller,
              maxLines: 20,
              readOnly: true,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: json));
                },
                child: const Text("Copy"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
            ],
          );
        });
  }

  void _fetchAvatarSize(Timer timer) async {
    final prefs = await Prefs.instance;
    if (!await prefs.fetchAvatarSize || !_avatarPackageInformationDbLoaded) {
      return;
    }
    final targets = {
      ...{
        for (var avatar in _avatars.where((avatar) => avatar.hasPc))
          (avatar.pc.main!.id, avatar.version): (
            avatarId: avatar.id,
            platform: avatar.pc.main!.platform,
            unityPackageId: avatar.pc.main!.id
          )
      },
      ...{
        for (var avatar in _avatars.where((avatar) => avatar.hasAndroid))
          (avatar.android.main!.id, avatar.version): (
            avatarId: avatar.id,
            platform: avatar.android.main!.platform,
            unityPackageId: avatar.android.main!.id
          )
      }
    };
    for (var ai in _avatarPackageInformations.values) {
      targets.remove((ai.unityPackageId, ai.version));
    }
    if (targets.isEmpty) {
      return;
    }
    final targetUnityPackageIds =
        targets.values.map((v) => v.unityPackageId).toSet();
    final notErroredTargetUnityPackageIds = targets.values
        .where((v) => !_erroredAvatarPackageInformations
            .contains((avatarId: v.avatarId, platform: v.platform)))
        .map((v) => v.unityPackageId)
        .toSet();

    var targetAvatar = _filteredAvatars.firstWhereOrNull((avatar) =>
            avatar.hasUnityPackageIdInMain(notErroredTargetUnityPackageIds)) ??
        _avatars.firstWhereOrNull((avatar) =>
            avatar.hasUnityPackageIdInMain(notErroredTargetUnityPackageIds)) ??
        _filteredAvatars.firstWhereOrNull((avatar) =>
            avatar.hasUnityPackageIdInMain(targetUnityPackageIds)) ??
        _avatars.firstWhereOrNull(
            (avatar) => avatar.hasUnityPackageIdInMain(targetUnityPackageIds));
    if (targetAvatar == null) {
      print("[_fetchAvatarSize] something wrong");
      return;
    }

    print("[_fetchAvatarSize] ${targetAvatar.name}");
    final errorTarget = "${targetAvatar.id} ${targetAvatar.name}";

    final avatarDetail = await _api.avatar(targetAvatar.id);
    if (avatarDetail == null) {
      print("[_fetchAvatarSize][$errorTarget] Failed to load avatar");
      return;
    }
    final stat = AvatarWithStat(avatarDetail);
    if (!await _fetchMainAvatarSize(
        avatarDetail, stat.pc.main, "$errorTarget PC")) {
      setState(() {
        _erroredAvatarPackageInformations
            .add((avatarId: stat.id, platform: AvatarWithStat.platformPc));
      });
      for (var up in stat.sortedUnityPackagesForDebug
          .where((up) => up.platform == AvatarWithStat.platformPc)) {
        print(
            "[_fetchAvatarSize][sortedUnityPackagesForDebug] ${up.scanStatus} ${up.variant} ${up.unityVersion} ${up.performanceRating} ${up.createdAt} ${up.assetVersion} ${up.assetUrl}");
      }
    }
    if (!await _fetchMainAvatarSize(
        avatarDetail, stat.android.main, "$errorTarget Android")) {
      setState(() {
        _erroredAvatarPackageInformations
            .add((avatarId: stat.id, platform: AvatarWithStat.platformAndroid));
      });
      for (var up in stat.sortedUnityPackagesForDebug
          .where((up) => up.platform == AvatarWithStat.platformAndroid)) {
        print(
            "[_fetchAvatarSize][sortedUnityPackagesForDebug] ${up.scanStatus} ${up.variant} ${up.unityVersion} ${up.performanceRating} ${up.createdAt} ${up.assetVersion} ${up.assetUrl}");
      }
    }
    setState(() {
      _sortAvatars();
    });
  }

  Future<bool> _fetchMainAvatarSize(
      Avatar avatar, UnityPackage? up, String errorTarget) async {
    if (up == null) {
      return true;
    }
    if (up.assetUrl == null) {
      print("[_fetchMainAvatarSize][$errorTarget] assetUrl empty");
      return true;
    }
    final stopwatch = Stopwatch()..start();
    final size = await _api.fileSize(up.assetUrl!);
    stopwatch.stop();
    print("[_fetchMainAvatarSize] fetch time ${stopwatch.elapsed}");
    if (size == null) {
      print("[_fetchMainAvatarSize][$errorTarget] Failed to get size");
      print(up);
      return false;
    }
    final ap = AvatarPackageInformationV2()
      ..avatarId = avatar.id
      ..platform = up.platform
      ..unityPackageId = up.id
      ..version = avatar.version
      ..size = size;
    await _avatarPackageInformationDb.put(ap);
    setState(() {
      _avatarPackageInformations[(
        avatarId: ap.avatarId,
        platform: ap.platform
      )] = ap;
    });
    return true;
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
        backgroundColor: const Color(0xFF0066FF),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
        backgroundColor: const Color(0xFFFF6600),
      ),
    );
  }

  Iterable<AvatarWithStat> get _filteredAvatars {
    Iterable<AvatarWithStat> avatars = _sortedAvatars;
    for (var tag in _selectedTags) {
      avatars = tag.filterAvatars(avatars);
    }
    if (_isPlatformSelected[0]) {
      avatars = avatars.where((avatar) => avatar.hasPc);
    } else if (_isPlatformSelected[1]) {
      avatars = avatars.where((avatar) => avatar.hasAndroid);
    } else if (_isPlatformSelected[2]) {
      avatars = avatars.where((avatar) => avatar.hasCrossPlatform);
    }
    if (_pcPerformanceBlocks.isNotEmpty) {
      avatars = avatars.where((avatar) =>
          avatar.pc.performanceRating == null ||
          !_pcPerformanceBlocks.contains(avatar.pc.performanceRating));
    }
    if (_androidPerformanceBlocks.isNotEmpty) {
      avatars = avatars.where((avatar) =>
          avatar.android.performanceRating == null ||
          !_androidPerformanceBlocks
              .contains(avatar.android.performanceRating));
    }
    if (_filterByImposter == FilterByImposter.haveImposter) {
      avatars = avatars.where((avatar) => avatar.hasImpostor);
    } else if (_filterByImposter == FilterByImposter.notHaveImposter) {
      avatars = avatars.where((avatar) => !avatar.hasImpostor);
    }
    if (_search.isNotEmpty) {
      var search = _search.toLowerCase();
      avatars =
          avatars.where((avatar) => avatar.name.toLowerCase().contains(search));
    }
    return avatars;
  }

  Widget _title(BuildContext context, List<AvatarWithStat> filteredAvatars) {
    return _loadingAvatars
        ? Text(
            "${filteredAvatars.length} avatars (fetching ${_newAvatars.length} avatars)")
        : GestureDetector(
            onTap: _showJson,
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  '${filteredAvatars.length} avatars',
                )));
  }

  List<Widget> _actions(BuildContext context) {
    return [
      Tooltip(
          message: "設定",
          child: IconButton(
              onPressed: () async {
                await SettingDialog.show(context, widget.accountId,
                    _loadingAvatars ? null : _avatars);
                await _restoreSettingsInDialog();
              },
              icon: const Icon(Icons.settings))),
      SizedBox(
          width: 120,
          child: Tooltip(
              message: "アバターをクリックしたときに確認ダイアログを出します",
              child: CheckboxListTile(
                  title: const Text('変更確認'),
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  value: _confirmWhenChangeAvatar,
                  onChanged: _setConfirmWhenChangeAvatar))),
      Tooltip(
          message: "並び替え",
          child: DropdownButton<SortBy>(
            value: _sortBy,
            onChanged: (SortBy? value) async {
              setState(() {
                _sortBy = value!;
                _sortAvatars();
              });
              final prefs = await Prefs.instance;
              await prefs.setSortBy(_sortBy);
            },
            items: SortBy.values
                .map((sortBy) => DropdownMenuItem(
                      value: sortBy,
                      child: Text(switch (sortBy) {
                        SortBy.createdAt => "Created At",
                        SortBy.updatedAt => "Updated At",
                        SortBy.name => "Name",
                        SortBy.pcSize => "PC Size",
                        SortBy.androidSize => "Android Size",
                      }),
                    ))
                .toList(),
          )),
      Tooltip(
          message: _ascending ? "昇順" : "降順",
          child: IconButton(
              onPressed: () async {
                setState(() {
                  _ascending = !_ascending;
                  _sortAvatars();
                });
                final prefs = await Prefs.instance;
                await prefs.setAscending(_ascending);
              },
              icon: Icon(
                  _ascending ? Icons.arrow_upward : Icons.arrow_downward))),
      VrcIcons.pc,
      PerformanceRankSelector(
          selected: PerformanceRatings.values
              .toSet()
              .difference(_pcPerformanceBlocks),
          onChanged: (p) {
            setState(() {
              if (_pcPerformanceBlocks.contains(p)) {
                _pcPerformanceBlocks.remove(p);
              } else {
                _pcPerformanceBlocks.add(p);
              }
            });
          }),
      VrcIcons.android,
      PerformanceRankSelector(
          selected: PerformanceRatings.values
              .toSet()
              .difference(_androidPerformanceBlocks),
          onChanged: (p) {
            setState(() {
              if (_androidPerformanceBlocks.contains(p)) {
                _androidPerformanceBlocks.remove(p);
              } else {
                _androidPerformanceBlocks.add(p);
              }
            });
          }),
      ToggleButtons(
        isSelected: _isPlatformSelected,
        onPressed: (int index) {
          setState(() {
            for (var buttonIndex = 0;
                buttonIndex < _isPlatformSelected.length;
                buttonIndex++) {
              if (buttonIndex == index) {
                _isPlatformSelected[buttonIndex] =
                    !_isPlatformSelected[buttonIndex];
              } else {
                _isPlatformSelected[buttonIndex] = false;
              }
            }
          });
        },
        children: [
          Tooltip(message: "PC対応アバターを表示", child: VrcIcons.pc),
          Tooltip(message: "Android対応アバターを表示", child: VrcIcons.android),
          Tooltip(
              message: "PC/Android両対応アバターを表示", child: VrcIcons.crossPlatform),
        ],
      ),
      Tooltip(
        message: "Imposterありのアバターを表示",
        child: SmallIconButton(
            icon: _filterByImposter == FilterByImposter.haveImposter
                ? hasImposterBadge
                : hasImposterInactiveBadge,
            onPressed: () {
              setState(() {
                _filterByImposter =
                    _filterByImposter == FilterByImposter.haveImposter
                        ? FilterByImposter.none
                        : FilterByImposter.haveImposter;
              });
            }),
      ),
      Tooltip(
        message: "Imposterなしのアバターを表示",
        child: SmallIconButton(
            icon: _filterByImposter == FilterByImposter.notHaveImposter
                ? noImposterBadge
                : noImposterInactiveBadge,
            onPressed: () {
              setState(() {
                _filterByImposter =
                    _filterByImposter == FilterByImposter.notHaveImposter
                        ? FilterByImposter.none
                        : FilterByImposter.notHaveImposter;
              });
            }),
      ),
      const SizedBox(width: 8),
      SizedBox(
        width: 140,
        child: TextField(
          focusNode: _searchFocusNode,
          controller: _searchController,
          decoration: InputDecoration(
            labelText: "Search",
            suffixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 30),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _search = "";
                });
              },
            ),
          ),
          onChanged: (value) => setState(() {
            _search = value;
          }),
        ),
      ),
      const SizedBox(width: 8),
      Tooltip(
          message: "アバター一覧を再読込",
          child: IconButton(
            iconSize: 36,
            icon: const Icon(Icons.refresh),
            onPressed: _loadAvatars,
            color: Theme.of(context).colorScheme.primary,
          )),
    ];
  }

  Widget _bottomMenu(BuildContext context) {
    return Row(
      children: [
        Tooltip(
            message: "タグを新規作成",
            child: IconButton(
                onPressed: () {
                  if (!_tagsDbLoaded) {
                    return;
                  }
                  TagEditDialog.show(context, Tag()..empty(), true, _tagsDb);
                },
                icon: const Icon(Icons.add))),
        Tooltip(
            message: "タグ（タイプ: リスト）に含まれるアバターリストを編集",
            child: IconButton(
                onPressed: () {
                  setState(() {
                    _editTagAvatars = !_editTagAvatars;
                    if (_editTagAvatars) {
                      _editTags = false;
                    } else {
                      _editTagAvatarTag = null;
                    }
                  });
                },
                icon: const Icon(Icons.edit))),
        Tooltip(
            message: "タグを並べ替え",
            child: IconButton(
                onPressed: () async {
                  final tags =
                      await OrderDialog.show(context, _tags, (tag) => tag.name);
                  if (tags != null) {
                    await _tagsDb.reorder(tags);
                  }
                },
                icon: const Icon(Icons.swap_vert))),
        Tooltip(
            message: "タグの設定を変更",
            child: IconButton(
                onPressed: () {
                  setState(() {
                    _editTags = !_editTags;
                    if (_editTags) {
                      _editTagAvatars = false;
                      _editTagAvatarTag = null;
                    }
                  });
                },
                icon: const Icon(Icons.settings))),
        Tooltip(
            message: "択一選択モード（同一タググループのタグを1つだけ選択するモード）",
            child: IconButton(
                style: _selectSingleTag
                    ? IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary)
                    : null,
                onPressed: () async {
                  setState(() {
                    _selectSingleTag = !_selectSingleTag;
                  });
                  final prefs = await Prefs.instance;
                  await prefs.setSelectSingleTag(_selectSingleTag);
                },
                icon: const Icon(Icons.check_box))),
      ],
    );
  }

  List<Widget> _tagButtons(BuildContext context) {
    return _tags
        .map((tag) => Column(children: [
              TagButton(
                  tag: tag,
                  selected: _selectedTagIds.contains(tag.id),
                  onPressed: () {
                    _toggleTag(tag);
                  }),
              if (_editTags)
                TagCompanionButton(
                  onPressed: () {
                    TagEditDialog.show(context, tag, false, _tagsDb);
                  },
                  icon: const Icon(Icons.settings),
                ),
              if (_editTagAvatars && tag.type == TagType.items)
                Tooltip(
                    message: "アバターをクリックで選択or解除\nCtrl+Aで表示中を全選択or全解除",
                    child: TagCompanionButton(
                      onPressed: () {
                        setState(() {
                          if (_editTagAvatarTag == tag) {
                            _editTagAvatarTag = null;
                          } else {
                            _editTagAvatarTag = tag;
                          }
                        });
                      },
                      icon: const Icon(Icons.edit),
                      selected: _editTagAvatarTag == tag,
                    )),
            ]))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var filteredAvatars = _filteredAvatars.toList();
    return CallbackShortcuts(
        bindings: _searchFocused
            ? {}
            : {
                LogicalKeySet(
                        LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
                    _toggleAllAvatarsToTag,
              },
        child: FocusScope(
            autofocus: true,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: _title(context, filteredAvatars),
                actions: _actions(context),
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(_tagsHeight),
                    child: Row(
                      children: [
                        SizedBox(width: 200, child: _bottomMenu(context)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width - 200,
                            child: ScrollConfiguration(
                                behavior: CustomScrollBehavior(),
                                child: _multiLineTagsView
                                    ? Padding(
                                        padding: EdgeInsets.all(2),
                                        child: WrapWithHeight(
                                          spacing: 6,
                                          runSpacing: 6,
                                          onSizeChanged: (size) {
                                            if (size != null &&
                                                _tagsHeight != size.height) {
                                              setState(() {
                                                _tagsHeight = size.height;
                                              });
                                            }
                                          },
                                          children: _tagButtons(context),
                                        ))
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                            padding: EdgeInsets.all(2),
                                            child: Wrap(
                                              spacing: 6,
                                              children: _tagButtons(context),
                                            )))))
                      ],
                    )),
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: filteredAvatars
                        .map((avatar) => ClickableView(
                              key: Key(avatar.id),
                              child: AvatarView(
                                avatar: avatar,
                                pcAvatarPackageInformation:
                                    _avatarPackageInformations[(
                                  avatarId: avatar.id,
                                  platform: AvatarWithStat.platformPc
                                )],
                                androidAvatarPackageInformation:
                                    _avatarPackageInformations[(
                                  avatarId: avatar.id,
                                  platform: AvatarWithStat.platformAndroid
                                )],
                                selected: _editTagAvatarTag != null &&
                                    _editTagAvatarTag!.avatarIds
                                        .contains(avatar.id),
                                showHaveImposter: _showHaveImposter,
                                showNotHaveImposter: _showNotHaveImposter,
                                showTags: _showTags,
                              ),
                              onTap: () => _editTagAvatarTag == null
                                  ? _changeAvatar(avatar.id)
                                  : _toggleTagAvatar(avatar.id),
                            ))
                        .toList(),
                  ),
                ),
              ),
            )));
  }
}
