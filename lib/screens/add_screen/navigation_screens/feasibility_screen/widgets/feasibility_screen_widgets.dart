import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../colors/colors.dart';
import '../../../../../constants/app_constant.dart';

class FeasibilityScreenWidgets {
  const FeasibilityScreenWidgets();

  Widget buildListItem(
      {required BuildContext context,
      required CategoryModel model,
      required int index,
      required Function onTaped}) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return InkWell(
      onTap: () => onTaped(model: model, index: index),
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
                child: model.image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: model.image,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          return Container(
                            color: AppColors.grey2,
                          );
                        },
                      )
                    : Container(
                        color: AppColors.grey2,
                      ),
              ),
            ),
            Text(
              lang=='ar'?model.title_ar:model.title_en,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
