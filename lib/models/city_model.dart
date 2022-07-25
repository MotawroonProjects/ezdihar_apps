class CityModel {
  late int id;
  late String cityNameAr;
  late String cityNameEn;

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    cityNameAr = json['city_name_ar'] as String;
    cityNameEn = json['city_name_en'] as String;
  }

  static Map<String, dynamic> toJson(CityModel cityModel) {
   return {
     'id':cityModel.id,
     'city_name_ar':cityModel.cityNameAr,
     'city_name_en':cityModel.cityNameEn

   };
  }
}
