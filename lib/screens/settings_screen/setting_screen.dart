import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/screens/settings_screen/widgets/setting_screen_widgets.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'setting'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      body: Container(
        color: AppColors.grey2,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: List.generate(8, (index) {
            return SettingWidgets().buildListItem(
                context: context, index: index, onTaped: _onTaped);
          }),
        ),
      ),
    );
  }

  void _onTaped({required int index}) {
    if (index == 0) {
      Preferences().getAppSetting().then((value) {
        String lang = EasyLocalization.of(context)!.locale.languageCode;

        value.lang = lang == 'ar' ? 'en' : 'ar';
        Preferences().setAppSetting(value);
        lang == 'ar'
            ? EasyLocalization.of(context)!.setLocale(const Locale('en'))
            : EasyLocalization.of(context)!.setLocale(const Locale('ar'));
        Navigator.of(context).pop();
      });
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {
    } else if (index == 4) {
      Navigator.of(context).pushNamed(AppConstant.pageContactUsRoute);
    } else if (index == 5) {
    } else if (index == 6) {
      shareApp();
    } else if (index == 7) {}
  }

  void shareApp() async {
    String url ='';

    if(Platform.isAndroid){
      url ='https://play.google.com/store/apps/details?id=';
    }else if(Platform.isIOS){
      url ='https://apps.apple.com/us/app/';

    }
    FlutterShare.share(title: "Ezdihar",linkUrl: url);

  }
}
