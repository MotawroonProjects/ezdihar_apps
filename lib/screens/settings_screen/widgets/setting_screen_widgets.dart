import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

class SettingWidgets {
  Widget buildListItem(
      {required BuildContext context,
      required int index,
      required Function onTaped}) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    lang = lang == 'ar' ? 'English' : 'العربية';
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        ListTile(
          leading: _buildIcon(index: index),
          title: _buildTextTitle(index: index),
          trailing: Text(
            index == 0 ? lang : '',
            style: const TextStyle(fontSize: 16.0, color: AppColors.black),
          ),
          onTap: () => onTaped(index: index),
        ),
        const SizedBox(
          height: 8.0,
        ),
        AppWidget.buildDashHorizontalLine(context: context)
      ],
    );
  }

  Widget _buildTextTitle({required int index}) {
    var title = '';
    var color = AppColors.black;

    switch (index) {
      case 0:
        title = 'changeLanguage'.tr();
        break;
      case 1:
        title = 'serviceRequest'.tr();
        break;
      case 2:
        title = 'edit_profile'.tr();
        break;
      case 3:
        title = 'control_services'.tr();
        break;
      case 4:
        title = 'wallet'.tr();
        break;
      case 5:
        title = 'terms'.tr();
        break;
      case 6:
        title = 'privacy'.tr();
        break;
      case 7:
        title = 'aboutUs'.tr();
        break;
      case 8:
        title = 'contactUs'.tr();
        break;
      case 9:
        title = 'rateApp'.tr();
        break;
      case 10:
        title = 'shareApp'.tr();
        break;
      case 11:
        color = AppColors.red;
        title = 'logout'.tr();
        break;
    }

    return Text(
      title,
      style: TextStyle(color: color, fontSize: 16.0),
    );
  }

  Widget _buildIcon({required int index}) {
    var iconName = '';
    var color = AppColors.black;
    switch (index) {
      case 0:
        iconName = 'lang.svg';
        break;
      case 1:
        iconName = 'service_request.svg';
        break;
      case 2:
        iconName = 'edit_profile.svg';
        break;
      case 3:
        iconName = 'control_service.svg';
        break;
      case 4:
        color=AppColors.black;
        iconName = 'wallet2.svg';
        break;

      case 5:
        iconName = 'terms.svg';
        break;
      case 6:
        iconName = 'privacy.svg';
        break;
      case 7:
        iconName = 'info.svg';
        break;
      case 8:
        iconName = 'contact_us.svg';
        break;
      case 9:
        iconName = 'rate.svg';
        break;
      case 10:
        iconName = 'share.svg';
        break;
      case 11:
        color = AppColors.red;
        iconName = 'logout.svg';
        break;
    }
    return AppWidget.svg(iconName, color, 24.0, 24.0);
  }
}
