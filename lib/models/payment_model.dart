import 'package:ezdihar_apps/models/advisor_model.dart';
import 'package:ezdihar_apps/models/chat_model.dart';
import 'package:ezdihar_apps/models/consultant_type_model.dart';
import 'package:ezdihar_apps/models/payment_data.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/sub_category_model.dart';
import 'package:ezdihar_apps/models/user.dart';

class PaymentDataModel {
  late ChatModel room;
  late StatusResponse status;



  PaymentDataModel.fromJson(Map<String, dynamic> json) {
    room = json['room']!=null?ChatModel.fromJson(json['room']):ChatModel();
    status = StatusResponse.fromJson(json);
  }


}
