import 'package:ezdihar_apps/models/consultant_type_model.dart';

class AdvisorModel {
  late int consultant_type_id;
  late int years_ex;
  late dynamic consultant_price;
  late String bio;
  late int rate;
  late int count_people;
  late ConsultantTypeModel consultant_type;
  late String graduation_rate;

  AdvisorModel();

  AdvisorModel.fromJson(Map<String, dynamic> json) {

    consultant_type_id = json['consultant_type_id']!=null?json['consultant_type_id'] as int:0;
    years_ex = json['years_ex']!=null?json['years_ex'] as int:0;
    consultant_price = json['consultant_price']!=null?json['consultant_price']:0.0;
    bio = json['bio']!=null?json['bio'] as String:"";
    rate = json['rate'] != null ? json['rate'] as int : 0;
    count_people =
        json['count_people'] != null ? json['count_people'] as int : 0;
    graduation_rate = json['graduation_rate'] != null
        ? json['graduation_rate'] as String
        : '';


    consultant_type = json['adviser_data'] != null
        ? ConsultantTypeModel.fromJson(json['adviser_data'])
        : (json['consultant_type'] != null?ConsultantTypeModel.fromJson(json['consultant_type']):ConsultantTypeModel());
  }

  static Map<String, dynamic> toJson(AdvisorModel? advisorModel) {
    if (advisorModel != null) {
      return {
        'consultant_type_id': advisorModel.consultant_type_id,
        'years_ex': advisorModel.years_ex,
        'consultant_price': advisorModel.consultant_price,
        'bio': advisorModel.bio,
        'consultant_type': AdvisorModel.toJson(advisorModel)
      };


    }
    return {};
  }
}
