import 'package:ezdihar_apps/models/project_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';

class ProjectsDataModel{
  late List<ProjectModel> data;
  late StatusResponse status;

  ProjectsDataModel(){
    status = StatusResponse();
  }

  ProjectsDataModel.fromJson(Map<String,dynamic> json){
    data = <ProjectModel>[];
    if(json['posts']!=null){
      json['posts'].forEach((v)=>{
        data.add(ProjectModel.fromJson(v))
      });
    }

    status = StatusResponse.fromJson(json);
  }


}