import 'dart:ui';

import 'package:email_validator/email_validator.dart';

class ContactUsModel {
  String name = '';
  String email = '';
  String subject = '';
  String message = '';

  bool isDataValid() {

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        EmailValidator.validate(email)&&
        subject.isNotEmpty &&
        message.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
