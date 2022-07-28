import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';

class CityDataModel{
  late List<CityModel> data;
  late StatusResponse status;

  CityDataModel.fromJson(Map<String,dynamic> json){
    data = [];
    json['data'].forEach((v)=>data.add(CityModel.fromJson(v)));
    status = StatusResponse.fromJson(json);
  }
}