import 'package:ezdihar_apps/models/chat_model.dart';
import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/models/pay_data.dart';
import 'package:ezdihar_apps/models/sub_category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentData {
   PayData? payData;
  late ChatModel room;


  PaymentData();

  PaymentData.fromJson(Map<String,dynamic> json){
    payData = json['payData']!=null?PayData.fromJson(json['payData']):null;
    room = json['room']!=null?ChatModel.fromJson(json['room']):ChatModel();

  }
}