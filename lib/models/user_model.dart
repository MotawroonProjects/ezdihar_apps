import 'package:ezdihar_apps/models/advisor_model.dart';
import 'package:ezdihar_apps/models/sub_category_model.dart';
import 'package:ezdihar_apps/models/user.dart';

import 'category_model.dart';

class UserModel {
  late User user;
  AdvisorModel? adviser_data;
  late String access_token;
  late String firebase_token = '';
   SubCategoryModel? sub_category;
  CategoryModel? main_category;
  SubCategory? subCategory;
  List<SubCategories>? advisor_category;
  List<SubCategories>? sub_categories;

  UserModel() {
    user = User();
    user.isLoggedIn = false;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    adviser_data = json['adviser_data'] != null
        ? AdvisorModel.fromJson(json['adviser_data'])
        : null;
    access_token =
        json['access_token'] != null ? json['access_token'] as String : '';
    sub_category = json['sub_category'] != null
        ? SubCategoryModel.fromJson(json['sub_category'])
        : null;
    main_category = json['main_category'] != null
        ? CategoryModel.fromJson(json['main_category'])
        : null;
    subCategory = json['sub_category'] != null
        ? new SubCategory.fromJson(json['sub_category'])
        : null;
    if (json['advisor_category'] != null) {
      advisor_category = <SubCategories>[];
      json['advisor_category'].forEach((v) {
        advisor_category!.add(new SubCategories.fromJson(v));
      });
    }
    if (json['sub_categories'] != null) {
      sub_categories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        sub_categories!.add(new SubCategories.fromJson(v));
      });
    }
  }

  static Map<String, dynamic> toJson(UserModel user) {
    return {
      'user': User.toJson(user.user),
      'adviser_data': user.adviser_data != null
          ? AdvisorModel.toJson(user.adviser_data)
          : null,
      'access_token': user.access_token,
      'firebase_token': user.firebase_token,
      'main_category': user.main_category != null
          ? CategoryModel.toJson(user.main_category!)
          : null,
    if (user.subCategory != null)
      'sub_category' : user.subCategory!.toJson(),

    if (user.advisor_category != null)
      'advisor_category':
          user.advisor_category!.map((v) => v.toJson()).toList(),
      if (user.sub_categories != null)
        'sub_categories':
        user.sub_categories!.map((v) => v.toJson()).toList()

    };
  }
}



class SubCategory {
  int? id;
  String? titleAr;
  String? titleEn;
  int? limit;
  String? image;

  SubCategory({this.id, this.titleAr, this.titleEn, this.limit, this.image});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
    limit = json['limit'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_ar'] = this.titleAr;
    data['title_en'] = this.titleEn;
    data['limit'] = this.limit;
    data['image'] = this.image;
    return data;
  }
}
class SubCategories {
  int? id;
  String? descAr;
  String? descEn;
  int? price;
  CategoryModel? service;

  SubCategories({this.id, this.descAr, this.descEn, this.price, this.service});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descAr = json['desc_ar'];
    descEn = json['desc_en'];
    price = json['price'];
    service =
    json['service'] != null ?  CategoryModel.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['desc_ar'] = this.descAr;
    data['desc_en'] = this.descEn;
    data['price'] = this.price;
    if (this.service != null) {
      data['service'] = CategoryModel.toJson(this.service!);
    }
    return data;
  }
}