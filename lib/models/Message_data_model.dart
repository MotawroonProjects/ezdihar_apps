import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/all_message_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';

class MessageDataModel {
  late AllMessageModel data;
  late StatusResponse status;

  MessageDataModel() {
    status = StatusResponse();
  }

  MessageDataModel.fromJson(Map<String, dynamic> json) {
    data = json['data']!=null?AllMessageModel.fromJson(json['data']):AllMessageModel();

    status = StatusResponse.fromJson(json);
  }
}
