import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/screens/add_post_screen/cubit/add_post_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostScreen extends StatefulWidget {


  const AddPostScreen({Key? key})
      : super(key: key);

  @override
  State<AddPostScreen> createState() =>
      _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  _AddPostScreenState();

  late AddPostCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = BlocProvider.of(context);
    cubit.checkData();
    double width = MediaQuery.of(context).size.width;
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
         'addpost'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey3,
      body: BlocListener<AddPostCubit, AddPostState>(
        listener: (context, state) {
          if (state is OnAddedSuccess) {
            Navigator.pop(context);
          }
        },
        child: BlocProvider(
          create: (context) => cubit,
          child: BlocBuilder<AddPostCubit, AddPostState>(
            builder: (context, state) {
              bool isValid = cubit.model.isDataValid();
              if (state is OnDataValid) {
                isValid = true;
              }
              if (state is IsLoading) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        _buildBodySection(state),
                        Container(
                          width: width,
                          height: 56.0,
                          decoration: BoxDecoration(
                              color: isValid
                                  ? AppColors.colorPrimary
                                  : AppColors.grey4,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24.0),
                                  topRight: Radius.circular(24.0))),
                          child: Center(
                              child: Text(
                            'send'.tr(),
                            style: const TextStyle(
                                fontSize: 16.0, color: AppColors.white),
                          )),
                        )
                      ],
                    ),
                    Container(
                      color: AppColors.black.withOpacity(.2),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.colorPrimary,
                        ),
                      ),
                    )
                  ],
                );
              }

              if (state is OnDataError) {
                return Column(
                  children: [
                    _buildBodySection(state),
                    Container(
                      width: width,
                      height: 56.0,
                      decoration: BoxDecoration(
                          color: isValid
                              ? AppColors.colorPrimary
                              : AppColors.grey4,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0))),
                      child: Center(
                          child: Text(
                        'send'.tr(),
                        style: const TextStyle(
                            fontSize: 16.0, color: AppColors.white),
                      )),
                    )
                  ],
                );
              }

              return Column(
                children: [
                  _buildBodySection(state),
                  InkWell(
                    onTap: isValid
                        ? () {
                            cubit.addPost();
                          }
                        : null,
                    child: Container(
                      width: width,
                      height: 56.0,
                      decoration: BoxDecoration(
                          color: isValid
                              ? AppColors.colorPrimary
                              : AppColors.grey4,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0))),
                      child: Center(
                          child: Text(
                        'send'.tr(),
                        style: const TextStyle(
                            fontSize: 16.0, color: AppColors.white),
                      )),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _buildBodySection(AddPostState state) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;




    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppWidget.svg(
                    'project.svg', AppColors.colorPrimary, 24.0, 24.0),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  'post_photo'.tr(),
                  style:
                      const TextStyle(fontSize: 16.0, color: AppColors.black),
                )
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            InkWell(
              onTap: () {
                buildAlertDialog();
              },
              child: Container(
                height: 220,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Stack(
                  children: [
                    DottedBorder(
                      child: Container(),
                      dashPattern: [8, 10],
                      color: AppColors.grey2,
                      padding: EdgeInsets.all(8),
                      strokeWidth: 1.0,
                      radius: Radius.circular(1),
                      borderType: BorderType.RRect,
                      strokeCap: StrokeCap.round,
                    ),
                    cubit.model.project_photo_path.isNotEmpty
                        ? Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1),
                              child: Image.file(
                                File(cubit.model.project_photo_path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'ch_photo'.tr(),
                              style: TextStyle(
                                  color: AppColors.grey6, fontSize: 15.0),
                            ),
                          )
                  ],
                ),
              ),
            ),



            const SizedBox(
              height: 24.0,
            ),


            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppWidget.svg(
                    'subject.svg', AppColors.colorPrimary, 24.0, 24.0),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  'details'.tr(),
                  style:
                      const TextStyle(fontSize: 16.0, color: AppColors.black),
                )
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
                height: 176.0,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.0)),
                child: TextFormField(
                  initialValue: cubit.model.details,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  autofocus: false,
                  onChanged: (text) {
                    cubit.model.details = text;
                    cubit.checkData();
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
            const SizedBox(
              height: 24.0,
            ),



                ],
              ),
            ),

        ),
      )
    ;
  }

  buildAlertDialog() {
    return showDialog(
        context: context,
        builder: (c) {
          return BlocProvider.value(
            value: cubit,
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
                      cubit.pickImage(type: 'camera');
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
                      cubit.pickImage(type: 'gallery');
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
}

class LimitRange extends TextInputFormatter {
  LimitRange(
    this.minRange,
    this.maxRange,
  ) : assert(
          minRange < maxRange,
        );

  final int minRange;
  final int maxRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.parse(newValue.text);
    if (value < minRange) {
      print('value print in between 1 - 20');
      return TextEditingValue(text: minRange.toString());
    } else if (value > maxRange) {
      print('not more 20');
      return TextEditingValue(text: maxRange.toString());
    }
    return newValue;
  }
}
