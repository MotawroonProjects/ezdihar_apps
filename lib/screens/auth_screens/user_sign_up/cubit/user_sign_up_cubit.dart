import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/user_sign_up_model.dart';
import 'package:ezdihar_apps/screens/auth_screens/user_sign_up/cubit/user_sign_up_state.dart';
import 'package:image_picker/image_picker.dart';

class UserSignUpCubit extends Cubit<UserSignUpState> {
  XFile? imageFile;
  DateTime initialDate = DateTime(DateTime.now().year-10);
  DateTime startData = DateTime(DateTime.now().year-100);
  DateTime endData = DateTime(DateTime.now().year-10);
  String birthDate = 'DD/MM/YYYY';
  String imageType ='';
  UserSignUpModel model = UserSignUpModel();

  bool isDataValid = false;

  UserSignUpCubit() : super(UserSignUpInitial());

  pickImage({required String type}) async {
    imageFile = await ImagePicker().pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);
    imageType = 'file';
    emit(UserPhotoPicked(imageFile!));
  }

  updateBirthDate({required String date}){
    this.birthDate = date;
    model.dateOfBirth = date;
    emit(UserBirthDateSelected(date));
    checkData();

  }

  checkData(){
    if(model.isDataValid()){
      isDataValid = true;
    }else{
      isDataValid = false;
    }

    emit(UserDataValidation(isDataValid));
  }
}
