import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/asset_manager.dart';
import 'package:ezdihar_apps/constants/convert_numbers_method.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

import '../../../../models/provider_home_page_model.dart';

class ProviderHomeCardWidget extends StatelessWidget {
  ProviderHomeCardWidget({Key? key, required this.index, required this.orders})
      : super(key: key);
  final Orders orders;
  final int index;

  late String image;
  late Color color;
  late String titleText;
  late String text;
  late String num;

  @override
  Widget build(BuildContext context) {
    String lan = EasyLocalization.of(context)!.locale.languageCode;

    if (index == 0) {
      image = ImageAssets.monthClientIcon;
      color = AppColors.monthClient;
      titleText = "client".tr();
      text = "client_month".tr();
      num = lan == 'en'
          ? orders.usersMonth.toString()
          : replaceToArabicNumber(orders.usersMonth.toString());
    } else if (index == 1) {
      image = ImageAssets.monthOrderIcon;
      color = AppColors.monthOrder;
      titleText = "order".tr();
      text = "order_month".tr();
      num = lan == 'en'
          ? orders.ordersMonth.toString()
          : replaceToArabicNumber(orders.ordersMonth.toString());
    } else if (index == 2) {
      image = ImageAssets.totalOrderIcon;
      color = AppColors.totalOrder;
      titleText = "order".tr();
      text = "total_orders".tr();
      num = lan == 'en'
          ? orders.orders.toString()
          : replaceToArabicNumber(orders.orders.toString());
    } else {
      image = ImageAssets.totalClientIcon;
      color = AppColors.totalClient;
      titleText = "client".tr();
      text = "total_clients".tr();
      num = lan == 'en'
          ? orders.totalUsers.toString()
          : replaceToArabicNumber(orders.totalUsers.toString());
    }
    return SizedBox(
      width: null,
      height: null,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: AppWidget.mySvg(
                    image,
                    AppColors.white,
                    32,
                    32,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    "$num",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: color),
                  ),
                  SizedBox(width: 8),
                  Text(
                    titleText,
                    style: TextStyle(fontSize: 16, color: AppColors.grey1),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
