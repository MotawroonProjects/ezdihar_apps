import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/city_data_model.dart';
import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/models/user_data_model.dart';
import 'package:ezdihar_apps/models/user_sign_up_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:ezdihar_apps/screens/auth_screens/user_sign_up/cubit/user_sign_up_state.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/main_screen/cubit/main_page_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserSignUpCubit extends Cubit<UserSignUpState> {
  XFile? imageFile;
  DateTime initialDate = DateTime(DateTime.now().year - 10);
  DateTime startData = DateTime(DateTime.now().year - 100);
  DateTime endData = DateTime(DateTime.now().year - 10);
  String birthDate = 'YYYY-MM-DD';
  String imageType = '';
  UserSignUpModel model = UserSignUpModel();
  bool isDataValid = false;
  late CityModel selectedCityModel;
  late ServiceApi api;

  UserSignUpCubit() : super(UserSignUpInitial()) {
    selectedCityModel = CityModel.initValues();
    model.cityId = selectedCityModel.id;
    api = ServiceApi();
  }

  updatePhoneCode_Phone(String phone_code, String phone) {
    model.phone_code = phone_code;
    model.phone = phone;
  }

  pickImage({required String type}) async {
    imageFile = await ImagePicker().pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);
    imageType = 'file';
    model.imagePath = imageFile!.path;
    emit(UserPhotoPicked(imageFile!));
  }

  updateBirthDate({required String date}) {
    this.birthDate = date;
    model.dateOfBirth = date;
    emit(UserBirthDateSelected(date));
    checkData();
  }

  checkData() {
    if (model.isDataValid()) {
      isDataValid = true;
    } else {
      isDataValid = false;
    }

    emit(UserDataValidation(isDataValid));
  }

  updateSelectedCity(CityModel cityModel) {
    this.selectedCityModel = cityModel;
    model.cityId = selectedCityModel.id;
    checkData();
    emit(OnCitySelected(cityModel));
  }

  signUp(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    try {
      UserDataModel response = await api.signUp(model);
      response.userModel.user.isLoggedIn = true;
      print('response=>${response.userModel.toString()}');
      if (response.status.code == 200) {
        Preferences.instance.setUser(response.userModel).then((value) {
          Navigator.pop(context);
          emit(OnSignUpSuccess());
        });
      }
    } catch (e) {
      Navigator.pop(context);
      OnError(e.toString());
    }
  }
}
