import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrc_avatar_manager/sort_by.dart';

const _confirmWhenChangeAvatar = "confirmWhenChangeAvatar";
const _ascending = "ascending";
const _sortBy = "sortBy";

class Prefs {
  static Prefs? _instance;

  Prefs._(this._prefs);

  final SharedPreferences _prefs;

  static Future<Prefs> get instance async {
    return _instance ??= Prefs._(await SharedPreferences.getInstance());
  }

  Future<bool> get confirmWhenChangeAvatar async {
    return _prefs.getBool(_confirmWhenChangeAvatar) ?? false;
  }

  Future<void> setConfirmWhenChangeAvatar(bool value) async {
    await _prefs.setBool(_confirmWhenChangeAvatar, value);
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
}
