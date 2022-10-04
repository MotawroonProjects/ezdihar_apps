part of 'wallet_cubit.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}
class WalletLoading extends WalletState {}

class WalletRecharged extends WalletState {
  final UserDataModel userDataModel;
  WalletRecharged(this.userDataModel);
}

class GetUserModel extends WalletState {
  final UserModel model;

  GetUserModel(this.model);
}
class GetWalletModel extends WalletState {
  final RechargeWalletModel model;

  GetWalletModel(this.model);
}
