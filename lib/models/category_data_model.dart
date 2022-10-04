import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';

class CategoryDataModel {
  late List<CategoryModel> data;
  late StatusResponse status;

  CategoryDataModel() {
    status = StatusResponse();
  }

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    data = [];
    json['data'].forEach((v) {
      CategoryModel model = CategoryModel.fromJson(v);
      data.add(model);
    });
    status = StatusResponse.fromJson(json);
  }
}
