import 'dart:io';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_response_validator/dio_response_validator.dart';
import 'package:vrc_avatar_manager/app_dir.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:dio/dio.dart';

class VrcApi {
  const VrcApi({required this.accountId, required this.vrchatDart});

  final String accountId;
  final VrchatDart vrchatDart;

  static String appVersion = "0.0.1";

  static VrcApi load(String accountId) {
    return VrcApi(accountId: accountId, vrchatDart: getVrchatDart(accountId));
  }

  static VrcApi loadByAuthToken(String accountId, String authToken) {
    var vrchatDart = getVrchatDart(accountId);
    var cookieManager = (vrchatDart.rawApi.dio.interceptors
        .firstWhere((i) => i is CookieManager) as CookieManager);
    cookieManager.cookieJar.saveFromResponse(
        Uri.https("api.vrchat.cloud", "/"), [
      Cookie.fromSetCookieValue(
          'auth=$authToken; Path=/; HttpOnly; SameSite=Lax;')
    ]);
    return VrcApi(accountId: accountId, vrchatDart: vrchatDart);
  }

  static String cookiePath(String accountId) {
    return "${AppDir.dir}/.cookie/$accountId";
  }

  static VrchatDart getVrchatDart(String accountId) {
    var dir = cookiePath(accountId);
    Directory(dir).createSync(recursive: true);
    return VrchatDart(cookiePath: dir, userAgent: userAgent);
  }

  static Future<void> clearCookies(String accountId) async {
    var dir = cookiePath(accountId);
    await Directory(dir).delete(recursive: true);
  }

  static VrchatUserAgent? _userAgent;

  static VrchatUserAgent get userAgent {
    return _userAgent ??= VrchatUserAgent(
        applicationName: "VRCAvatarManager",
        version: appVersion,
        contactInfo: "VRCAvatarManager");
  }

  static String? _userAgentString;
  static String get userAgentString {
    return _userAgentString ??= userAgent.toString();
  }

  Future<bool> checkValid() async {
    return (await check()).succeeded;
  }

  Future<ValidatedResponse<CurrentUser, CurrentUser>> check() async {
    return vrchatDart.rawApi
        .getAuthenticationApi()
        .getCurrentUser()
        .validateVrc();
  }

  Future<void> logout() async {
    await vrchatDart.auth.logout();
  }

  Future<List<Avatar>?> avatars(int page) async {
    var res = await vrchatDart.rawApi
        .getAvatarsApi()
        .searchAvatars(
            releaseStatus: ReleaseStatus.all,
            user: "me",
            sort: SortOption.created,
            order: OrderOption.descending,
            n: 100,
            offset: (page - 1) * 100)
        .validateVrc();
    if (res.succeeded) {
      return res.success!.data;
    }
    print(res.failure.toString());
    return null;
  }

  Future<ValidatedResponse<CurrentUser, CurrentUser>> changeAvatar(
      String id) async {
    return await vrchatDart.rawApi
        .getAvatarsApi()
        .selectAvatar(avatarId: id)
        .validateVrc();
  }

  Future<Avatar?> avatar(String id) async {
    final res = await vrchatDart.rawApi
        .getAvatarsApi()
        .getAvatar(avatarId: id)
        .validateVrc();
    if (res.succeeded) {
      return res.success!.data;
    }
    print(res.failure.toString());
    return null;
  }

  Future<int?> fileSize(String url) async {
    final options = Options(
      method: r'GET',
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'apiKey',
            'name': 'authCookie',
            'keyName': 'auth',
            'where': '',
          },
        ],
      },
    );
    try {
      final res = await vrchatDart.rawApi.dio.head(url, options: options);
      if (res.statusCode != 200) {
        print("file head error: ${res.statusCode} ${res.statusMessage}");
        return null;
      }
      final lenStr = res.headers.value("content-length");
      if (lenStr == null) {
        print("file head error: no content-length");
        return null;
      }
      final len = int.tryParse(lenStr);
      if (len == null) {
        print("file head error: invalid content-length");
        return null;
      }
      return len;
    } catch (e) {
      print("file head dio error: $e");
      print(url);
      return null;
    }
  }
}
