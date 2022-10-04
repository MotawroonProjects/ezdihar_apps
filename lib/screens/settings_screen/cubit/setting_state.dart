part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {}
class OnUserModelGet extends SettingState {
  UserModel userModel;
  OnUserModelGet(this.userModel);
}
class OnSettingModelGet extends SettingState {
  SettingModel settingModel;
  OnSettingModelGet(this.settingModel);
}

class OnLogOutSuccess extends SettingState {}
class OnLoading extends SettingState {}
class OnError extends SettingState {
  String error;
  OnError(this.error);
}