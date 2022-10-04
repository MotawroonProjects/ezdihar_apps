import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/provider_order.dart';
import '../../../../../widgets/app_widgets.dart';
import '../cubit/orders_cubit.dart';
import '../screens/Orders_Deatils.dart';

class ItemsOrders extends StatelessWidget {
  final ProviderOrder mainOrdersModel;

  ItemsOrders({required this.mainOrdersModel});

  @override
  Widget build(BuildContext contexts) {
    String lan = EasyLocalization.of(contexts)!.locale.languageCode;
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrdersDetails(mainOrdersModel: mainOrdersModel),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(13),
              height: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  mainOrdersModel.user.user.image.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: mainOrdersModel.user.user.image,
                          width: 64,
                          height: 64,
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
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            backgroundImage: imageProvider,
                          ),
                        )
                      : AppWidget.circleAvatar(64.0, 64.0),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mainOrdersModel.user.user.firstName +
                            " " +
                            mainOrdersModel.user.user.lastName,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        mainOrdersModel.subCategory.title,
                        style: const TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'details'.tr(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0XFF143360),
                        ),
                      ),
                      SizedBox(width: 3),
                      lan == 'en'
                          ? Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 12,
                              color: Color(0XFF143360),
                            )
                          : Icon(
                              Icons.keyboard_arrow_left_outlined,
                              size: 12,
                              color: Color(0XFF143360),
                            ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
