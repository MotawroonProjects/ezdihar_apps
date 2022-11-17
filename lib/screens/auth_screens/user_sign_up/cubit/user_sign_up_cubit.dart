import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/city_data_model.dart';
import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/models/user_data_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/models/user_sign_up_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:ezdihar_apps/screens/auth_screens/user_sign_up/cubit/user_sign_up_state.dart';
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
  late String imagePath;
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();

  UserSignUpCubit() : super(UserSignUpInitial()) {
    selectedCityModel = CityModel.initValues();
    model.cityId = selectedCityModel.id;
    api = ServiceApi();
    imagePath = "";
    updateUserDataUi();
  }

  updatePhoneCode_Phone(String phone_code, String phone) {
    print(phone_code);
    print(":ldldkdk${phone}");
    model.phone_code = phone_code;
    model.phone = phone;
  }

  pickImage({required String type}) async {
    imageFile = await ImagePicker().pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);
    imageType = 'file';

    model.imagePath = imageFile!.path;
    imagePath = model.imagePath;
    emit(UserPhotoPicked(model.imagePath));
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
      model.user_type='client';
      UserDataModel response = await api.signUp(model);
      response.userModel.user.isLoggedIn = true;
      if (response.status.code == 200) {
        Preferences.instance.setUser(response.userModel).then((value) {
          Navigator.pop(context);
          emit(OnSignUpSuccess());
        });
      }
      else{
        Navigator.pop(context);
        emit(OnError(response.status.message));
      }
    } catch (e) {
      Navigator.pop(context);
      emit(OnError(e.toString()));
    }
  }

  updateProfile(BuildContext context, String user_token) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    try {
      UserDataModel response = await api.updateProfile(model, user_token);
      response.userModel.user.isLoggedIn = true;
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

  void updateUserDataUi() {
    Preferences.instance.getUserModel().then((value) {
      if (value.user.isLoggedIn) {
        model.firstName = value.user.firstName;
        model.lastName = value.user.lastName;
        model.email = value.user.email;
        model.cityId = value.user.city.id;
        model.imagePath = value.user.image;
        updateSelectedCity(value.user.city);
        updateBirthDate(date: value.user.birthdate);
        controllerFirstName.text = model.firstName;
        controllerLastName.text = model.lastName;
        controllerEmail.text = model.email;

        emit(OnUserDataGet());
        emit(UserPhotoPicked(model.imagePath));
      }
    });
  }


}
