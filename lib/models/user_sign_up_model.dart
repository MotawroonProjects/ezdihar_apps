import 'package:email_validator/email_validator.dart';

class UserSignUpModel {
  String imagePath = '';
  String phone_code ='';
  String phone = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  int cityId = 0;
  String dateOfBirth = '';
  String cv_path='';

  bool isDataValid() {
    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        cityId!=0&&
        EmailValidator.validate(email) &&
        dateOfBirth.isNotEmpty) {

      print('Data=>${
      firstName+"__"+lastName+"_"+cityId.toString()+"__"+email+"__"+dateOfBirth+"__"+imagePath
      }');
      return true;
    }

    return false;
  }
}
