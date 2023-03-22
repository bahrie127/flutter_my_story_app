import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_response_model.dart';

class AuthPreference {
  final Future<SharedPreferences> _prefs;

  AuthPreference(
    Future<SharedPreferences> prefs,
  ) : _prefs = prefs;

  static const _key = "KEY";

  Future<bool> saveAuthData(LoginResult loginData) async {
    final SharedPreferences prefs = await _prefs;
    final res = await prefs.setString(_key, json.encode(loginData));

    return res;
  }

  Future<bool> isUserLogin() async {
    final res = await getAuthData();

    if (res != null) {
      return true;
    }

    return false;
  }

  Future<LoginResult?> getAuthData() async {
    final SharedPreferences prefs = await _prefs;
    final res = prefs.getString(_key);

    if (res != null) {
      final loginData = LoginResult.fromJson(json.decode(res));
      return loginData;
    }

    return null;
  }

  Future<bool> removeAuthData() async {
    final SharedPreferences prefs = await _prefs;
    final res = prefs.remove(_key);

    return res;
  }
}
