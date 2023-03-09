import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/screens/wallet_screen/cubit/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/provider_order.dart';
import '../../../../../models/status_resspons.dart';
import '../../../../../models/user_model.dart';
import '../../../../../preferences/preferences.dart';
import '../../../../../remote/service.dart';
import '../../../../../widgets/app_widgets.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial()) {
    api = ServiceApi();
    onUserDataSuccess();
  }

  late ServiceApi api;
  UserModel? user;
  int page = 0;
  MainOrdersModel? mainAcceptOrders;
  MainOrdersModel? mainCompletedOrders;
  String lan = 'ar';

  getLan(context) {
    lan = EasyLocalization.of(context)!.locale.languageCode;
  }


  Future<void> getProviderAcceptOrder() async {
    emit(OrdersLoading());
    var model = await api.getProviderAcceptOrder(user!.access_token, lan);
    mainAcceptOrders = model;
    emit(OrdersLoaded(model));
  }

  Future<void> getProviderCompletedOrder() async {
    emit(OrdersLoading());
    var model = await api.getProviderCompletedOrder(user!.access_token, lan);
    mainCompletedOrders = model;
    emit(OrdersLoaded(model));
  }

  Future<void> changeProviderOrderStatus(BuildContext context,String id,String status) async {
    AppWidget.createProgressDialog(context, "wait".tr());

    final response = await api.changeProviderOrderStatus(user!.access_token,id,status);
    if (response.code == 200||response.code == 201) {
      updateUserData(context);
    } else {
      print("noooooooot dooooone");
    }
  }

  Future<void> rate(context, descEn, rate, subCatId) async {
    AppWidget.createProgressDialog(context, "wait".tr());
    try {
      final response = await api.rateProvider(
          rate, descEn, subCatId, user!.access_token);
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
  updateUserData(BuildContext context) async {
            Navigator.pop(context);
            Navigator.pop(context);




  }

  onUserDataSuccess() async {
    user = await Preferences.instance
        .getUserModel()
        .then((value) => user = value)
        .whenComplete(() {
      getProviderAcceptOrder().then(
          (value) => getProviderCompletedOrder(),
      );
    });
  }

  changePage(int index) {
    page = index;
    print("paaaaaaaggggggggeeee");
    print(page);
    emit(OrdersTabChanged(index));
  }
}
