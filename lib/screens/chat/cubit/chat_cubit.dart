import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/Message_data_model.dart';
import 'package:ezdihar_apps/models/chat_model.dart';

import 'package:ezdihar_apps/models/message_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../models/single_Message_data_model.dart';
import '../../../models/user_model.dart';
import '../../../preferences/preferences.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  late ServiceApi api;
  late List<MessageModel> list;
  late String imagePath;
  XFile? imageFile;
  String imageType = '';

  bool first = false;

  ChatCubit() : super(IsLoading()) {
    api = ServiceApi();
    imagePath = "";
    // list = [];

    //  getChat();
  }

  void setfirst() {
    first = true;
    print("dkdkdkkdk${first}");

    emit(First(first));
  }

  void getChat(String room_id) async {
    try {
      UserModel model = await Preferences.instance.getUserModel();
      String user_token = '';
      if (model.user.isLoggedIn) {
        user_token = model.access_token;
      }
      emit(IsLoading());
      MessageDataModel response = await api.getAllMessage(user_token, room_id);
      // print(response.status.code);
      // print(response.data.messages.length);
      if (response.status.code == 200) {
        list = response.data.messages;
        emit(OnDataSuccess(list));
      }
    } catch (e) {
      OnError(e.toString());
    }
  }

  pickImage(
      {required String type,
      required ChatModel chatModel,
      required BuildContext context}) async {
    imageFile = await ImagePicker().pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);
    imageType = 'file';

    imagePath = imageFile!.path;
    sendimage(context, imagePath, chatModel);
    //emit(UserPhotoPicked(imagePath));
  }

  sendimage(BuildContext context, String imagepath, ChatModel chatModel) async {
    try {
      //emit(OnDataSuccess(list));
      UserModel model = await Preferences.instance.getUserModel();
      String user_token = '';
      if (model.user.isLoggedIn) {
        user_token = model.access_token;
      }
      //   print(chatModel.provider.id);
      String id = "";
      if (model.user.id == chatModel.user.id) {
        id = chatModel.provider.id.toString();
      } else {
        id = chatModel.user.id.toString();
      }
      SingleMessageDataModel response = await api.sendMessage(
          imagepath, "", "file", chatModel.id.toString(), id, user_token);
      print("sssss${response.status!.code}");
      if (response.status?.code == 200) {
        list.add(response.data!);
        //   list.add(new MessageModel());
        //  print(list.length);
        emit(OnDataSuccess(list));
      } else {
        //  Navigator.pop(context);
        print(response.status!.message);
        emit(OnError(response.status!.message));
      }
    } catch (e) {
      print('Errorsssss=>${e}');
      //Navigator.pop(context);
      emit(OnError(e.toString()));
    }
  }

  sendmessage(BuildContext context, String message, ChatModel chatModel) async {
    try {
      UserModel model = await Preferences.instance.getUserModel();
      String user_token = '';
      if (model.user.isLoggedIn) {
        user_token = model.access_token;
      }
      //   print(chatModel.provider.id);
      String id = "";
      if (model.user.id == chatModel.user.id) {
        id = chatModel.provider.id.toString();
      } else {
        id = chatModel.user.id.toString();
      }
      SingleMessageDataModel response = await api.sendMessage(
          "",
          message,
          "text",
          chatModel.id.toString(),
          id,
          user_token);
      print(response.status!.message);
      if (response.status?.code == 200) {
        //  print('Error=>${list.length}');
        //   list.removeAt(list.length - 1);
        list.add(response.data!);
        // list.add(new MessageModel());
        print(list.length);
        emit(OnDataSuccess(list));
      } else {
        //  Navigator.pop(context);
        print(response.status!.message);
        emit(OnError(response.status!.message));
      }
    } catch (e) {
      print('Error=>${e}');
      //Navigator.pop(context);
      emit(OnError(e.toString()));
    }
  }
}
