import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  int index = 0;
  late ServiceApi api;
  HomePageCubit() : super(MainPageInitial(0)){
    api = ServiceApi();
   updateFirebaseToken();
  }

  void updateIndex(int index){
    this.index = index;
    emit(MainPageIndexUpdated(index));
  }
  Future<UserModel> getUserData() async{
    return await Preferences.instance.getUserModel();
  }
  updateFirebaseToken() async{
    getUserData().then((value)async{
      if(value.user.isLoggedIn){
        String? token = await FirebaseMessaging.instance.getToken();
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
