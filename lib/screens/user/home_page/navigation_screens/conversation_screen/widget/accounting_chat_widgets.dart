import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/chat_model.dart';
import 'package:ezdihar_apps/models/user_data_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AccountingChatWidgets {
  Widget _buildAvatar({required double width, required double height}) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width),
        child: Image.asset(
          "${AppConstant.localImagePath}avatar.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildListItem(
      {required BuildContext context,
      required ChatModel model,
        required int user_id,
      required int index}) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;


     return Container(

        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading:model.user_id==user_id?
              model.provider.image.isNotEmpty?CachedNetworkImage(
                imageUrl: model.provider.image,
                placeholder: (context,url)=>_buildAvatar(width: 48.0, height: 48.0),
                errorWidget: (context,url,error)=>_buildAvatar(width: 48.0, height: 48.0),
                width: 48,
                height: 48,
                imageBuilder: (context,imageProvider){
                  return CircleAvatar(backgroundImage:imageProvider,radius: 48.0,);
                },
              ):_buildAvatar(width: 48.0, height: 48.0):
              model.user.image.isNotEmpty?CachedNetworkImage(
                imageUrl: model.user.image,
                placeholder: (context,url)=>_buildAvatar(width: 48.0, height: 48.0),
                errorWidget: (context,url,error)=>_buildAvatar(width: 48.0, height: 48.0),
                width: 48,
                height: 48,
                imageBuilder: (context,imageProvider){
                  return CircleAvatar(backgroundImage:imageProvider,radius: 48.0,);
                },
              ):_buildAvatar(width: 48.0, height: 48.0),
              title: Text(
                '${model.user_id==user_id?model.provider.firstName+" "+model.provider.lastName:model.user.firstName+" "+model.user.lastName}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: AppColors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(model.latest_message!=null?model.latest_message!.type.contains("file")?"attachment".tr():model.latest_message!.message:""),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    model.latest_message!=null?model.latest_message!.time:"",
                    style: const TextStyle(
                        fontSize: 14.0, color: AppColors.color1),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 8.0,),
            Divider(color: AppColors.grey4,)
          ],
        ),
      )
    ;
  }

}
