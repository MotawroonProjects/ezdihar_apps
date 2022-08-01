part of 'setting_cubit.dart';

@immutable
abstract class SettingState {}

class SettingInitial extends SettingState {

}
class OnUserModelGet extends SettingState {
  UserModel userModel;
  OnUserModelGet(this.userModel);
}

class OnLogOutSuccess extends SettingState {

}
class OnError extends SettingState {
  String error;
  OnError(this.error);
}