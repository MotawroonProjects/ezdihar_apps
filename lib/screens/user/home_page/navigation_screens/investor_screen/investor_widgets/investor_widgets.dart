import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../colors/colors.dart';



class InvestorWidgets {
  Widget buildListItem(
      {required BuildContext context,
      required Object object,
      required int index}) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      color: AppColors.white,
      shadowColor: AppColors.grey2,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Capital Towers',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters',
              style: TextStyle(fontSize: 12.0, color: AppColors.grey1),
            ),
            const SizedBox(
              height: 10.0,
            ),
            MaterialButton(
              onPressed: () {},
              minWidth: width,
              elevation: 0,
              color: AppColors.transparent,
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: AppColors.color1,width: 1.0)
                ),
                child: Text(
                  'negotiateNow'.tr(),
                  style: const TextStyle(fontSize: 16.0, color: AppColors.color1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
