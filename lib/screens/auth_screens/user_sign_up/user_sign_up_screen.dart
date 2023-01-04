import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/models/login_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/screens/auth_screens/user_sign_up/cubit/user_sign_up_cubit.dart';
import 'package:ezdihar_apps/screens/auth_screens/user_sign_up/cubit/user_sign_up_state.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';

class UserSignUpPage extends StatefulWidget {
  LoginModel loginModel;

  UserSignUpPage({Key? key, required this.loginModel}) : super(key: key);

  @override
  State<UserSignUpPage> createState() => _UserSignUpPageState(loginModel);
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  LoginModel loginModel;

  _UserSignUpPageState(this.loginModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'sign_up'.tr(),
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
    UserSignUpCubit cubit = BlocProvider.of<UserSignUpCubit>(context);
    cubit.updatePhoneCode_Phone(loginModel.phone_code, loginModel.phone);
    return BlocListener<UserSignUpCubit, UserSignUpState>(
      listener: (context, state) {
        if (state is OnError) {
          AlertController.show('warning'.tr(), state.error, TypeAlert.warning);

        } else if (state is OnSignUpSuccess) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppConstant.pageHomeRoute,ModalRoute.withName(AppConstant.pageSplashRoute));
          //Navigator.pop(context, true);
        }
      },
      child: ListView(
        children: [
          SizedBox(
            height: 36.0,
          ),
          buildAvatarSection('avatar2.png'),
          SizedBox(
            height: 36.0,
          ),
          buildForm(),
          SizedBox(
            height: 56.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                buildButtonBack(),
                SizedBox(
                  width: 8.0,
                ),
                buildButtonStart()
              ],
            ),
          ),
          SizedBox(
            height: 56.0,
          ),
        ],
      ),
    );
  }

  buildAvatarSection(String image) {
    UserSignUpCubit cubit = BlocProvider.of(context);
    return BlocProvider.value(
      value: BlocProvider.of<UserSignUpCubit>(context),
      child: BlocBuilder<UserSignUpCubit, UserSignUpState>(
        builder: (context, state) {
          String imagePath = cubit.model.imagePath;
          if (state is UserPhotoPicked) {
            imagePath = state.imagePath;
          }
          else if(state is OnUserDataGet){
            imagePath = cubit.imagePath;
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  buildAlertDialog();
                },
                child: Container(
                  width: 147.0,
                  height: 147.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(147.0),
                    child: BlocProvider.of<UserSignUpCubit>(context)
                            .imageType
                            .isEmpty
                        ?
                    imagePath.startsWith('http')
                            ? CachedNetworkImage(
                                imageUrl: imagePath,
                                imageBuilder: (context,imageProvider){
                                  return CircleAvatar(
                                    backgroundImage: imageProvider,
                                  );
                                },
                                width: 147.0,
                                height: 147.0,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return CircleAvatar(
                                    child: Image.asset(
                                      AppConstant.localImagePath +
                                          'avatar2.png',
                                      width: 147.0,
                                      height: 147.0,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },errorWidget: (context,url,error){
                                  return CircleAvatar(
                                    child: Image.asset(
                                      AppConstant.localImagePath +
                                          'avatar2.png',
                                      width: 147.0,
                                      height: 147.0,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                    },
                              )
                            : Image.asset(
                                AppConstant.localImagePath + image,
                                width: 147.0,
                                height: 147.0,
                              )
                        : Image.file(
                            File(imagePath),
                            width: 147.0,
                            height: 147.0,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  buildAlertDialog() {
    return showDialog(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<UserSignUpCubit>(context),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'choose_photo'.tr(),
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 1,
                    color: AppColors.grey3,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      BlocProvider.of<UserSignUpCubit>(context)
                          .pickImage(type: 'camera');
                    },
                    child: Text(
                      'camera'.tr(),
                      style: TextStyle(fontSize: 18.0, color: AppColors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      BlocProvider.of<UserSignUpCubit>(context)
                          .pickImage(type: 'gallery');
                    },
                    child: Text(
                      'gallery'.tr(),
                      style: TextStyle(fontSize: 18.0, color: AppColors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Container(
                    height: 1,
                    color: AppColors.grey3,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'cancel'.tr(),
                      style: TextStyle(
                          fontSize: 18.0, color: AppColors.colorPrimary),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  buildForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildRow(icon: 'user_card.svg', title: 'user_name'.tr()),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Flexible(child: buildTextFormFieldFirstName()),
                SizedBox(
                  width: 8.0,
                ),
                Flexible(child: buildTextFormFieldLastName())
              ],
            ),
            SizedBox(
              height: 24.0,
            ),
            buildRow(icon: 'mail2.svg', title: 'email'.tr()),
            SizedBox(
              height: 8.0,
            ),
            buildTextFormFieldEmail(),
            SizedBox(
              height: 24.0,
            ),
            buildRow(icon: 'town.svg', title: 'town'.tr()),
            SizedBox(
              height: 8.0,
            ),
            buildCityField(),
            SizedBox(
              height: 24.0,
            ),
            buildRow(icon: 'calender.svg', title: 'date_birth'.tr()),
            SizedBox(
              height: 8.0,
            ),
            buildTextDate(),
          ],
        ),
      ),
    );
  }

  buildRow({required String icon, required String title}) {
    return Row(
      children: [
        AppWidget.svg(icon, AppColors.colorPrimary, 24.0, 24.0),
        SizedBox(
          width: 8.0,
        ),
        Text(
          title,
          style: TextStyle(color: AppColors.black, fontSize: 16.0),
        )
      ],
    );
  }

  buildTextFormFieldFirstName() {
    UserSignUpCubit cubit = BlocProvider.of<UserSignUpCubit>(context);
    return BlocBuilder<UserSignUpCubit, UserSignUpState>(
      builder: (context, state) {

        return Container(
          height: 54.0,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            controller: cubit.controllerFirstName,
            keyboardType: TextInputType.name,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp('[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FF]'))
            ],
            style: TextStyle(color: AppColors.black, fontSize: 14.0),
            onChanged: (data) {
              cubit.model.firstName = data;
              cubit.checkData();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'first_name'.tr(),
              hintStyle: TextStyle(fontSize: 14.0, color: AppColors.grey6),
            ),
          ),
        );
      },
    );
  }

  buildTextFormFieldLastName() {
    UserSignUpCubit cubit = BlocProvider.of<UserSignUpCubit>(context);

    return BlocBuilder<UserSignUpCubit, UserSignUpState>(
      builder: (context, state) {
        return Container(
          height: 54.0,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            controller: cubit.controllerLastName,
            keyboardType: TextInputType.name,

            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp('[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FF]'))],

            style: TextStyle(color: AppColors.black, fontSize: 14.0),
            onChanged: (data) {
              cubit.model.lastName = data;
              cubit.checkData();

            },

            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'last_name'.tr(),
              hintStyle: TextStyle(fontSize: 14.0, color: AppColors.grey6),
            ),
          ),
        );
      },
    );
  }

  buildTextFormFieldEmail() {
    UserSignUpCubit cubit = BlocProvider.of<UserSignUpCubit>(context);

    return BlocBuilder<UserSignUpCubit, UserSignUpState>(
      builder: (context, state) {
        return Container(
          height: 54.0,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            controller: cubit.controllerEmail,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: AppColors.black, fontSize: 14.0),
            onChanged: (data) {
              cubit.model.email = data;
              cubit.checkData();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'email'.tr(),
              hintStyle: TextStyle(fontSize: 14.0, color: AppColors.grey6),
            ),
          ),
        );
      },
    );
  }

  buildCityField() {
    double width = MediaQuery.of(context).size.width;
    UserSignUpCubit cubit = BlocProvider.of<UserSignUpCubit>(context);
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return InkWell(
      onTap: () => navigateToCitiesPage(),
      child: BlocBuilder<UserSignUpCubit, UserSignUpState>(
        builder: (context, state) {
          return Container(
            width: width,
            height: 54.0,
            alignment:
                lang == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
                color: AppColors.white, borderRadius: BorderRadius.circular(8)),
            child: Text(
                '${lang == 'ar' ? cubit.selectedCityModel.cityNameAr : cubit.selectedCityModel.cityNameEn}'),
          );
        },
      ),
    );
  }

  buildTextDate() {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        showBirthDateCalender();
      },
      child: Container(
        width: width,
        height: 54.0,
        alignment: lang == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(8)),
        child: BlocBuilder<UserSignUpCubit, UserSignUpState>(
          builder: (context, state) {
            String date = BlocProvider.of<UserSignUpCubit>(context).birthDate;
            if (state is UserBirthDateSelected) {
              date = state.date;
            }
            return Text(
              date,
              style: TextStyle(
                  fontSize: 16.0,
                  color:
                      date == 'YYYY-MM-DD' ? AppColors.grey6 : AppColors.black),
            );
          },
        ),
      ),
    );
  }

  buildButtonStart() {
    UserSignUpCubit cubit = BlocProvider.of<UserSignUpCubit>(context);
    return BlocBuilder<UserSignUpCubit, UserSignUpState>(
      builder: (context, state) {
        bool isValid = cubit.isDataValid;
        if (state is UserDataValidation) {
          isValid = state.valid;
        }
        return Expanded(
            child: MaterialButton (
          onPressed: isValid
              ? () async {
            UserModel model = await Preferences.instance.getUserModel();
            if(model.user.isLoggedIn){
              cubit.updateProfile(context,model.access_token);
            }else{
              cubit.signUp(context);
            }

                }
              : null,
          height: 56.0,
          color: AppColors.colorPrimary,
          disabledColor: AppColors.grey4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Text(
            'start'.tr(),
            style: TextStyle(fontSize: 16.0, color: AppColors.white),
          ),
        ));
      },
    );
  }

  buildButtonBack() {
    return Expanded(
        child: MaterialButton(
      onPressed: () => Navigator.pop(context),
      height: 56.0,
      color: AppColors.color1,
      disabledColor: AppColors.grey4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Text(
        'back'.tr(),
        style: TextStyle(fontSize: 16.0, color: AppColors.white),
      ),
    ));
  }

  showBirthDateCalender() async {
    DateTime? date = await showDatePicker(
        context: context,
        locale: EasyLocalization.of(context)!.locale,
        initialDate: BlocProvider.of<UserSignUpCubit>(context).initialDate,
        firstDate: BlocProvider.of<UserSignUpCubit>(context).startData,
        lastDate: BlocProvider.of<UserSignUpCubit>(context).endData,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    primary: AppColors.colorPrimary,
                    onPrimary: AppColors.white,
                    onSurface: AppColors.black)),
            child: child!,
          );
        });

    if (date != null) {
      BlocProvider.of<UserSignUpCubit>(context)
          .updateBirthDate(date: DateFormat('yyyy-MM-dd','en').format(date));
    }
  }

  void navigateToCitiesPage() async {
    var result =
        await Navigator.pushNamed(context, AppConstant.pageCitiesRoute);
    if (result != null) {
      CityModel model = result as CityModel;
      UserSignUpCubit cubit = BlocProvider.of<UserSignUpCubit>(context);
      cubit.updateSelectedCity(model);
    }
  }
}
