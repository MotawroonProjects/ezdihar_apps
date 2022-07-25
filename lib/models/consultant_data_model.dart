import 'package:ezdihar_apps/models/consultant_type_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';

class ConsultantDataModel{
  late List<ConsultantTypeModel> list;
  late StatusResponse status;

  ConsultantDataModel();

  ConsultantDataModel.fromJson(Map<String,dynamic> json){
    list = [];
    json['data'].forEach((d)=>list.add(ConsultantTypeModel.fromJson(d)));
    status = StatusResponse.fromJson(json);

  }
}