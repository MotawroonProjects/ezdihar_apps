import 'package:email_validator/email_validator.dart';

class ConsultantSignUpModel {
  String specialization_id = '';
  String years_experience = '0';
  String price = '';
  String bio = '';
  String cv_path = '';

  bool isDataValid() {
    if (cv_path.isNotEmpty &&
        price.isNotEmpty &&
        bio.isNotEmpty) {
      return true;
    }

    return false;
  }
}
