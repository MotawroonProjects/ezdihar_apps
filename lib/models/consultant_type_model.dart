import 'package:ezdihar_apps/models/category_model.dart';

class ConsultantTypeModel {
  late int id;
  late String title_ar;
  late String title_en='';
  late int category_id;
  late String image;
  late CategoryModel category;


  ConsultantTypeModel();

  ConsultantTypeModel.fromJson(Map<String, dynamic> json) {
    print('json${json.toString()}');

    id = json['id'] as int;
    title_ar = json['title_ar']!=null? json['title_ar'] as String:"";
    title_en =  json['title_en'] as String;
    category_id = json['category_id'] as int;
    image = json['image']!=null?json['image'] as String:"";
    category = CategoryModel.fromJson(json['category']);
  }
  static Map<String,dynamic> toJson(ConsultantTypeModel model){
    return {
      'id':model.id,
      'title_ar':model.title_ar,
      'title_en':model.title_en,
      'category_id':model.category_id,
      'image':model.image,
      'category':CategoryModel.toJson(model.category),
    };
  }
}
