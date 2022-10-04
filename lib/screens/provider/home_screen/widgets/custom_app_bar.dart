import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

import '../../../../constants/asset_manager.dart';
import '../../../../models/user.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          user.isLoggedIn
              ? CachedNetworkImage(
                  imageUrl: user.image,
                  width: 64,
                  height: 64,
                  placeholder: (context, url) => CircularProgressIndicator(
                    color: AppColors.colorPrimary,
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    size: 64,
                    color: AppColors.colorPrimary,
                  ),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundImage: imageProvider,
                  ),
                )
              : AppWidget.circleAvatar(64.0, 64.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("welcome".tr()),
                      SizedBox(width: 8),
                      Image.asset(
                        ImageAssets.hiImage,
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                  Text(
                    user.firstName,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          AppWidget.mySvg(
              ImageAssets.notificationIcon, AppColors.black, 24, 24),
        ],
      ),
    );
  }
}
