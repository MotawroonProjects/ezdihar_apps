import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/user/contact_us_screen/cubit/contact_us_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../colors/colors.dart';
import '../../../constants/snackbar_method.dart';
import '../../../widgets/app_widgets.dart';
import '../../../widgets/custom_textfield.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  ContactUsCubit cubit = ContactUsCubit();
  final _formKey = GlobalKey<FormState>();

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
          if (state is ContactUsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ContactUsLoaded) {
            print("success");
            Future.delayed(Duration(seconds: 3), () {
              snackBar("success".tr(), context, color: AppColors.success);
              Navigator.of(context).pop();
            }).whenComplete(() => null);
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
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
                  CustomTextField(
                    image: 'user.svg',
                    title: 'name'.tr(),
                    textInputType: TextInputType.text,
                    controller: cubit.nameController,
                    validatorMessage: "contactUsNameValidator".tr(),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppConstant.localImagePath + "mail.svg",
                              color: AppColors.colorPrimary,
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "email".tr(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: cubit.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "email".tr(),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: AppColors.white,
                              filled: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "contactUsEmailValidator".tr();
                            }
                            else if(cubit.emailController.text.contains("@")==false){
                              return "notEmail".tr();
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  CustomTextField(
                    image: 'subject.svg',
                    title: 'subject'.tr(),
                    textInputType: TextInputType.text,
                    controller: cubit.subjectController,
                    validatorMessage: "contactUsSubjectValidator".tr(),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  CustomTextField(
                    image: 'subject.svg',
                    title: 'message'.tr(),
                    minLine: 4,
                    textInputType: TextInputType.text,
                    controller: cubit.messageController,
                    validatorMessage: "contactUsMessageValidator".tr(),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(width, 56.0)),
                        elevation: MaterialStateProperty.all(2.0),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.colorPrimary),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                            context.read<ContactUsCubit>().send();
                        }
                      },
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
