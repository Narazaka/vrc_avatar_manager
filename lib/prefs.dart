import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrc_avatar_manager/sort_by.dart';

const _tagDbVersion = "tagDbVersion";
const _avatarPackageInformationDbUnityPackageSelectBugFixed =
    "avatarPackageInformationDbUnityPackageSelectBugFixed2";
const _avatarPackageInformationDbUnityPackageSelectBugFixedByAccount =
    "avatarPackageInformationDbUnityPackageSelectBugFixedByAccount2";
const _windowWidth = "windowWidth";
const _windowHeight = "windowHeight";
const _windowPositionX = "windowPositionX";
const _windowPositionY = "windowPositionY";
const _windowMaximized = "windowMaximized";
const _confirmWhenChangeAvatar = "confirmWhenChangeAvatar";
const _selectSingleTag = "selectSingleTag";
const _multiLineTagsView = "multiLineTagsView";
const _ascending = "ascending";
const _sortBy = "sortBy";
const _fetchAvatarSize = "fetchAvatarSize";
const _showHaveImposter = "showHaveImposter";
const _showNotHaveImposter = "showNotHaveImposter";
const _showTags = "showTags";

class Prefs {
  static Prefs? _instance;

  Prefs._(this._prefs);

  final SharedPreferences _prefs;

  static Future<Prefs> get instance async {
    return _instance ??= Prefs._(await SharedPreferences.getInstance());
  }

  Future<int> tagDbVersion(String accountId) async {
    return _prefs.getInt("$_tagDbVersion.$accountId") ?? 0;
  }

  Future<void> setTagDbVersion(String accountId, int value) async {
    await _prefs.setInt("$_tagDbVersion.$accountId", value);
  }

  Future<bool> get avatarPackageInformationDbUnityPackageSelectBugFixed async {
    return _prefs
            .getBool(_avatarPackageInformationDbUnityPackageSelectBugFixed) ??
        false;
  }

  Future<void> setAvatarPackageInformationDbUnityPackageSelectBugFixed(
      bool value) async {
    await _prefs.setBool(
        _avatarPackageInformationDbUnityPackageSelectBugFixed, value);
  }

  Future<bool> avatarPackageInformationDbUnityPackageSelectBugFixedByAccount(
      String accountId) async {
    return _prefs.getBool(
            "$_avatarPackageInformationDbUnityPackageSelectBugFixedByAccount.$accountId") ??
        false;
  }

  Future<void> setAvatarPackageInformationDbUnityPackageSelectBugFixedByAccount(
      String accountId, bool value) async {
    await _prefs.setBool(
        "$_avatarPackageInformationDbUnityPackageSelectBugFixedByAccount.$accountId",
        value);
  }

  Future<double> get windowWidth async {
    return _prefs.getDouble(_windowWidth) ?? 1276;
  }

  Future<void> setWindowWidth(double value) async {
    await _prefs.setDouble(_windowWidth, value);
  }

  Future<double> get windowHeight async {
    return _prefs.getDouble(_windowHeight) ?? 713;
  }

  Future<void> setWindowHeight(double value) async {
    await _prefs.setDouble(_windowHeight, value);
  }

  Future<Size> get windowSize async {
    return Size(await windowWidth, await windowHeight);
  }

  Future<void> setWindowSize(Size value) async {
    await setWindowWidth(value.width);
    await setWindowHeight(value.height);
  }

  Future<double?> get windowPositionX async {
    return _prefs.getDouble(_windowPositionX);
  }

  Future<void> setWindowPositionX(double value) async {
    await _prefs.setDouble(_windowPositionX, value);
  }

  Future<double?> get windowPositionY async {
    return _prefs.getDouble(_windowPositionY);
  }

  Future<void> setWindowPositionY(double value) async {
    await _prefs.setDouble(_windowPositionY, value);
  }

  Future<Offset?> get windowPosition async {
    final x = await windowPositionX;
    final y = await windowPositionY;
    if (x == null || y == null) {
      return null;
    }
    return Offset(x, y);
  }

  Future<void> setWindowPosition(Offset offset) async {
    await setWindowPositionX(offset.dx);
    await setWindowPositionY(offset.dy);
  }

  Future<bool> get windowMaximized async {
    return _prefs.getBool(_windowMaximized) ?? false;
  }

  Future<void> setWindowMaximized(bool value) async {
    await _prefs.setBool(_windowMaximized, value);
  }

  Future<bool> get confirmWhenChangeAvatar async {
    return _prefs.getBool(_confirmWhenChangeAvatar) ?? false;
  }

  Future<void> setConfirmWhenChangeAvatar(bool value) async {
    await _prefs.setBool(_confirmWhenChangeAvatar, value);
  }

  Future<bool> get selectSingleTag async {
    return _prefs.getBool(_selectSingleTag) ?? false;
  }

  Future<void> setSelectSingleTag(bool value) async {
    await _prefs.setBool(_selectSingleTag, value);
  }

  Future<bool> get multiLineTagsView async {
    return _prefs.getBool(_multiLineTagsView) ?? false;
  }

  Future<void> setMultiLineTagsView(bool value) async {
    await _prefs.setBool(_multiLineTagsView, value);
  }

  Future<bool> get ascending async {
    return _prefs.getBool(_ascending) ?? false;
  }

  Future<void> setAscending(bool value) async {
    await _prefs.setBool(_ascending, value);
  }

  Future<SortBy> get sortBy async {
    var value = _prefs.getInt(_sortBy);
    return SortBy.values[value ?? 0];
  }

  Future<void> setSortBy(SortBy value) async {
    await _prefs.setInt(_sortBy, value.index);
  }

  Future<bool> get fetchAvatarSize async {
    return _prefs.getBool(_fetchAvatarSize) ?? false;
  }

  Future<void> setFetchAvatarSize(bool value) async {
    await _prefs.setBool(_fetchAvatarSize, value);
  }

  Future<bool> get showHaveImposter async {
    return _prefs.getBool(_showHaveImposter) ?? true;
  }

  Future<void> setShowHaveImposter(bool value) async {
    await _prefs.setBool(_showHaveImposter, value);
  }

  Future<bool> get showNotHaveImposter async {
    return _prefs.getBool(_showNotHaveImposter) ?? false;
  }

  Future<void> setShowNotHaveImposter(bool value) async {
    await _prefs.setBool(_showNotHaveImposter, value);
  }

  Future<bool> get showTags async {
    return _prefs.getBool(_showTags) ?? true;
  }

  Future<void> setShowTags(bool value) async {
    await _prefs.setBool(_showTags, value);
  }
}
