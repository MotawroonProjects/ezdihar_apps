import 'dart:ui';

import 'package:ezdihar_apps/models/consultant_type_model.dart';

class AddPostModel {
  String project_photo_path ='';

  String details = '';



  bool isDataValid() {

  //  print('data=>${projectName+"__"+details+"__"+feasibilityStudy+"__"+consultantTypes.length.toString()}');
    if (
        project_photo_path.isNotEmpty &&

        details.isNotEmpty
       ) {
      return true;
    } else {
      return false;
    }
  }


}
