import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_model.dart';

class UserDataModel {
  late UserModel userModel;
  late StatusResponse status;
  UserDataModel();

  UserDataModel.fromJson(Map<String,dynamic> json){
    userModel = json['data']!=null?UserModel.fromJson(json['data']):UserModel();
    status = StatusResponse.fromJson(json);
  }

}