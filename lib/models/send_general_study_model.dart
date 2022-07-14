import 'dart:ui';

class SendGeneralStudyModel {
  String projectName = '';
  String details = '';
  String feasibilityStudy = '';
  bool showProjectInvestment =false;


  bool isDataValid() {

    if (projectName.isNotEmpty &&
        details.isNotEmpty &&
        feasibilityStudy.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
