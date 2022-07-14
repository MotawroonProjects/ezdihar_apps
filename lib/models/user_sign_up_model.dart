import 'package:email_validator/email_validator.dart';

class UserSignUpModel {
  String imagePath = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String cityId = '';
  String dateOfBirth = '';
  String cv_path='';

  bool isDataValid() {
    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        EmailValidator.validate(email) &&
        dateOfBirth.isNotEmpty&&
        cv_path.isNotEmpty ) {
      return true;
    }

    return false;
  }
}
