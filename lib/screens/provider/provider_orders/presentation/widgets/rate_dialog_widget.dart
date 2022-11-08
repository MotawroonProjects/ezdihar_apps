import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/screens/provider/control_services/cubit/control_services_cubit.dart';
import 'package:ezdihar_apps/screens/provider/provider_orders/presentation/cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:translator/translator.dart';

import '../../../../../colors/colors.dart';
import '../../../../../models/provider_order.dart';
import '../../../../../widgets/app_widgets.dart';

Future<void> showMyEmptyDialog(context, ProviderOrder orderModel) async {
  TextEditingController detailsController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  double rateprovider=0;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return BlocProvider<OrdersCubit>(
        create: (context) => OrdersCubit(),
        child: BlocBuilder<OrdersCubit, OrdersState>(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: CachedNetworkImage(
                              width: 60,
                              height: 60,
                              imageUrl: orderModel.provider.user.image,
                              placeholder: (context, url) =>
                                  AppWidget.circleAvatar(60, 60),
                              errorWidget: (context, url, error) {
                                return Container(
                                  color: AppColors.grey3,
                                );
                              },
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                    backgroundImage: imageProvider,
                                    radius: 60,
                                  )),
                          title: Text(
                            orderModel.provider.user.firstName +
                                " " +
                                orderModel.provider.user.lastName,
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        RatingBar.builder(
                            itemCount: 5,
                            direction: Axis.horizontal,
                            itemSize: 22,
                            maxRating: 5,
                            allowHalfRating: false,
                            initialRating: 0,
                            tapOnlyMode: true,
                            ignoreGestures: false,
                            minRating: 0,
                            unratedColor: AppColors.grey1,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star_rate_rounded,
                                color: AppColors.colorPrimary,
                              );
                            },
                            onRatingUpdate: (rate) {
                              rateprovider = rate;
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child:

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppWidget.svg(
                                  'subject.svg', AppColors.colorPrimary, 24.0, 24.0),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'note'.tr(),
                                style:
                                const TextStyle(fontSize: 16.0, color: AppColors.black),
                              )
                            ],
                          ),
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

                        await context.read<OrdersCubit>().rate(
                            context,
                            detailsController.text,
                            rateprovider.toInt().toString(),
                            orderModel.id);

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
