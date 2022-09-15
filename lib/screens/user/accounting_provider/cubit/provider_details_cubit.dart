import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/payment_data.dart';
import 'package:ezdihar_apps/models/user_data_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../models/payment_model.dart';
import '../../../../preferences/preferences.dart';
import '../../../../widgets/app_widgets.dart';

part 'provider_details_state.dart';

class ProviderDetailsCubit extends Cubit<ProviderDetailsState> {
  late ServiceApi api;
  UserModel? userModel;

  ProviderDetailsCubit() : super(IsLoading()) {
    api = ServiceApi();
  }

  void getData(int consultant_id,int cate_id) async {
    emit(IsLoading());
    try {
      UserDataModel userDataModel =
          await api.getproviderDetails(consultant_id,cate_id);
      if(userDataModel.status.code==200){
        userModel = userDataModel.userModel;

      }
      emit(OnDataSuccess(userModel!));
    } catch (e) {
      print("Erroror${e.toString()}");
      emit(OnError(e.toString()));
    }
  }
  void sendOrder(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    UserModel model = await Preferences.instance.getUserModel();
    String user_token = '';
    if (model.user.isLoggedIn) {
      user_token = model.access_token;
    }
    try {
      PaymentDataModel response = await api.sendOrder(userModel!,user_token);
      Navigator.pop(context);

      if (response.status.code == 200) {

          emit(OnOrderSuccess(response.paymentData));


      } else {
        print("errorCode=>${response.status.code}");
      }
    } catch (e) {
      print("error${e.toString()}");
      Navigator.pop(context);
      emit(OnError(e.toString()));
    }
  }

}
