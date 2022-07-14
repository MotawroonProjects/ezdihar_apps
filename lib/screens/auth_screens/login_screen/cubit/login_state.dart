part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {
  List<Country> countries ;

  LoginInitial(this.countries);
}

class OnCountrySuccess extends LoginState{

}
class OnCountryValueChanged extends LoginState{
  Country country;

  OnCountryValueChanged(this.country);
}

class OnLoginVaild extends LoginState{
}

class OnLoginVaildFaild extends LoginState{
}
class OnTimerChanged extends LoginState{
  String time='00:00';

  OnTimerChanged(this.time);
}

class OnSmsCodeSent extends LoginState{
  String smsCode;
  OnSmsCodeSent(this.smsCode);
}
class OnCanVerifySmsCode extends LoginState{

}

