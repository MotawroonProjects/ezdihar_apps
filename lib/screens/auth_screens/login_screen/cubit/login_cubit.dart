import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/models/country_login.dart';
import 'package:ezdihar_apps/models/login_model.dart';
import 'package:ezdihar_apps/models/user_data_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  late ServiceApi api;
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

  String role = '';

  LoginCubit()
      : super(LoginInitial([
          Country('+966', 'saudi_arabia'.tr(), 'saudi_arabia.png'),
          Country('+20', 'egypt'.tr(), 'egypt_flag.png'),
        ])) {
    time = '00:${seconds}';
    selectedCountry = countries[0];
    loginModel.phone_code = selectedCountry.phone_code;
    api = ServiceApi();
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

  updateCanVerifySmsCode(String smsCode) {
    mySmsCode = smsCode;
    emit(OnCanVerifySmsCode());
  }

  sendSmsCode(BuildContext context) async {
    startTimer();
    _mAuth.setSettings(forceRecaptchaFlow: true);
    String phoneNumber = loginModel.phone_code + loginModel.phone;

    _mAuth.verifyPhoneNumber(
        forceResendingToken: this.resendToken,
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 1),
        verificationCompleted: (PhoneAuthCredential credential) {
          smsCode = credential.smsCode!;
          this.verificationId = credential.verificationId;
          print("verificationId=>${verificationId}");
          emit(OnSmsCodeSent(smsCode));
          verifySmsCode(smsCode, context);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(",kkkk${e}");

        },
        codeSent: (String verificationId, int? resendToken) {
          this.resendToken = resendToken;
          this.verificationId = verificationId;
          emit(OnSmsCodeSent(''));
          print("verificationId=>${verificationId}");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId=verificationId;
          emit(OnSmsCodeSent(''));
        },



    )

    ;

  }

  verifySmsCode(String smsCode, BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    print(smsCode);
    print(verificationId);
    if(verificationId!=null){
try{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!, smsCode: smsCode);
    await _mAuth.signInWithCredential(credential).then((value) {
      // login(context);
      print('LoginSuccess');
      Navigator.pop(context);
    //  Navigator.pop(context);
      stopTimer();
      login(context, role);
    }).catchError((error) {
      print('phone auth =>${error.toString()}');
    });}
    on Exception {
      Navigator.pop(context);
      // Navigator.pop(context);
      stopTimer();
      login(context, role);
    }}
    else{
      Navigator.pop(context);
   //   Navigator.pop(context);
      stopTimer();
      login(context, role);
    }
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

  void login(BuildContext context, String role) async {

    AppWidget.createProgressDialog(context, 'wait'.tr());

    if (role == "user") {
      role = "client";
    } else {
      role = "freelancer";
    }

    try {
      UserDataModel response = await api.login(loginModel, role);
     // Navigator.pop(context);
      Navigator.pop(context);
      print("resss${response.status.code}");
      if (response.status.code == 200) {
        print("oooooooooooooooooo");
        response.userModel.user.isLoggedIn = true;
        Preferences.instance.setUser(response.userModel).then((value) {
          emit(OnLoginSuccess(response.userModel));
        });
      } else if (response.status.code == 406) {
        emit(OnSignUp(loginModel));
      } else {
        print("errorCode=>${response.status.code}");
      }
    } catch (e) {
      print("errorsssss${e.toString()}");
      Navigator.pop(context);
      emit(OnError(e.toString()));
    }
  }
}
