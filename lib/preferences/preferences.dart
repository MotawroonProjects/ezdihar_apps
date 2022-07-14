import 'dart:convert';

import 'package:ezdihar_apps/models/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
   static final Preferences instance = Preferences._internal();
   Preferences._internal();
   factory Preferences()=>instance;

   Future<void> setAppSetting(AppSettings appSettings)async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('appSetting', json.encode(appSettings.toJson(appSettings)));

   }

   Future<AppSettings> getAppSetting()async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? jsonData = preferences.getString('appSetting');
      AppSettings appSettings;
      if(jsonData==null){
         appSettings = AppSettings(lang: 'ar');
      }else{
      appSettings = AppSettings.fromJson(jsonData);
      }

      return appSettings;

   }
}