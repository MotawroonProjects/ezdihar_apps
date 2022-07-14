import 'package:flutter/cupertino.dart';

import '../../../constants/app_constant.dart';

class WalletScreenWidgets{
  Widget buildAvatar({required double width, required double height}) {
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

}