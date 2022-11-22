import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppWidget {
  static AppBar buildAppBar(
      {title = '',
      titleColor = AppColors.black,
      bg = AppColors.white,
      elevation = 0.0}) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: titleColor, fontSize: 18.0),
      ),
      elevation: elevation,
      backgroundColor: bg,
    );
  }

  static Widget svg(String name, Color color, double width, double height) {
    return SvgPicture.asset(
      AppConstant.localImagePath + name,
      width: width,
      height: height,
      color: color,
    );
  }
  static Widget mySvg(String name, Color color, double width, double height) {
    return SvgPicture.asset(
       name,
      width: width,
      height: height,
      color: color,
    );
  }
  static Widget circleAvatar(double width, double height,{String? path}) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8.0),
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage(path ??'${AppConstant.localImagePath}avatar.png'),
            fit: BoxFit.cover),
      ),
    );
  }

  static Widget circleAvatarWithBorder(double width, double height) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.colorPrimary, width: 1),
          image: DecorationImage(
              image: AssetImage('${AppConstant.localImagePath}avatar.png'),
              fit: BoxFit.cover)),
    );
  }

  static Widget buildBackArrow(
      {required BuildContext context,
      double padding = 16.0,
      bool paddingAll = false}) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: padding, vertical: paddingAll ? padding : 0),
      child: Transform.rotate(
          angle: lang == 'ar' ? (3.14) : 0,
          child: InkWell(

            onTap: () =>{AppRoutes.rout="",
              Navigator.of(context).pop()},
            child: AppWidget.svg('back_arrow.svg', AppColors.black, 24.0, 24.0),
          )),
    );
  }

  static Widget buildDashHorizontalLine({required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: LayoutBuilder(builder: (context, constrainBox) {
        final width = constrainBox.constrainWidth();
        const dashWidth = 10.0;
        int itemCount = (width / (2 * dashWidth)).floor();
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(itemCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: 1.0,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.grey4),
              ),
            );
          }),
        );
      }),
    );
  }

  static createProgressDialog(BuildContext context, String msg) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: AppColors.colorPrimary,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  msg,
                  style: TextStyle(color: AppColors.black, fontSize: 15.0),
                )
              ],
            ),
          );
        });
  }
}
