import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/screens/provider/control_services/cubit/control_services_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/translator.dart';

import '../../../../colors/colors.dart';
import '../../../../models/category_model.dart';
import '../../../../models/user_model.dart';

Future<void> showMyEmptyDialog(context, CategoryModel categoryModel) async {
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? descAr;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return BlocProvider<ControlServicesCubit>(
        create: (context) => ControlServicesCubit(),
        child: BlocBuilder<ControlServicesCubit, ControlServicesState>(
          builder: (context, state) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              content: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Text("servicePrice".tr()),
                        ),
                        TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: AppColors.grey2,
                              filled: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "priceValidator".tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Text("details".tr()),
                        ),
                        TextFormField(
                          controller: detailsController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: AppColors.grey2,
                              filled: true),
                          minLines: 5,
                          maxLines: 6,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "detailsValidator".tr();
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: <Widget>[
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await detailsController.text
                          .translate(to: 'ar')
                          .then((value) async {
                        descAr = value.text;
                        await detailsController.text.translate(to: 'en').then(
                              (value) => context
                                  .read<ControlServicesCubit>()
                                  .addNewServices(context, priceController.text,
                                      value.text, descAr, categoryModel.id),
                            );
                      });
                    }
                  },
                  child: Container(
                    width: 147,
                    height: 48,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.colorPrimary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      "confirm".tr(),
                      style: TextStyle(color: AppColors.colorPrimary),
                    )),
                  ),
                )
              ],
            );
          },
        ),
      );
    },
  );
}

Future<void> showMyDataDialog(context, SubCategories subCategories) async {
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  String lang = EasyLocalization.of(context)!.locale.languageCode;
  final formKey = GlobalKey<FormState>();
  String? descAr;
  priceController.text = subCategories.price!;
  detailsController.text =
      lang == 'ar' ? subCategories.descAr! : subCategories.descEn!;

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return BlocProvider<ControlServicesCubit>(
        create: (context) => ControlServicesCubit(),
        child: BlocBuilder<ControlServicesCubit, ControlServicesState>(
          builder: (context, state) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              content: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Text("servicePrice".tr()),
                        ),
                        TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: AppColors.grey2,
                              filled: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "priceValidator".tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Text("details".tr()),
                        ),
                        TextFormField(
                          controller: detailsController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: AppColors.grey2,
                              filled: true),
                          minLines: 5,
                          maxLines: 6,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "detailsValidator".tr();
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context
                                .read<ControlServicesCubit>()
                                .deleteMyServices(
                                  context,
                                  subCategories.id,
                                );
                          }
                        },
                        child: Container(
                          width: 147,
                          height: 48,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.grey2,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Text(
                            "delete_btn".tr(),
                            style: TextStyle(color: AppColors.black),
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await detailsController.text
                                .translate(to: 'ar')
                                .then((value) async {
                              descAr = value.text;
                              await detailsController.text
                                  .translate(to: 'en')
                                  .then(
                                    (value) => context
                                        .read<ControlServicesCubit>()
                                        .updateMyServices(
                                          context,
                                          priceController.text,
                                          value.text,
                                          descAr,
                                          subCategories.id,
                                        ),
                                  );
                            });
                          }
                        },
                        child: Container(
                          width: 147,
                          height: 48,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.monthOrder,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Text(
                            "update_btn".tr(),
                            style: TextStyle(color: AppColors.monthOrder),
                          )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      );
    },
  );
}

String? descAr;
String? descEn;

allIsDone({String? ar, String? en}) {
  descEn = en;
  descAr = ar;

  if (descEn != null && descAr != null) {
    print("descEn");
    print(descEn);
    print("descAr");
    print(descAr);
  } else {
    print("not yet");
  }
}
