import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../colors/colors.dart';
import '../../../../../constants/asset_manager.dart';
import '../../../../../models/provider_order.dart';
import '../../../../../widgets/app_widgets.dart';
import '../cubit/orders_cubit.dart';
import 'Buttom.dart';

class orderDetailsBodyWidget extends StatelessWidget {
  const orderDetailsBodyWidget({Key? key, required this.mainOrdersModel}) : super(key: key);
  final ProviderOrder mainOrdersModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          mainOrdersModel.user.user.image.isNotEmpty
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
              : AppWidget.circleAvatar(64.0, 64.0),
          SizedBox(
            height: 13,
          ),
          Text(
            mainOrdersModel.user.user.firstName +
                " " +
                mainOrdersModel.user.user.lastName,
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
              AppWidget.mySvg(ImageAssets.providerDescIcon,
                  AppColors.colorPrimary, 16, 16),
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
                mainOrdersModel.img.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: mainOrdersModel.img,
                  width: 220,
                  height: 150,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      CircularProgressIndicator(
                        color: AppColors.colorPrimary,
                      ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    size: 64,
                    color: AppColors.colorPrimary,
                  ),
                )
                    : AppWidget.circleAvatar(64.0, 64.0),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    mainOrdersModel.details,
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Bottoms(
                color: const Color(0XFF143360),
                namedBottom: 'refused_btn'.tr(),
                callBack: () {
                  context.read<OrdersCubit>().changeProviderOrderStatus(mainOrdersModel.id.toString(),'refused');
                },
              ),
              Bottoms(
                color: const Color(0XFFF18F15),
                namedBottom: 'accept_btn'.tr(),
                callBack: () {
                  context.read<OrdersCubit>().changeProviderOrderStatus(mainOrdersModel.id.toString(),'accepted');
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
