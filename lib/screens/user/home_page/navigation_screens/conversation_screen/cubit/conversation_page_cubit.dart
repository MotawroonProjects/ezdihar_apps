import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/chat_data_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

import '../../../../../../models/chat_model.dart';

part 'conversation_page_state.dart';

class ConversationPageCubit extends Cubit<ConversationPageState> {

  late ServiceApi api;
  late List<ChatModel> chatmodelList;
  ConversationPageCubit() : super(IsLoadingData()){
    chatmodelList = [];
    api = ServiceApi();
    //getData();
  }


  Future<UserModel> getUserData() async{
    return await Preferences.instance.getUserModel();
  }
  void getData() async {
    try {
      chatmodelList.clear();
      emit(IsLoadingData());
      UserModel model = await Preferences.instance.getUserModel();
      String user_token = '';
user_token=model.access_token;
      ChatDataModel home = await api.getChatRoom(
          user_token);
      print(home.status);
      if (home.status.code == 200) {

        chatmodelList = home.data;
        emit(OnDataSuccess(chatmodelList));
      } else {}
    } catch (e) {
      print(e.toString());
      emit(OnError(e.toString()));
    }
  }

}
