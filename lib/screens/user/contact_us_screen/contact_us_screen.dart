import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/user/contact_us_screen/cubit/contact_us_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../colors/colors.dart';
import '../../../widgets/app_widgets.dart';


class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  ContactUsCubit cubit = ContactUsCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'contactUs'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey3,
      body: _buildBodySection(),
    );
  }

  Widget _buildBodySection() {
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<ContactUsCubit, ContactUsState>(
        builder: (context, state) {
          bool isValid = false;
          if (state is OnDataValid) {
            isValid = true;
          }
          return Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: 215,
                    height: 136,
                    child: AspectRatio(
                        aspectRatio: 1 / .63,
                        child: Image.asset(
                          '${AppConstant.localImagePath}contact_bg.png',
                        )),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppWidget.svg(
                          'user.svg', AppColors.colorPrimary, 24.0, 24.0),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'name'.tr(),
                        style: const TextStyle(
                            fontSize: 16.0, color: AppColors.black),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                      height: 56.0,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextFormField(
                          initialValue: cubit.model.name,
                          maxLines: 1,
                          autofocus: false,
                          onChanged: (text) {
                            cubit.model.name = text;
                            cubit.checkData();
                          },
                          cursorColor: AppColors.colorPrimary,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'name'.tr(),
                              hintStyle: const TextStyle(
                                  color: AppColors.grey1, fontSize: 14.0)),
                        ),
                      )),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppWidget.svg(
                          'mail.svg', AppColors.colorPrimary, 24.0, 24.0),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'email'.tr(),
                        style: const TextStyle(
                            fontSize: 16.0, color: AppColors.black),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                      height: 56.0,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextFormField(
                          initialValue: cubit.model.email,
                          maxLines: 1,
                          autofocus: false,
                          onChanged: (text) {
                            cubit.model.email = text;
                            cubit.checkData();
                          },
                          cursorColor: AppColors.colorPrimary,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'email'.tr(),
                              hintStyle: const TextStyle(
                                  color: AppColors.grey1, fontSize: 14.0)),
                        ),
                      )),
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
                        'subject'.tr(),
                        style: const TextStyle(
                            fontSize: 16.0, color: AppColors.black),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                      height: 56.0,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextFormField(
                          initialValue: cubit.model.subject,
                          maxLines: 1,
                          autofocus: false,
                          onChanged: (text) {
                            cubit.model.subject = text;
                            cubit.checkData();
                          },
                          cursorColor: AppColors.colorPrimary,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'subject'.tr(),
                              hintStyle: const TextStyle(
                                  color: AppColors.grey1, fontSize: 14.0)),
                        ),
                      )),
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
                        'message'.tr(),
                        style: const TextStyle(
                            fontSize: 16.0, color: AppColors.black),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                      height: 114.0,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: TextFormField(
                        initialValue: cubit.model.message,
                        maxLines: null,
                        minLines: null,
                        expands: true,
                        autofocus: false,
                        onChanged: (text) {
                          cubit.model.message = text;
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
                  ElevatedButton(
                      style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all(Size(width, 56.0)),
                          elevation: MaterialStateProperty.all(2.0),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          backgroundColor: MaterialStateProperty.all(isValid
                              ? AppColors.colorPrimary
                              : AppColors.grey4)),
                      onPressed: isValid ? () {
                        cubit.send(context);

                      } : null,
                      child: Text(
                        'send'.tr(),
                        style: const TextStyle(
                            fontSize: 16.0, color: AppColors.white),
                      )),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
