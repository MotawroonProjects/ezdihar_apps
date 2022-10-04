import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../models/category_data_model.dart';
import '../../../../models/category_model.dart';
import '../../../../models/user_model.dart';
import '../../../../preferences/preferences.dart';
import '../../../../remote/service.dart';
import '../../../../widgets/app_widgets.dart';

part 'control_services_state.dart';

class ControlServicesCubit extends Cubit<ControlServicesState> {
  ControlServicesCubit() : super(ControlServicesInitial()) {
    api = ServiceApi();
    onUserDataSuccess();
  }

  late UserModel model;
  late ServiceApi api;
  late CategoryDataModel categoryDataModel;
  bool newChecked = false;

  onUserDataSuccess() async {
    model = await Preferences.instance.getUserModel().then((value) {
      print("value.subCategory!.id");
      print(value.access_token);
      print(value.subCategory!.id);
      getMySubSubCategories(value.subCategory!.id!);
      return value;
    });
  }

  Future<void> getMySubSubCategories(int id) async {
    emit(ControlServicesLoading());
    categoryDataModel = await api.getSubCategories(id);
    emit(ControlServicesLoaded());
  }

  bool Checked(CategoryModel categoryModel) {
    bool checked = false;
    model.subCategories!.forEach((element) {
      if (element.service!.id == categoryModel.id) {
        checked = true;
      }
    });
    newChecked = checked;
    return checked;
  }

  changeChecked(bool newChecked) {
    this.newChecked = !newChecked;
    emit(ControlServicesLoaded());
  }

  Future<void> addNewServices(context, price, descEn, descAr, subCatId) async {
    AppWidget.createProgressDialog(context, "wait".tr());
    try {
      final response = await api.addNewServices(
          price, descEn, descAr, subCatId, model.access_token,);
      if (response.code == 200) {
        updateUserData(context);
      } else {
        print("noooooooot dooooone");
      }
    } catch (e) {
      print("error");
      print(e);
    }
  }


  Future<void> updateMyServices(context, price, descEn, descAr, subCatId) async {
    AppWidget.createProgressDialog(context, "wait".tr());
    try {
      final response = await api.updateMyServices(
          price, descEn, descAr, subCatId, model.access_token,);
      if (response.code == 200) {
        updateUserData(context);
      } else {
        print("noooooooot dooooone");
      }
    } catch (e) {
      print("error");
      print(e);
    }
  }

  Future<void> deleteMyServices(context, subCatId) async {
    AppWidget.createProgressDialog(context, "wait".tr());
    try {
      final response = await api.deleteMyServices(subCatId, model.access_token,);
      if (response.code == 200) {
        updateUserData(context);
      } else {
        print("noooooooot dooooone");
      }
    } catch (e) {
      print("error");
      print(e);
    }
  }
  updateUserData(context) async {
    await api.getProfileByToken(model.access_token).then(
          (value) =>
          Preferences.instance.setUser(value.userModel).then((value) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }),
    );
  }

}
