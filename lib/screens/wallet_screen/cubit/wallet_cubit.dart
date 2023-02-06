import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../../models/recharge_wallet_model.dart';
import '../../../models/user_data_model.dart';
import '../../../models/user_model.dart';
import '../../../preferences/preferences.dart';
import '../../../remote/service.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  late ServiceApi api;
  late UserModel model;

  WalletCubit() : super(WalletInitial()) {
    api = ServiceApi();
    onUserDataSuccess();
  }

  onUserDataSuccess() async {
    model = await Preferences.instance.getUserModel();
    emit(GetUserModel(model));
  }

  onRechargeDone(UserDataModel userDataModel) async {
    await Preferences.instance.setUser(userDataModel.userModel);
    onUserDataSuccess();
  }

  onRechargeWallet(int amount) async {
    emit(WalletLoading());
    emit(
      GetWalletModel(
        await api.walletRecharge(amount, model.access_token),
      ),
    );
  }
  onrequestfromWallet(int amount,BuildContext context) async {
    emit(WalletLoading());

    var response=    await api.requestfromwallet(amount, model.access_token);
   if(response.code==200){
     Fluttertoast.showToast(
         msg: response.message, // message
         toastLength: Toast.LENGTH_SHORT, // length
         gravity: ToastGravity.BOTTOM, // location
         timeInSecForIosWeb: 1 // duration
     );
     Navigator.of(context).pop();
     Navigator.of(context).pop();

   }
   else {
     Fluttertoast.showToast(
         msg: response.message, // message
         toastLength: Toast.LENGTH_SHORT, // length
         gravity: ToastGravity.BOTTOM, // location
         timeInSecForIosWeb: 1 // duration
     );
   }
  }
  onGetProfileData() async {
    print('000000000000');
    print('000000000000');
    onRechargeDone(await api.getProfileByToken(model.access_token));
  }
}
