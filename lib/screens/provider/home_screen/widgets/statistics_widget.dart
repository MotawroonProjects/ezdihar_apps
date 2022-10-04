import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/constants/asset_manager.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lan = EasyLocalization.of(context)!.locale.languageCode;
    return Row(
      children: [
        Transform.rotate(
            angle: lan == 'ar' ? 180 * math.pi / 180 : 0,
            child: Image.asset(ImageAssets.statisticsShapeImage)),
        SizedBox(width: 18),
        Text(
            "statistics".tr(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ],
    );
  }
}
