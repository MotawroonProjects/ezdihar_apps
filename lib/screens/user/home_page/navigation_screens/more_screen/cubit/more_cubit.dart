import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:meta/meta.dart';

import '../../../../../../models/setting_model.dart';
import '../../../../../../remote/service.dart';

part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  late ServiceApi api;

  late UserModel userModel;

  SettingModel? setting;
  MoreCubit() : super(MoreInitial()){
    api = ServiceApi();

    getUserModel();
  }

  void getUserModel() async{
    userModel = await Preferences.instance.getUserModel();

    emit(OnUserModelGet(userModel));
  }

  void onUserDataUpdated(UserModel userModel){
    emit(OnUserModelGet(userModel));

  }
  getSetting() async {
    setting=await api.getSetting();
    emit(OnSettingModelGet(setting!));

  }

}
