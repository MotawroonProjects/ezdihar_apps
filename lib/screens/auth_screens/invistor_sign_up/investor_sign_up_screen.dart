import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/screens/auth_screens/invistor_sign_up/cubit/investor_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/login_model.dart';
import '../../../models/user.dart';
import '../../../models/user_model.dart';
import '../../../preferences/preferences.dart';

class InvestorSignUpPage extends StatefulWidget {
  InvestorSignUpPage(
      {Key? key, this.kindOfPage = 'new', required this.loginModel})
      : super(key: key);
  final String kindOfPage;
  final LoginModel loginModel;

  @override
  State<InvestorSignUpPage> createState() =>
      _InvestorSignUpPageState(loginModel);
}

class _InvestorSignUpPageState extends State<InvestorSignUpPage> {
  int currentValue = 0;
  LoginModel loginModel;

   UserModel model=UserModel();

  _InvestorSignUpPageState(this.loginModel);

  @override
  void initState() {
    super.initState();
    getuser();
  }

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
    InvestorCubit cubit = BlocProvider.of<InvestorCubit>(context);
    cubit.updatePhoneCode_Phone(loginModel.phone_code, loginModel.phone);
    return BlocListener<InvestorCubit, InvestorState>(
        listener: (context, state) {
          if (state is OnError) {
            AlertController.show(
                'warning'.tr(), state.error, TypeAlert.warning);
          } else if (state is OnSignUpSuccess) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppConstant.providerNavigationBottomRoute,
                ModalRoute.withName(AppConstant.pageSplashRoute));
            // Navigator.of(context).pushReplacementNamed(AppConstant.providerNavigationBottomRoute);

            // Navigator.pop(context, true);
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
              height: 24.0,
            ),
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
        ));
  }

  buildAvatarSection(String image) {
    InvestorCubit cubit = BlocProvider.of(context);

    return BlocProvider.value(
      value: BlocProvider.of<InvestorCubit>(context),
      child: InkWell(
        onTap: () => buildAlertDialog(),
        child: BlocBuilder<InvestorCubit, InvestorState>(
          builder: (context, state) {
            String imagePath = cubit.model.imagePath;
            if (state is InvestorFilePicked) {
              imagePath = state.fileName;
            } else if (state is OnUserDataGet) {
              imagePath = cubit.model.imagePath;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(147.0),
                  child: BlocProvider.of<InvestorCubit>(context)
                          .imageType
                          .isEmpty
                      ? imagePath.startsWith('http')
                          ? CachedNetworkImage(
                              imageUrl: imagePath,
                              imageBuilder: (context, imageProvider) {
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
                                    AppConstant.localImagePath + 'avatar2.png',
                                    width: 147.0,
                                    height: 147.0,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) {
                                return CircleAvatar(
                                  child: Image.asset(
                                    AppConstant.localImagePath + 'avatar2.png',
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
                          File(cubit.model.imagePath),
                          width: 147.0,
                          height: 147.0,
                          fit: BoxFit.cover,
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  buildAlertDialog() {
    return showDialog(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<InvestorCubit>(context),
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
                      BlocProvider.of<InvestorCubit>(context)
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
                      BlocProvider.of<InvestorCubit>(context)
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
                Flexible(
                    child: buildTextFormField(
                        hint: 'first_name'.tr(),
                        inputType: TextInputType.text,
                        action: 'firstName')),
                SizedBox(
                  width: 8.0,
                ),
                Flexible(
                    child: buildTextFormField(
                        hint: 'last_name'.tr(),
                        inputType: TextInputType.text,
                        action: 'lastName'))
              ],
            ),
            SizedBox(
              height: 24.0,
            ),
            buildRow(icon: 'mail2.svg', title: 'email'.tr()),
            SizedBox(
              height: 8.0,
            ),
            buildTextFormField(
                hint: 'email'.tr(),
                inputType: TextInputType.emailAddress,
                action: 'email'),
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
            Visibility(
              visible: model.user.isLoggedIn ? false : true,
              child: buildRow(icon: 'category.svg', title: 'category'.tr()),
            ),
            Visibility(
                visible: model.user.isLoggedIn ? false : true,
                child: SizedBox(
                  height: 8.0,
                )),
            Visibility(
                visible: model.user.isLoggedIn ? false : true,
                child: buildCategoryField()),
            SizedBox(
              height: 24.0,
            ),
            buildRow(icon: 'calender.svg', title: 'date_birth'.tr()),
            SizedBox(
              height: 8.0,
            ),
            buildTextDate(),
            SizedBox(
              height: 8.0,
            ),
            buildRow(icon: 'years.svg', title: 'yearsOfExperience'.tr()),
            SizedBox(
              height: 8.0,
            ),
            buildyearcounter(),
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

  buildTextFormField({
    required String hint,
    required TextInputType inputType,
    required action,
  }) {
    InvestorCubit cubit = BlocProvider.of<InvestorCubit>(context);

    return Container(
      height: 54.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: action == 'firstName'
            ? cubit.controllerFirstName
            : action == 'lastName'
                ? cubit.controllerLastName
                : cubit.controllerEmail,
        keyboardType: inputType,
        style: TextStyle(color: AppColors.black, fontSize: 14.0),
        onChanged: (data) {
          if (action == 'firstName') {
            cubit.model.firstName = data;
          } else if (action == 'lastName') {
            cubit.model.lastName = data;
          } else if (action == 'email') {
            cubit.model.email = data;
          }

          cubit.checkData();
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14.0, color: AppColors.grey6),
        ),
      ),
    );
  }

  buildTextTown({required String hint}) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 54.0,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(8)),
      child: Text(
        hint,
        style: TextStyle(fontSize: 16.0, color: AppColors.grey6),
      ),
    );
  }

  buildTextDate() {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        showBirthDateCalender();
      },
      child: Container(
        width: width,
        height: 54.0,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(8)),
        child: BlocBuilder<InvestorCubit, InvestorState>(
          builder: (context, state) {
            String date = BlocProvider.of<InvestorCubit>(context).birthDate;
            if (state is InvestorBirthDateSelected) {
              date = state.date;
            }
            return Text(
              date,
              style: TextStyle(
                  fontSize: 16.0,
                  color:
                      date == 'DD/MM/YYYY' ? AppColors.grey6 : AppColors.black),
            );
          },
        ),
      ),
    );
  }

  buildButtonStart() {
    InvestorCubit cubit = BlocProvider.of<InvestorCubit>(context);
    return BlocBuilder<InvestorCubit, InvestorState>(
      builder: (context, state) {
        bool isValid = cubit.isDataValid;
        if (state is InvestorDataValidation) {
          isValid = state.valid;
        }
        return Expanded(
            child: MaterialButton(
          onPressed: isValid
              ? () async {
                  UserModel model = await Preferences.instance.getUserModel();
                  if (model.user.isLoggedIn) {
                    cubit.updateProfile(context, model.access_token);
                  } else {
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

  buildyearcounter() {
    InvestorCubit cubit = BlocProvider.of<InvestorCubit>(context);

    return Container(
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TextFormField(
              onChanged: (value) => {cubit.model.years_ex = value.toString()},
              controller: cubit.controlleryear,
              decoration: InputDecoration(
                border: InputBorder.none,
                //  hintText: 'hint',

                contentPadding: EdgeInsets.all(5),
                hintStyle: TextStyle(fontSize: 14.0, color: AppColors.grey6),
              ),

              //  controller: _controller,
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
                signed: true,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
        ],
      ),
    );
  }

  showBirthDateCalender() async {
    DateTime? date = await showDatePicker(
        context: context,
        locale: EasyLocalization.of(context)!.locale,
        initialDate: BlocProvider.of<InvestorCubit>(context).initialDate,
        firstDate: BlocProvider.of<InvestorCubit>(context).startData,
        lastDate: BlocProvider.of<InvestorCubit>(context).endData,
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
      BlocProvider.of<InvestorCubit>(context)
          .updateBirthDate(date: DateFormat('yyyy-MM-dd', 'en').format(date));
    }
  }

  buildCityField() {
    double width = MediaQuery.of(context).size.width;
    InvestorCubit cubit = BlocProvider.of<InvestorCubit>(context);
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return InkWell(
      onTap: () => navigateToCitiesPage(),
      child: BlocBuilder<InvestorCubit, InvestorState>(
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

  void navigateToCitiesPage() async {
    var result =
        await Navigator.pushNamed(context, AppConstant.pageCitiesRoute);
    if (result != null) {
      CityModel model = result as CityModel;
      InvestorCubit cubit = BlocProvider.of<InvestorCubit>(context);
      cubit.updateSelectedCity(model);
    }
  }

  buildCategoryField() {
    double width = MediaQuery.of(context).size.width;
    InvestorCubit cubit = BlocProvider.of<InvestorCubit>(context);
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return InkWell(
      onTap: () => navigateToCategoryPage(),
      child: BlocBuilder<InvestorCubit, InvestorState>(
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
                '${lang == 'ar' ? cubit.categoryModel.title_ar : cubit.categoryModel.title_en}'),
          );
        },
      ),
    );
  }

  void navigateToCategoryPage() async {
    var result =
        await Navigator.pushNamed(context, AppConstant.pageCategoryRoute);
    if (result != null) {
      CategoryModel model = result as CategoryModel;
      InvestorCubit cubit = BlocProvider.of<InvestorCubit>(context);
      cubit.updateSelectedCategory(model);
    }
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  Future<void> getuser() async {
    model = await Preferences.instance.getUserModel();
    setState(() {
      model;
    });
  }
}
