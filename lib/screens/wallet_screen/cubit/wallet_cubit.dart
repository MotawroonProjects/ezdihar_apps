import 'package:bloc/bloc.dart';
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
  }

  onRechargeWallet(int amount) async {
    emit(WalletLoading());
    emit(
      GetWalletModel(
        await api.walletRecharge(amount, model.access_token),
      ),
    );
  }
  onchargeWallet(int amount) async {
    emit(WalletLoading());
    emit(
      GetWalletModel(
        await api.walletcharge(amount, model.access_token),
      ),
    );
  }
  onGetProfileData() async {
    onRechargeDone(await api.getProfileByToken(model.access_token));
  }
}
