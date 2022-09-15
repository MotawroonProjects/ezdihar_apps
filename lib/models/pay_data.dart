import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/models/sub_category_model.dart';
import 'package:ezdihar_apps/models/transaction_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PayData {
  late TransactionData transaction;

  PayData();

  PayData.fromJson(Map<String,dynamic> json){
    transaction = json['transaction']!=null?TransactionData.fromJson(json['transaction']):TransactionData();

  }
}