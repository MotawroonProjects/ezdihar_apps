import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/category_data_model.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/city_data_model.dart';
import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/models/provider_order.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

import '../../../models/Message_data_model.dart';
import '../../../models/user_model.dart';
import '../../../preferences/preferences.dart';

part 'orders_state.dart';

class NewOrdersCubit extends Cubit<OrdersState> {
  late ServiceApi api;
  late List<ProviderOrder> list;

  NewOrdersCubit() : super(IsLoading()) {
    api = ServiceApi();
    list = [];
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
      print("lklkkk${response.status.code}");
      // print(response.data.messages.length);
      if (response.status.code == 200) {
        list = response.data.services;
        emit(OnDataSuccess(list));
      }
    } catch (e) {
      print("dddd${e.toString()}");
      OnError(e.toString());
    }
  }
}
