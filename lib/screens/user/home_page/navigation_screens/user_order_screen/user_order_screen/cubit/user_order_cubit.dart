import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/models/home_model.dart';
import 'package:ezdihar_apps/models/project_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../../../../../../models/provider_order.dart';

part 'user_order_state.dart';

class UserOrderCubit extends Cubit<UserOrderState> {
  int index = 0;
  String lan = 'ar';
  late ServiceApi api;
  UserModel? userModel;
  MainOrdersModel? mainAcceptOrders;
  MainOrdersModel? mainCompletedOrders;

  UserOrderCubit() : super(UpdateIndex(0)) {
    api = ServiceApi();
    getUserData().whenComplete(() => getUserAcceptOrder().then((value) =>     getUserCompletedOrder()));
    ;

  }

  updateIndex(int index) {
    this.index = index;
    emit(UpdateIndex(index));
    if (index == 0) {
      if (mainAcceptOrders != null) {
        emit(OnCurrentDataSuccess(mainAcceptOrders!));
      }
    } else if (index == 1) {
      if (mainCompletedOrders != null) {
        emit(OnPreviousDataSuccess(mainCompletedOrders!));
      }
    }
  }

  Future<UserModel?> getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }

  Future<void> getUserAcceptOrder() async {
    emit(IsLoadingData());
    var model = await api.getUserAcceptOrder(userModel!.access_token, lan);
    mainAcceptOrders = model;
    emit(OnCurrentDataSuccess(model));
  }

  Future<void> getUserCompletedOrder() async {
    emit(IsLoadingData());

    var model =
        await api.getUserCompletedOrder(userModel!.access_token, lan);
    mainCompletedOrders = model;
    emit(OnPreviousDataSuccess(model));
  }

  void onErrorData(String error) {
    emit(OnError(error));
  }
}
