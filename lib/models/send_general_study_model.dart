import 'dart:ui';

import 'package:ezdihar_apps/models/consultant_type_model.dart';

class SendGeneralStudyModel {
  int category_id =0;
  String project_photo_path ='';
  String projectName = '';
  String details = '';
  String feasibilityStudy = '';
  String ownership_rate = '';
  bool showProjectInvestment =false;


  bool isDataValid() {
    print(category_id);
  //  print('data=>${projectName+"__"+details+"__"+feasibilityStudy+"__"+consultantTypes.length.toString()}');
    if (category_id!=0 &&
        project_photo_path.isNotEmpty &&
        projectName.isNotEmpty &&
        details.isNotEmpty &&
        feasibilityStudy.isNotEmpty&&
        ownership_rate.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }


}
