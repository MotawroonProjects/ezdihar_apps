import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/models/sub_category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionData {
  late String url;

  TransactionData();

  TransactionData.fromJson(Map<String,dynamic> json){
    url = json['url'] as String;
    }
}