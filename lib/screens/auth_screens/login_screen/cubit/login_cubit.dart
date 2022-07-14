import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/country_login.dart';
import 'package:ezdihar_apps/models/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  late Country selectedCountry;
  List<Country> countries = [
    Country('+966', 'saudi_arabia'.tr(), 'saudi_arabia.png'),
    Country('+20', 'egypt'.tr(), 'egypt_flag.png'),
  ];
  bool isLoginValid = false;
  Timer? timer;
  FirebaseAuth _mAuth = FirebaseAuth.instance;
  int? resendToken;
  String? verificationId;
  LoginModel loginModel = LoginModel();
  int seconds = 60;
  String time = '';
  String smsCode = '';
  String mySmsCode = '';

  LoginCubit()
      : super(LoginInitial([
          Country('+966', 'saudi_arabia'.tr(), 'saudi_arabia.png'),
          Country('+20', 'egypt'.tr(), 'egypt_flag.png'),
        ])) {
    time = '00:${seconds}';
    selectedCountry = countries[0];
    loginModel.phone_code = selectedCountry.phone_code;
  }

  updateCountryValue(Country country) {
    selectedCountry = country;
    loginModel.phone_code = country.phone_code;
    emit(OnCountryValueChanged(country));
  }

  _checkValidLoginData() {
    if (loginModel.isDataValid()) {
      isLoginValid = true;
      emit(OnLoginVaild());
    } else {
      isLoginValid = false;

      emit(OnLoginVaildFaild());
    }
  }

  updatePhoneNumber(String phone) {
    if (phone.startsWith('0')) {
      phone = phone.replaceFirst('0', '');
    }
    loginModel.phone = phone;
    _checkValidLoginData();
  }
  updateCanVerifySmsCode(String smsCode){
    mySmsCode = smsCode;
    emit(OnCanVerifySmsCode());
  }

  sendSmsCode() {
    startTimer();
    String phoneNumber = loginModel.phone_code + loginModel.phone;
    _mAuth.verifyPhoneNumber(
        forceResendingToken: this.resendToken,
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 1),
        verificationCompleted: (PhoneAuthCredential credential) {
          smsCode = credential.smsCode!;



          emit(OnSmsCodeSent(smsCode));
          verifySmsCode(smsCode);

        },
        verificationFailed: (FirebaseAuthException e) {
        },
        codeSent: (String verificationId, int? resendToken) {
          this.resendToken = resendToken;
          this.verificationId = verificationId;
          print("verificationId=>${verificationId}");

        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  verifySmsCode(String smsCode) async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: smsCode);
    await _mAuth.signInWithCredential(credential).then((value){
      print('LoginSuccess');
      stopTimer();
    }).catchError((error){
      print('phone auth =>${error.toString()}');

    });
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        time = '${seconds}'.padLeft(2, '0');
        emit(OnTimerChanged('00:${time}'));
      } else {
        time = '';
        seconds = 60;
        emit(OnTimerChanged(''));
        timer.cancel();
      }
    });
  }

  stopTimer() {
    timer!.cancel();
  }
}
