import 'package:ezdihar_apps/models/advisor_model.dart';
import 'package:ezdihar_apps/models/consultant_type_model.dart';
import 'package:ezdihar_apps/models/user.dart';

class UserModel{
  late User user;
  AdvisorModel? adviser_data;
  late String access_token;
  late String firebase_token='';

  UserModel(){
    user = User();
    user.isLoggedIn = false;
  }

  UserModel.fromJson(Map<String,dynamic> json){
    user = User.fromJson(json['user']);
    adviser_data = json['adviser_data']!=null?AdvisorModel.fromJson(json['adviser_data']):null;
    access_token = json['access_token']!=null? json['access_token'] as String:'';

  }

  static Map<String,dynamic> toJson(UserModel user){
    return {
      'user'           :User.toJson(user.user),
      'adviser_data'   :user.adviser_data!=null?AdvisorModel.toJson(user.adviser_data):null,
      'access_token'   :user.access_token,
      'firebase_token' :user.firebase_token,
    };
  }

}