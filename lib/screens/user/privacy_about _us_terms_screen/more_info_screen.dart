import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/screens/user/privacy_about%20_us_terms_screen/widgets/long_text.dart';
import 'package:flutter/material.dart';

import '../../../colors/colors.dart';
import '../../../constants/app_constant.dart';
import '../../../widgets/app_widgets.dart';

// ignore: must_be_immutable
class MoreInfoScreen extends StatelessWidget {
   MoreInfoScreen({Key? key,  this.Kind, required this.text}) : super(key: key);
   final String? Kind;
  final String text ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          Kind!.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.asset(
                      '${AppConstant.localImagePath}logo.png',
                      width: 300,
                      height: 161,
                    ),
                  ),
                ],
              ),
            Kind!="terms"?  RichText(
                text: TextSpan(
                  children:  <TextSpan>[
                    TextSpan(
                      text: 'title'.tr(),
                      style: TextStyle(
                          color: AppColors.colorPrimary, fontWeight: FontWeight.bold,fontSize: 22),
                    ),
                    TextSpan(
                      text: 'help'.tr(),
                      style: TextStyle(color: AppColors.black,fontWeight: FontWeight.bold,fontSize: 22),
                    ),
                  ],
                ),
              ):SizedBox(width: 0,),
              LongText(text: text),
            ],
          ),
        ),
      ),
    );
  }
}
