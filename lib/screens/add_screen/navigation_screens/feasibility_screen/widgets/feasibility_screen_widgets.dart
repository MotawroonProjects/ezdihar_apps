import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../colors/colors.dart';
import '../../../../../constants/app_constant.dart';

class FeasibilityScreenWidgets {
  const FeasibilityScreenWidgets();

  Widget buildListItem(
      {required BuildContext context,
      required Object object,
      required int index,
      required Function onTaped}) {
    return InkWell(
      onTap: () => onTaped(object: object, index: index),
      child: Card(
        color: AppColors.white,
        shadowColor: AppColors.grey2,
        elevation: 8.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: AspectRatio(
                aspectRatio: 1 / .6,
                child: Image.asset(
                  'assets/images/test.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              'Title',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
