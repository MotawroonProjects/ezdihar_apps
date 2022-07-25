import 'package:ezdihar_apps/models/advisor_model.dart';
import 'package:ezdihar_apps/models/consultant_type_model.dart';
import 'package:ezdihar_apps/models/user.dart';

class UserModel{
  late User user;
  late AdvisorModel adviser_data;
  late String access_token;
  late String firebase_token='';

  UserModel();

  UserModel.fromJson(Map<String,dynamic> json){
    user = User.fromJson(json['user']);
    adviser_data = AdvisorModel.fromJson(json['adviser_data']);
    access_token = json['access_token'] as String;

  }

  static Map<String,dynamic> toJson(UserModel user){
    return {
      'user'        :User.toJson(user.user),
      'adviser_data' :AdvisorModel.toJson(user.adviser_data),
      'access_token' :user.access_token,
      'firebase_token' :user.firebase_token,
    };
  }

}