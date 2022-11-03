import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/models/sub_category_model.dart';

import 'category_model.dart';

class User {
  late int id;
  late String firstName = '';
  late String lastName = '';
  late String phoneCode;
  late String phone = '';
  late String email = '';
  late String image = '';
  late String birthdate = '';
  late String userType;
  late CityModel city;
  late int cityId;
  late int wallet;
  late bool isLoggedIn = false;
  late String lan;
  List<SubCategoryModel>? subCategories;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    firstName = json['first_name'] ?? '' as String;
    lastName = json['last_name'] ?? '' as String;
    phoneCode = json['phone_code'] ?? '' as String;
    phone = json['phone'] ?? '' as String;
    email = json['email'] != null ? json['email'] as String : "";
    image = json['image'] != null ? json['image'] as String : "";
    birthdate = json['birthdate'] ?? '' as String;
    userType = json['user_type'] ?? '' as String;
    cityId = json['city_id'] != null ? json['city_id'] as int : 0;
    wallet = json['wallet'] != null ? json['wallet'] as int : 0;
    city = json['city'] != null
        ? CityModel.fromJson(
            json['city'],
          )
        : CityModel.initValues();
    if (json['advisor_category'] != null) {
      subCategories = <SubCategoryModel>[];
      json['advisor_category'].forEach((v) {
        subCategories!.add(new SubCategoryModel.fromJson(v));
      });
    }

  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'first_name': user.firstName,
      'last_name': user.lastName,
      'phone_code': user.phoneCode,
      'phone': user.phone,
      'email': user.email,
      'image': user.image,
      'birthdate': user.birthdate,
      'user_type': user.userType,
      "city_id": user.cityId,
      "wallet": user.wallet,
      'city': CityModel.toJson(user.city),
      if (user.subCategories != null)
        'advisor_category': user.subCategories!.map((v) => v.toJson(v)).toList()
    };
  }
}
