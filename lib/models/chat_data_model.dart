import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';

import 'chat_model.dart';

class ChatDataModel {
  late List<ChatModel> data;
  late StatusResponse status;

  ChatDataModel() {
    status = StatusResponse();
  }

  ChatDataModel.fromJson(Map<String, dynamic> json) {
    data = [];
    json['data'].forEach((d)=>data.add(ChatModel.fromJson(d)));
    status = StatusResponse.fromJson(json);
  }
}
