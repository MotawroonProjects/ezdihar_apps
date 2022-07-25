import 'dart:convert';

import 'package:ezdihar_apps/models/app_settings.dart';
import 'package:ezdihar_apps/models/user.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;

  Future<void> setAppSetting(AppSettings appSettings) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
        'appSetting', json.encode(appSettings.toJson(appSettings)));
  }

  Future<AppSettings> getAppSetting() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('appSetting');
    AppSettings appSettings;
    if (jsonData == null) {
      appSettings = AppSettings(lang: 'ar');
    } else {
      appSettings = AppSettings.fromJson(jsonData);
    }

    return appSettings;
  }

  Future<void> setUser(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user', json.encode(UserModel.toJson(userModel)));
  }

  Future<UserModel> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    UserModel userModel;
    if (jsonData != null) {
      userModel = UserModel.fromJson(jsonDecode(jsonData));
      userModel.user.isLoggedIn = true;
    }else{
      userModel = UserModel();
      User user = User();
      userModel.user = user;
      userModel.user.isLoggedIn = false;

    }

    return userModel;
  }
}
