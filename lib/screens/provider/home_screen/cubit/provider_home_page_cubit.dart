import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

import '../../../../models/provider_home_page_model.dart';
import '../../../../models/user_model.dart';
import '../../../../preferences/preferences.dart';
import '../../../../remote/service.dart';

part 'provider_home_page_state.dart';

class ProviderHomePageCubit extends Cubit<ProviderHomePageState> {
  ProviderHomePageCubit() : super(ProviderHomePageInitial()){
    api = ServiceApi();
    updateFirebaseToken();
    onUserDataSuccess();
  }
  late ServiceApi api;
   UserModel? user;
  onUserDataSuccess() async {
    user = await Preferences.instance.getUserModel();
    emit(UserDataDone());
  }

  getHomePageData() async {
    emit(ProviderHomePageLoading());
    var model =await api.getProviderHomePageData(user!.access_token);
    emit(ProviderHomePageLoaded(model));
  }
  Future<UserModel> getUserData() async{
    return await Preferences.instance.getUserModel();
  }

  updateFirebaseToken() async{
    getUserData().then((value)async{
      if(value.user.isLoggedIn){
        String? token = await FirebaseMessaging.instance.getToken();
        print('token'+token!);
        if(token!=null){
          value.firebase_token = token;
          Preferences.instance.setUser(value);

          String type ='android';
          if(Platform.isAndroid){
            type = 'android';
          }else if(Platform.isIOS){
            type = 'ios';
          }
          await api.updateFireBaseToken(value.access_token, token, type);

        }
      }
    });
  }
}
