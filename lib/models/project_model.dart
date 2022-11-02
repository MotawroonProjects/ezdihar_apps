import 'package:ezdihar_apps/models/approved_from.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/provider_model.dart';
import 'package:ezdihar_apps/models/user.dart';

class ProjectModel {
  late int id;
  late String description;
  late int status;
  late String img;


  late ProviderDataModel provider;
  ProjectModel();

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    description = json['description'] as String;
    status = json['status'] as int;
    img = json['img'] as String;

    provider = ProviderDataModel.fromJson(json['provider']);
  }
}
