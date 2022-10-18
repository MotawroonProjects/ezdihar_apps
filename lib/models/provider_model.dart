import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user.dart';
import 'package:ezdihar_apps/models/user_model.dart';

class ProviderDataModel{
  late List<User> data;
  late StatusResponse status;

  ProjectsDataModel(){
    status = StatusResponse();
  }

  ProviderDataModel.fromJson(Map<String,dynamic> json){
    data = <User>[];
    print("sss${data.length}");
    if(json['data']!=null){
      json['data'].forEach((v)=>{
        data.add(User.fromJson(v))
      });
    }

    status = StatusResponse.fromJson(json);
  }


}