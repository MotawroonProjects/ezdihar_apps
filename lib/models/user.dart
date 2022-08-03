import 'package:ezdihar_apps/models/city_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  late int id;
  late String firstName='';
  late String lastName='';
  late String phoneCode;
  late String phone='';
  late String email='';
  late String image='';
  late String birthdate='';
  late String userType;
  late CityModel city;
  late bool isLoggedIn = false;


  User();

  User.fromJson(Map<String,dynamic> json){
    id = json['id'] as int;
    firstName = json['first_name'] as String;
    lastName  = json['last_name']  as String;
    phoneCode = json['phone_code'] as String;
    phone     = json['phone'] as String;
    email     = json['email']!=null?json['email'] as String:"";
    image     = json['image']!=null?json['image'] as String:"";
    birthdate = json['birthdate'] as String;
    userType  = json['user_type'] as String;
    city      = CityModel.fromJson(json['city']);

  }

  static Map<String,dynamic> toJson(User user){
    return {
      'id'         :user.id,
      'first_name' :user.firstName,
      'last_name'  :user.lastName,
      'phone_code' :user.phoneCode,
      'phone'      :user.phone,
      'email'      :user.email,
      'image'      :user.image,
      'birthdate'  :user.birthdate,
      'user_type'  :user.userType,
      'city'       :CityModel.toJson(user.city),
    };
  }
}