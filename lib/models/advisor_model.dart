import 'package:ezdihar_apps/models/consultant_type_model.dart';

class AdvisorModel {
  late int consultant_type_id;
  late String years_ex;
  late double consultant_price;
  late String bio;
  late ConsultantTypeModel consultant_type;

  AdvisorModel();

  AdvisorModel.fromJson(Map<String, dynamic> json) {
    consultant_type_id = json['consultant_type_id'] as int;
    years_ex = json['years_ex'] as String;
    consultant_price = json['consultant_price'] as double;
    bio = json['bio'] as String;
    consultant_type = json['adviser_data'] != null
        ? ConsultantTypeModel.fromJson(json['adviser_data'])
        : ConsultantTypeModel();
  }

  static Map<String, dynamic> toJson(AdvisorModel advisorModel) {
    return {
      'consultant_type_id': advisorModel.consultant_type_id,
      'years_ex': advisorModel.years_ex,
      'consultant_price': advisorModel.consultant_price,
      'bio': advisorModel.bio,
      'consultant_type': AdvisorModel.toJson(advisorModel)
    };
  }
}
