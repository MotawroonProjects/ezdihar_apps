import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../models/setting_model.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  late ServiceApi api;
  late SettingModel settingModel;
  late UserModel model;
  SettingCubit() : super(SettingInitial()) {
    api = ServiceApi();
    getSetting();
  }

  Future<UserModel> getUserData() async {
    return await Preferences.instance.getUserModel();
  }

  onUserDataSuccess() async {
     model = await Preferences.instance.getUserModel();
    emit(OnUserModelGet(model));
  }

  logout(BuildContext context) async {
    try {
      getUserData().then((value) async {
        AppWidget.createProgressDialog(context, 'wait'.tr());
        await api.logout(value.access_token, value.firebase_token);
        Navigator.pop(context);
        emit(OnLogOutSuccess());
      });
    } catch (e) {
      print("Logout=>${e.toString()}");
      Navigator.pop(context);
      emit(OnError(e.toString()));
    }
  }

   getSetting() async {
     emit(OnLoading());
     emit(OnSettingModelGet(await api.getSetting()));
  }
}
