import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../colors/colors.dart';
import '../../../../../constants/asset_manager.dart';
import '../../../../../models/provider_order.dart';
import '../../../../../preferences/preferences.dart';
import '../../../../../widgets/app_widgets.dart';
import '../cubit/orders_cubit.dart';
import 'Buttom.dart';

class orderDetailsBodyWidget extends StatelessWidget {
  late int user_id=0;

  orderDetailsBodyWidget({Key? key, required this.mainOrdersModel})
      : super(key: key);
  final ProviderOrder mainOrdersModel;

  @override
  Widget build(BuildContext context) {
    _onRefresh();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          user_id != mainOrdersModel.user.user.id
              ? (mainOrdersModel.user.user.image.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: mainOrdersModel.user.user.image,
                      width: 120,
                      height: 120,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: AppColors.colorPrimary,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 64,
                        color: AppColors.colorPrimary,
                      ),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                    )
                  : AppWidget.circleAvatar(64.0, 64.0))
              : (mainOrdersModel.user.user.image.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: mainOrdersModel.provider.user.image,
                      width: 120,
                      height: 120,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: AppColors.colorPrimary,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 64,
                        color: AppColors.colorPrimary,
                      ),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                    )
                  : AppWidget.circleAvatar(64.0, 64.0)),
          SizedBox(
            height: 13,
          ),
          Text(
            user_id != mainOrdersModel.user.user.id
                ? mainOrdersModel.user.user.firstName +
                    " " +
                    mainOrdersModel.user.user.lastName
                : mainOrdersModel.provider.user.firstName +
                    " " +
                    mainOrdersModel.provider.user.lastName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AppWidget.mySvg(ImageAssets.providerServicesIcon,
                  AppColors.colorPrimary, 16, 16),
              const SizedBox(
                width: 3,
              ),
              Text(
                'services_type'.tr(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                mainOrdersModel.subCategory.titleAr!,
                style: const TextStyle(fontSize: 14),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AppWidget.mySvg(
                  ImageAssets.providerDescIcon, AppColors.colorPrimary, 16, 16),
              SizedBox(
                width: 3,
              ),
              Text(
                'description'.tr(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.44,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'servicePrice'.tr(),
                              style: const TextStyle(
                                  fontSize: 12.0, color: AppColors.grey6),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppWidget.svg(
                                    'offers.svg', AppColors.colorPrimary, 24.0,
                                    24.0),
                                const SizedBox(width: 8,),
                                RichText(
                                  text: TextSpan(
                                      text: '${mainOrdersModel.price}',
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black),
                                      children: [
                                        TextSpan(
                                            text: 'sar'.tr(),
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                color: AppColors.black))
                                      ]
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                    Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'delivery_date'.tr(),
                              style: const TextStyle(
                                  fontSize: 12.0, color: AppColors.grey6),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppWidget.svg(
                                    'calender.svg', AppColors.colorPrimary, 24.0,
                                    24.0),
                                const SizedBox(width: 8,),
                                RichText(
                                  text: TextSpan(
                                      text: mainOrdersModel.delivery_date,
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black),
                                      children: [

                                      ]
                                  ),
                                )
                              ],
                            )
                          ],
                        )),

                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    mainOrdersModel.details,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Visibility(
              visible: user_id == mainOrdersModel.user.user ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Visibility(
              visible: mainOrdersModel.status.contains("new") ? true : false,
                 child: Bottoms(
                    color: const Color(0XFF143360),
                    namedBottom: 'refused_btn'.tr(),
                    callBack: () {
                      context.read<OrdersCubit>().changeProviderOrderStatus(
                          mainOrdersModel.id.toString(), 'refused');
                    },
                  )),
                  Bottoms(
                    color: const Color(0XFFF18F15),
                    namedBottom: mainOrdersModel.status.contains("new") ?'accept_btn'.tr():'compelete_btn'.tr(),
                    callBack: () {
                      context.read<OrdersCubit>().changeProviderOrderStatus(
                          mainOrdersModel.id.toString(), mainOrdersModel.status.contains("new") ?'accepted':'completed');
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    UserModel model = await Preferences.instance.getUserModel();
    user_id = model.user.id;
    // setState(() {
    //   user_id;
    // });
  }
}
