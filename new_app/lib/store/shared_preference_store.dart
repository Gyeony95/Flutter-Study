import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceKey {
  static const isDevUsed = 'isDevUsed';

  static const seenTour = 'seenTour';

  static const loginType = 'loginType';
  static const accessToken = 'accessToken';
  static const idToken = 'idToken';

  static const userId = 'userId';
  static const userPw = 'userPw';
  static const pushToken = 'pushToken';

  static const savedFilePaths = 'savedFilePaths';

}

class LoginType {
  static const normal = 'normal';
  static const kakao = 'kakao';
  static const apple = 'apple';
}

class SharedPreferenceStore {
  factory SharedPreferenceStore() => _instance;

  static final _instance = SharedPreferenceStore.private();

  Future<SharedPreferences> _sharedPreferences;

  @visibleForTesting
  SharedPreferenceStore.private() {
    _sharedPreferences = _initSharedPreference();
  }

  Future<SharedPreferences> _initSharedPreference() async {
    return await SharedPreferences.getInstance();
  }

  Future<String> getLoginType() async {
    final sharedPreference = await _sharedPreferences;
    return sharedPreference.getString(SharedPreferenceKey.loginType);
  }

  Future<void> setLoginType({loginType = LoginType.normal}) async {
    final sharedPreference = await _sharedPreferences;
    await sharedPreference.setString(SharedPreferenceKey.loginType, loginType);
  }

  Future<String> getKakaoAccessToken() async {
    final sharedPreference = await _sharedPreferences;
    return sharedPreference.getString(SharedPreferenceKey.accessToken);
  }

  Future<void> setKakaoAccessToken({accessToken}) async {
    final sharedPreference = await _sharedPreferences;
    await sharedPreference.setString(
        SharedPreferenceKey.accessToken, accessToken);
  }

  Future<String> getAppleIdToken() async {
    final sharedPreference = await _sharedPreferences;
    return sharedPreference.getString(SharedPreferenceKey.idToken);
  }

  Future<void> setAppleIdToken({idToken}) async {
    final sharedPreference = await _sharedPreferences;
    await sharedPreference.setString(SharedPreferenceKey.idToken, idToken);
  }

  Future<String> getUserId() async {
    return (await _sharedPreferences).getString(SharedPreferenceKey.userId);
  }

  Future<void> setUserId({userId}) async {
    await (await _sharedPreferences)
        .setString(SharedPreferenceKey.userId, userId);
  }

  Future<String> getUserPw() async {
    return (await _sharedPreferences).getString(SharedPreferenceKey.userPw);
  }

  Future<void> setUserPw({userPw}) async {
    await (await _sharedPreferences)
        .setString(SharedPreferenceKey.userPw, userPw);
  }

  Future<String> getPushToken() async {
    return (await _sharedPreferences).getString(SharedPreferenceKey.pushToken);
  }

  Future<void> setPushToken(String token) async {
    await (await _sharedPreferences)
        .setString(SharedPreferenceKey.pushToken, token);
  }

  Future<void> setSeenTour(bool seenTour) async {
    await (await _sharedPreferences)
        .setBool(SharedPreferenceKey.seenTour, seenTour);
  }


  Future<bool> isSeenTour() async {
    return (await _sharedPreferences).getBool(SharedPreferenceKey.seenTour) ??
        false;
  }

  //GHGHGH -2.3.1 Notice Dialog, key는 이미지url(고유값), value는 bool
  Future<void> setChatNoticeCheck(String key, bool chatNoticeCheck) async {
    await (await _sharedPreferences)
        .setBool(key, chatNoticeCheck);
  }
  Future<bool> getChatNoticeCheck(String key) async {
    return (await _sharedPreferences).getBool(key);
  }

  Future<void> setDevUsed(bool isDevUsed) async =>
      await (await _sharedPreferences)
          .setBool(SharedPreferenceKey.isDevUsed, isDevUsed);

  Future<bool> isDevUsed() async {
    var isDevUsed =
        (await _sharedPreferences).getBool(SharedPreferenceKey.isDevUsed);
    if (isDevUsed == null) {
      await setDevUsed(!kReleaseMode);
      isDevUsed = !kReleaseMode;
    }
    return isDevUsed;
  }

  Future<void> setSavedFilePaths(String id, String path) async {
    final paths = await getSavedFilePaths();
    paths.putIfAbsent(id, () => path);

    await (await _sharedPreferences).setString(
      SharedPreferenceKey.savedFilePaths,
      jsonEncode(paths),
    );
  }

  Future<Map<String, String>> getSavedFilePaths() async {
    final paths = await (await _sharedPreferences)
        .getString(SharedPreferenceKey.savedFilePaths);

    return Map.from(
      paths?.isNotEmpty == true ? jsonDecode(paths) : HashMap(),
    );
  }

  Future<void> clear() async {
    await (await _sharedPreferences).clear();
  }
}
