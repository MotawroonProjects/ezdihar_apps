import 'dart:convert';

import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_model.dart';

class ConsultantsDataModel {
  late List<UserModel> data;
  late StatusResponse status;

  ConsultantsDataModel();

  ConsultantsDataModel.fromJson(Map<String, dynamic> json) {
    data = [];
    json['data'].forEach((v) => data.add(UserModel.fromJson(v)));
    status = StatusResponse.fromJson(json);
  }
}
