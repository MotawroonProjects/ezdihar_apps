part of 'more_cubit.dart';

@immutable
abstract class MoreState {}

class MoreInitial extends MoreState {

}

class OnUserModelGet extends MoreState {
  UserModel userModel;
  OnUserModelGet(this.userModel);
}
