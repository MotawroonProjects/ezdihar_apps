import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/auth_screens/user_sign_up/cubit/user_sign_up_cubit.dart';
import 'package:ezdihar_apps/screens/auth_screens/user_sign_up/cubit/user_sign_up_state.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserSignUpPage extends StatefulWidget {
  const UserSignUpPage({Key? key}) : super(key: key);

  @override
  State<UserSignUpPage> createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
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
    return ListView(
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
    );
  }

  buildAvatarSection(String image) {
    return BlocProvider.value(
      value: BlocProvider.of<UserSignUpCubit>(context),
      child: InkWell(
        onTap: () => buildAlertDialog(),
        child: BlocBuilder<UserSignUpCubit, UserSignUpState>(
          builder: (context, state) {
            XFile? file = BlocProvider.of<UserSignUpCubit>(context).imageFile;
            if (state is UserPhotoPicked) {
              file = state.file;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(147.0),
                  child: BlocProvider.of<UserSignUpCubit>(context)
                          .imageType
                          .isEmpty
                      ? Image.asset(
                          AppConstant.localImagePath + image,
                          width: 147.0,
                          height: 147.0,
                        )
                      : Image.file(
                          File(file!.path),
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
            buildTextTown(hint: 'town'.tr()),
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

  buildTextFormField(
      {required String hint,
      required TextInputType inputType,
      required action}) {
    UserSignUpCubit cubit = BlocProvider.of<UserSignUpCubit>(context);

    return Container(
      height: 54.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
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
                      date == 'DD/MM/YYYY' ? AppColors.grey6 : AppColors.black),
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
            child: MaterialButton(
          onPressed: isValid ? () {} : null,
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
          .updateBirthDate(date: DateFormat('dd-MM-yyyy').format(date));
    }
  }
}
