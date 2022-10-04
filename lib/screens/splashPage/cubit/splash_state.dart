part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class OnUserModelGet extends SplashState{
  UserModel userModel;
  OnUserModelGet(this.userModel);
}
class NoUserFound extends SplashState{}