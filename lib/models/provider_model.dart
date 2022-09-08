import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_data_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';

class ProviderDataModel{
  late List<UserModel> data;
  late StatusResponse status;

  ProjectsDataModel(){
    status = StatusResponse();
  }

  ProviderDataModel.fromJson(Map<String,dynamic> json){
    data = <UserModel>[];
    print("sss${data.length}");
    if(json['data']!=null){
      json['data'].forEach((v)=>{
        data.add(UserModel.fromJson(v))
      });
    }

    status = StatusResponse.fromJson(json);
  }


}