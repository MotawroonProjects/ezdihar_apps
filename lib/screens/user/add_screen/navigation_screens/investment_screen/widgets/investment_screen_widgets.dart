import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../constants/app_constant.dart';


class InvestmentScreenWidgets {
  const InvestmentScreenWidgets();

  Widget buildListItem(
      {required BuildContext context,
      required Object object,
      required int index,
      required Function onTaped}) {
    double width = MediaQuery.of(context).size.width;
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppColors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0))),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio:1 / .67,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Image.asset(
                    '${AppConstant.localImagePath}test.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              RichText(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text:
                      'Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: AppColors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              InkWell(
                onTap: () => onTaped(object: object, index: index),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12.0),
                  alignment: Alignment.center,
                  width: width,
                  height: 48.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.color1, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.rotate(
                          angle: lang == 'en' ? (3.14) : 0,
                          child: AppWidget.svg(
                              'arrow.svg', AppColors.color1, 24.0, 24.0)),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'details'.tr(),
                        style: const TextStyle(
                            fontSize: 14.0, color: AppColors.color1),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
