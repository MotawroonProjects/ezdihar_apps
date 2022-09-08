import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/models/consultant_type_model.dart';
import 'package:flutter/material.dart';

class ConsultingWidgets {
  Widget buildListItem(
      {required BuildContext context,
      required ConsultantTypeModel model,
      required int index}) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return Card(
      color: AppColors.white,
      shadowColor: AppColors.grey2,
      elevation: 8.0,
      child:Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: model.image.isNotEmpty?CachedNetworkImage(
                imageUrl: model.image,
                fit: BoxFit.cover,
                placeholder: (context,url)=>Container(color: AppColors.grey2,),
                errorWidget: (context,url,error)=>Container(color: AppColors.grey2,)
              ):Container(color: AppColors.grey2,),
            ),
          ),
          Expanded(
              child: Center(
                child: Text(
                  lang=='ar'?model.title_ar:model.title_en,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      )
    );
  }
}
