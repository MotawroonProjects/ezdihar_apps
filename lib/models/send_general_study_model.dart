import 'dart:ui';

import 'package:ezdihar_apps/models/consultant_type_model.dart';

class SendGeneralStudyModel {
  String category_id ='';
  String project_photo_path ='';
  String projectName = '';
  String details = '';
  String feasibilityStudy = '';
  bool showProjectInvestment =false;
  List<int> consultantTypes = [];


  bool isDataValid() {
    print('data=>${projectName+"__"+details+"__"+feasibilityStudy+"__"+consultantTypes.length.toString()}');
    if (category_id.isNotEmpty &&
        project_photo_path.isNotEmpty &&
        projectName.isNotEmpty &&
        details.isNotEmpty &&
        feasibilityStudy.isNotEmpty&&
        consultantTypes.length>0) {
      return true;
    } else {
      return false;
    }
  }

  addRemoveConsultant(ConsultantTypeModel model){
    int pos = getConsultantPos(model);
    if(model.isSelected){
      if(pos == -1){
        consultantTypes.add(model.id);
      }
    }else{
      if(pos != -1){
        consultantTypes.removeAt(pos);
      }
    }

  }

  int getConsultantPos(ConsultantTypeModel model){
    int pos = -1;
    for(int index = 0;index<consultantTypes.length;index++){
      if(consultantTypes[index] == model.id){
        return index;
      }
    }
    return pos;
  }
}
