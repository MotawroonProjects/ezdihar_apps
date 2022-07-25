import 'package:ezdihar_apps/models/project_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';

class HomeModel{
  late List<ProjectModel> data;
  late StatusResponse status;

  HomeModel(){
    status = StatusResponse();
  }

  HomeModel.fromJson(Map<String,dynamic> json){
    data = <ProjectModel>[];
    if(json['data']!=null){
      json['data'].forEach((v)=>{
        data.add(ProjectModel.fromJson(v))
      });
    }

    status = StatusResponse.fromJson(json);
  }


}