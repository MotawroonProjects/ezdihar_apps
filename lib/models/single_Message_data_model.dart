import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/all_message_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';

import 'message_model.dart';

class SingleMessageDataModel {
   MessageModel? data;
   StatusResponse? status;

  SingleMessageDataModel() {
    status = StatusResponse();
    data=MessageModel();
  }

  SingleMessageDataModel.fromJson(Map<String, dynamic> json) {
    data = json['data']!=null?MessageModel.fromJson(json['data']):null;

    status = StatusResponse.fromJson(json);
  }
}
