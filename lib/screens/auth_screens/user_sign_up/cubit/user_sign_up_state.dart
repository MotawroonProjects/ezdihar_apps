import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@immutable
abstract class UserSignUpState {}

class UserSignUpInitial extends UserSignUpState {}
class UserPhotoPicked extends UserSignUpState {
  XFile file;
  UserPhotoPicked(this.file);
}
class UserBirthDateSelected extends UserSignUpState {
  String date;
  UserBirthDateSelected(this.date);
}

class UserDataValidation extends UserSignUpState {
  bool valid;
  UserDataValidation(this.valid);

}
