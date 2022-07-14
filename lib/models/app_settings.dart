import 'dart:convert';

class AppSettings {
  String lang = 'ar';

  AppSettings({required this.lang});

  Map<String,dynamic> toJson(AppSettings appSettings)=>{
    'lang':appSettings.lang
  };

  factory AppSettings.fromJson(String jsonData){
    Map<String,dynamic> map = jsonDecode(jsonData);
    return AppSettings(lang: map['lang']);
  }
}
