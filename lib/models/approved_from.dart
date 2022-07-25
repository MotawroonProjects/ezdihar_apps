import 'package:ezdihar_apps/models/category_model.dart';

class ApprovedFrom{
  late int id;
  late String title_ar;
  late String title_en;
  late String category_id;
  late String image;
  late CategoryModel category;

  ApprovedFrom.fromJson(Map<String,dynamic> json){
    id = json['id'] as int;
    title_ar = json['title_ar'] as String;
    title_en = json['title_en'] as String;
    category_id = json['category_id']!=null?json['category_id'].toString():"";
    image = json['image'] as String;
    title_ar = json['title_ar'] as String;
    category = CategoryModel.fromJson(json['category']);
  }
}