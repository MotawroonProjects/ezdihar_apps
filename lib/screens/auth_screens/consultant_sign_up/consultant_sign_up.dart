import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/auth_screens/consultant_sign_up/cubit/consultant_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ConsultantSignUpPage extends StatefulWidget {
  const ConsultantSignUpPage({Key? key}) : super(key: key);

  @override
  State<ConsultantSignUpPage> createState() => _ConsultantSignUpPageState();
}

class _ConsultantSignUpPageState extends State<ConsultantSignUpPage> {
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

  buildForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24.0,
            ),
            buildRow(icon: 'specialization.svg', title: 'specialization'.tr()),
            SizedBox(
              height: 8.0,
            ),
            buildSpecialization(),
            SizedBox(
              height: 24.0,
            ),
            buildRow(icon: 'years.svg', title: 'yearsOfExperience'.tr()),
            SizedBox(
              height: 8.0,
            ),
            buildExperienceYear(),
            SizedBox(
              height: 24.0,
            ),
            buildRow(icon: 'offers.svg', title: 'consultationPrice'.tr()),
            SizedBox(
              height: 8.0,
            ),
            buildPriceField(),
            SizedBox(
              height: 24.0,
            ),
            buildRow(icon: 'bio.svg', title: 'bio'.tr()),
            SizedBox(
              height: 8.0,
            ),
            Container(
                height: 176.0,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.0)),
                child: TextFormField(
                  initialValue:
                      BlocProvider.of<ConsultantSignUpCubit>(context).model.bio,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  autofocus: false,
                  onChanged: (text) {
                    BlocProvider.of<ConsultantSignUpCubit>(context).model.bio =
                        text;
                    BlocProvider.of<ConsultantSignUpCubit>(context).checkData();
                  },
                  cursorColor: AppColors.colorPrimary,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'writeHere'.tr(),
                      hintStyle: const TextStyle(
                          color: AppColors.grey1, fontSize: 14.0)),
                )),
            SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {
                    BlocProvider.of<ConsultantSignUpCubit>(context)
                        .pickUpFile();
                  },
                  height: 48.0,
                  elevation: 1.0,
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    'chooseFile'.tr(),
                    style: TextStyle(fontSize: 16.0, color: AppColors.black),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                BlocBuilder<ConsultantSignUpCubit, ConsultantState>(
                  builder: (context, state) {
                    String fileName =
                        BlocProvider.of<ConsultantSignUpCubit>(context)
                            .fileName;
                    if (state is ConsultantFilePicked) {
                      fileName = state.fileName;
                    }
                    return Flexible(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        fileName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 13.0, color: AppColors.black),
                      ),
                    ));
                  },
                )
              ],
            )
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

  buildTextTown({required String hint}) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 54.0,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(8)),
      child: Text(
        hint,
        style: TextStyle(fontSize: 16.0, color: AppColors.grey6),
      ),
    );
  }

  buildSpecialization() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 54.0,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
              child: DropdownButton<Object>(
            underline: SizedBox(),
            iconSize: 0.0,
            isExpanded: true,
            isDense: true,
            items: [],
            onChanged: (Object? value) {},
          )),
          AppWidget.svg('down_arrow.svg', AppColors.grey6, 8.0, 8.0)
        ],
      ),
    );
  }

  buildExperienceYear() {
    double width = MediaQuery.of(context).size.width;


    return Container(
      width: width,
      height: 54.0,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(child: TextFormField(
            style: TextStyle(color: AppColors.black, fontSize: 16.0),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLines: 1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "0",
                hintStyle:
                TextStyle(fontSize: 16.0, color: AppColors.grey6)),
            onChanged: (text) {
              BlocProvider.of<ConsultantSignUpCubit>(context)
                  .model
                  .years_experience = text.isNotEmpty ? text : '0';
              BlocProvider.of<ConsultantSignUpCubit>(context).checkData();
            },
          )),

        ],
      ),
    );
  }

  buildPriceField() {
    return Container(
        height: 56.0,
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                initialValue:
                    BlocProvider.of<ConsultantSignUpCubit>(context).model.price,
                maxLines: 1,
                autofocus: false,
                onChanged: (text) {
                  BlocProvider.of<ConsultantSignUpCubit>(context).model.price =
                      text;
                  BlocProvider.of<ConsultantSignUpCubit>(context).checkData();
                },
                cursorColor: AppColors.colorPrimary,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'example_1000'.tr(),
                    hintStyle: const TextStyle(
                        color: AppColors.grey1, fontSize: 14.0)),
              ),
            )),
            Container(
              width: 56.0,
              height: 56.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.grey5,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Text(
                'sar'.tr(),
                style: const TextStyle(
                    color: AppColors.grey1,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }

  buildButtonStart() {
    ConsultantSignUpCubit cubit =
        BlocProvider.of<ConsultantSignUpCubit>(context);
    return BlocBuilder<ConsultantSignUpCubit, ConsultantState>(
      builder: (context, state) {
        bool isValid = cubit.isDataValid;
        if (state is ConsultantDataValidation) {
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
}
