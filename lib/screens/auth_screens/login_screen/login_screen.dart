
import 'package:easy_localization/easy_localization.dart'as lan;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../colors/colors.dart';
import '../../../constants/app_constant.dart';
import '../../../models/country_login.dart';
import '../../../widgets/app_widgets.dart';
import 'cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.role}) : super(key: key);
  String role;

  @override
  State<LoginPage> createState() => _LoginPageState(role);
}

class _LoginPageState extends State<LoginPage> {
  String role;

  LoginCubit cubit=LoginCubit();

  _LoginPageState(this.role);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'login'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey2,
      body: buildBodySection(),
    );
  }

  buildBodySection() {
     cubit = BlocProvider.of<LoginCubit>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double spaceHeight = 0.0;

    return BlocListener<LoginCubit, LoginState>(listener: (context, state) {
      print("Status=>${state}");
      if (state is OnSignUp) {
        navigateToSignUp(role: role, cubit: cubit);
      } else if (state is OnLoginSuccess) {
        print("sssss");
        if (role == AppConstant.role_investor) {
          Navigator.of(context)
              .pushReplacementNamed(AppConstant.providerNavigationBottomRoute);
        } else {
          Navigator.of(context).pushReplacementNamed(AppConstant.pageHomeRoute);
        }
      }
    }, child: LayoutBuilder(
      builder: (context, constraints) {
        spaceHeight = height - constraints.maxHeight - 36;
        return ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 56.0,
                ),
                _buildLogoSection(),
                _buildLoginSection(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      bool isValid = cubit.isLoginValid;
                      if (state is OnLoginVaildFaild) {
                        isValid = false;
                      } else if (state is OnLoginVaild) {
                        isValid = true;
                      } else if (state is OnError) {}
                      return MaterialButton(
                        onPressed: isValid
                            ? () {
                               cubit.login(context,role);

                                //cubit.sendSmsCode(context);
                                //showConfirmCodeDialog();

                                //Navigator.pushNamed(context, AppConstant.pageUserSignUpRoleRoute);
                              }
                            : null,
                        height: 56.0,
                        disabledColor: AppColors.grey4,
                        minWidth: width,
                        child: Text(
                          'login'.tr(),
                          style:
                              TextStyle(color: AppColors.white, fontSize: 16.0),
                        ),
                        color:
                            isValid ? AppColors.colorPrimary : AppColors.grey4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: spaceHeight,
            ),
            AspectRatio(
              aspectRatio: 1 / .46,
              child:
                  Image.asset('${AppConstant.localImagePath}login_bottom.png'),
            ),
          ],
        );
      },
    ));
  }

  _buildLogoSection() {
    return Container(
      width: 220.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            '${AppConstant.localImagePath}logo.png',
            width: 170.0,
            height: 60,
          ),
          SizedBox(
            height: 64.0,
          ),
          Text(
            'welcome_back'.tr(),
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: AppColors.black),
          ),
        ],
      ),
    );
  }

  _buildLoginSection() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 24.0, bottom: 36.0),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: AppColors.color3, width: 1.0)),
        child: Column(
          children: [
            _buildDropDownButton(),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 1.0,
              color: AppColors.grey4,
            ),
            SizedBox(
              height: 8,
            ),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  _buildDropDownButton() {

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        cubit.role=role;
        Country country = cubit.selectedCountry;
        if (state is OnCountryValueChanged) {
          country = state.country;
        }

        return DropdownButton<Country>(
            value: country,
            isExpanded: true,
            underline: SizedBox(),
            iconSize: 0,
            items: cubit.countries.map((e) {
              return DropdownMenuItem<Country>(
                  value: e,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        '${AppConstant.localImagePath + e.image}',
                        width: 36.0,
                        height: 24,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        e.name,
                        style:
                            TextStyle(fontSize: 14.0, color: AppColors.black),
                      )
                    ],
                  ));
            }).toList(),
            onChanged: (country) {
              cubit.updateCountryValue(country!);
            });
      },
    );
  }

  _buildForm() {
     cubit = BlocProvider.of<LoginCubit>(context);
    return Form(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            String phone_code = cubit.selectedCountry.phone_code;
            if (state is OnCountryValueChanged) {
              phone_code = state.country.phone_code;
            }
            return Text(
              phone_code,
              style: TextStyle(fontSize: 16.0, color: AppColors.black),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 1.0,
            height: 20,
            color: AppColors.black,
          ),
        ),
        Expanded(
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return TextFormField(
                maxLines: 1,
                cursorColor: AppColors.colorPrimary,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: TextStyle(color: AppColors.black, fontSize: 16.0),
                keyboardType: TextInputType.number,
                onChanged: (data) {
                  cubit.updatePhoneNumber(data);
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'phone'.tr(),
                    hintStyle: TextStyle(color: AppColors.grey4, fontSize: 16)),
              );
            },
          ),
        )
      ],
    ));
  }

  showConfirmCodeDialog() {
    String lang = lan.EasyLocalization.of(context)!.locale.languageCode;

    TextEditingController controller = TextEditingController();
//    cubit.sendSmsCode(context);
    double height = MediaQuery.of(context).size.height * .5;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: BlocProvider.value(
              value: cubit,
              child: Container(
                padding: const EdgeInsets.only(top: 16.0),
                height: height * .95,
                color: AppColors.white,
                child: Column(
                  children: [
                    Text(
                      'we_sent_code'.tr(),
                      style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      lang.contains("en")?
                      '${cubit.loginModel.phone_code + " " + cubit.loginModel.phone}':
                      '${cubit.loginModel.phone + " " + cubit.loginModel.phone_code}',

                      textAlign: TextAlign.left,
                      style: TextStyle(color: AppColors.black, fontSize: 14.0),
                    ),
                    SizedBox(
                        width: 162.0,
                        height: 140.0,
                        child: AspectRatio(
                          aspectRatio: 1 / .86,
                          child: Image.asset(
                              '${AppConstant.localImagePath}verification_image.png'),
                        )),
                    const SizedBox(
                      height: 12.0,
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        String smsCode = cubit.smsCode;
                        if (state is OnSmsCodeSent) {
                          smsCode = state.smsCode;
                          controller.text = smsCode;
                        }
                        return
                         Directionality(


                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                          controller: controller,
                          appContext: context,
                          length: 6,

                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],


                          pinTheme: PinTheme(
                              activeColor: AppColors.colorPrimary,
                              inactiveColor: AppColors.grey4,
                              fieldWidth: 28,
                              fieldHeight: 28,

                              selectedColor: AppColors.colorPrimary),
                          onCompleted: (data) {
                            cubit.updateCanVerifySmsCode(data);
                          },
                          onChanged: (data) {
                            if (data.length < 6) {
                              cubit.updateCanVerifySmsCode('');
                            }
                          },
                          )   );
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        String time = cubit.time;
                        String mySmsCode = cubit.mySmsCode;
                        if (state is OnTimerChanged) {
                          time = state.time;
                        } else if (state is OnCanVerifySmsCode) {
                          mySmsCode = cubit.mySmsCode;
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: mySmsCode.isNotEmpty
                                  ? () {

                                      cubit.verifySmsCode(
                                          cubit.mySmsCode, context);
                                    }
                                  : null,
                              disabledColor: AppColors.grey4,
                              height: 56,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28.0)),
                              textColor: AppColors.white,
                              color: AppColors.colorPrimary,
                              child: Text(
                                'verify'.tr(),
                                style: TextStyle(
                                    fontSize: 16.0, color: AppColors.white),
                              ),
                            ),
                            InkWell(
                              onTap: time.isEmpty
                                  ? () {
                                      cubit.sendSmsCode(context);
                                    }
                                  : null,
                              child: Text(
                                time.isNotEmpty ? time : 'resend'.tr(),
                                style: TextStyle(
                                    color: time.isNotEmpty
                                        ? AppColors.black
                                        : AppColors.colorPrimary,
                                    fontSize: time.isNotEmpty ? 16.0 : 13.0),
                              ),
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  navigateToSignUp({required String role, required LoginCubit cubit}) async {
    if (role == AppConstant.role_user) {
      var result = await Navigator.pushNamed(
          context, AppConstant.pageUserSignUpRoleRoute,
          arguments: cubit.loginModel);
      if (result != null) {
        Navigator.pop(context, true);
      }
    } else if (role == AppConstant.role_investor) {
      var result = await Navigator.pushNamed(
          context, AppConstant.pageInvestorSignUpRoleRoute,
          arguments: cubit.loginModel);
      if (result != null) {
        Navigator.pop(context, true);
      }
    } else if (role == AppConstant.role_consultant) {
      var result = await Navigator.pushNamed(
          context, AppConstant.pageConsultantSignUpRoleRoute);
      if (result != null) {
        Navigator.pop(context, true);
      }
    }
  }
}
