import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/models/user_sign_up_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../models/user_data_model.dart';
import '../../../../preferences/preferences.dart';
import '../../../../widgets/app_widgets.dart';

part 'investor_state.dart';

class InvestorCubit extends Cubit<InvestorState> {
  XFile? imageFile;
  late ServiceApi api;
  DateTime initialDate = DateTime(DateTime.now().year - 10);
  DateTime startData = DateTime(DateTime.now().year - 100);
  DateTime endData = DateTime(DateTime.now().year - 10);
  String birthDate = 'DD/MM/YYYY';
  late CityModel selectedCityModel;
  late CategoryModel categoryModel;
  String imageType ='';
  String fileName = '';


  UserSignUpModel model = UserSignUpModel();
  bool isDataValid = false;

  InvestorCubit() : super(InvestorInitial()){
    selectedCityModel = CityModel.initValues();
    categoryModel=CategoryModel.initValues();
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
    imageType='file';
    emit(InvestorPhotoPicked(imageFile!));
  }

  updateBirthDate({required String date}) {
    this.birthDate = date;
    model.dateOfBirth = date;
    emit(InvestorBirthDateSelected(date));
    checkData();
  }
  pickUpFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      String name = result.files.first.name;
      if (name.toLowerCase().endsWith('.pdf')) {
        fileName = name;
        model.cv_path = result.files.first.path!;
        print("fileName=>${name}");
      } else {
        fileName = '';
      }
      emit(InvestorFilePicked(fileName));
      checkData();
    }
  }

  checkData() {
    if (model.isDataValid()) {
      isDataValid = true;
    } else {
      isDataValid = false;
    }
    print('Valid=>${isDataValid}');
    emit(InvestorDataValidation(isDataValid));
  }
  updateSelectedCity(CityModel cityModel) {
    this.selectedCityModel = cityModel;
    model.cityId = selectedCityModel.id;
    checkData();
    emit(OnCitySelected(cityModel));
  }
  updateSelectedCategory(CategoryModel categoryModel) {
    this.categoryModel = categoryModel;
    model.categoryModel = categoryModel.id.toString();
    checkData();
    emit(OnCategorySelected(categoryModel));
  }
  signUp(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    try {
      model.user_type='freelancer';

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

}
