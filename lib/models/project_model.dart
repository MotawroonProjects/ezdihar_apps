import 'package:ezdihar_apps/models/approved_from.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/user.dart';

class ProjectModel {
  late int id;
  late String title;
  late String text;
  late String image;
  late String date;
  late String time;
  late int likesCount=0;
  late bool isLicked;
  late bool isFollowed;
  late bool is_reported;
  late String categoryId;
  late int userId;
  late CategoryModel category;
  late List<ApprovedFrom> approvedFrom;
  late User user;
  ProjectModel();

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    title = json['title'] as String;
    text = json['text']!=null?json['text'] as String:"";
    image = json['image'] as String;
    date = json['date'] as String;
    time = json['time'] as String;
    likesCount = json['likes_count'] as int;
    isLicked = json['is_licked'] as bool;
    is_reported = json['is_reported'] as bool;
    isFollowed = json['is_followed'] as bool;
    categoryId = json['category_id']!=null?json['category_id'].toString():"";
    userId = json['user_id'] as int;
    category = json['category']!=null?CategoryModel.fromJson(json['category']):CategoryModel();
    approvedFrom = <ApprovedFrom>[];
    json['approved_from'].forEach((v)=>{
      approvedFrom.add(ApprovedFrom.fromJson(v))
    });
    user = User.fromJson(json['user']);
  }
}
