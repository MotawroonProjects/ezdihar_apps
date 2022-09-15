import 'package:ezdihar_apps/models/advisor_model.dart';
import 'package:ezdihar_apps/models/consultant_type_model.dart';
import 'package:ezdihar_apps/models/payment_data.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/sub_category_model.dart';
import 'package:ezdihar_apps/models/user.dart';

class PaymentDataModel {
  late PaymentData paymentData;
  late StatusResponse status;



  PaymentDataModel.fromJson(Map<String, dynamic> json) {
    paymentData = json['data']!=null?PaymentData.fromJson(json['data']):PaymentData();
    status = StatusResponse.fromJson(json);
  }


}
