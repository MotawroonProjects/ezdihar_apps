import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/screens/settings_screen/cubit/setting_cubit.dart';
import 'package:ezdihar_apps/screens/settings_screen/widgets/setting_screen_widgets.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../models/setting_model.dart';
import '../provider/navigation_bottom/cubit/navigator_bottom_cubit.dart';
import '../user/privacy_about _us_terms_screen/more_info_screen.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SettingModel? settingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'setting'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: context.read<NavigatorBottomCubit>().page == 2
            ? AppWidget.buildBackArrow(context: context)
            : SizedBox(),
      ),
      body: BlocListener<SettingCubit, SettingState>(
        listener: (context, state) {
          if (state is OnLogOutSuccess) {
            Navigator.of(context)
                .pushReplacementNamed(AppConstant.pageLoginRoute);
          }
        },
        child: Container(
          color: AppColors.grey2,
          child: BlocConsumer<SettingCubit, SettingState>(
            listener: (context, state) {
              if (state is OnSettingModelGet) {
                context.read<SettingCubit>().onUserDataSuccess();
                settingModel = state.settingModel;
              }
            },
            builder: (context, state) {
              if (state is OnLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is OnUserModelGet) {
                if (state.userModel.user.isLoggedIn) {
                  if (state.userModel.user.userType == 'freelancer') {
                    return buildListView(12);
                  } else {
                    return buildListView(8);
                  }
                } else {
                  return buildListView(7);
                }
              } else if (state is OnSettingModelGet) {
                return Center(child: CircularProgressIndicator());
              } else {
                return buildListView(7);
              }
            },
          ),
        ),
      ),
    );
  }

  buildListView(int count) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(count, (index) {
        return SettingWidgets().buildListItem(
            context: context,
            index: count == 12 ? index : (index >= 1 ? index + 4 : index),
            onTaped: _onTaped);
      }),
    );
  }

  void _onTaped({required int index}) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    if (index == 0) {
      Preferences().getAppSetting().then(
        (value) {
          value.lang = lang == 'ar' ? 'en' : 'ar';
          Preferences().setAppSetting(value);
          lang == 'ar'
              ? EasyLocalization.of(context)!.setLocale(const Locale('en'))
              : EasyLocalization.of(context)!.setLocale(const Locale('ar'));
        },
      );
      Navigator.pushReplacementNamed(context, AppConstant.pageSplashRoute);
    } else if (index == 1) {
      Navigator.of(context).pushNamed(AppConstant.serviceRequestScreenRoute);
    } else if (index == 2) {
      Navigator.of(context).pushNamed(AppConstant.pageInvestorSignUpRoleRoute,
          arguments: context.read<SettingCubit>().model.user);
    } else if (index == 3) {
      Navigator.pushNamed(context, AppConstant.pageControlServicesRoute);
    } else if (index == 4) {
      Navigator.of(context).pushNamed(AppConstant.pageWalletRoute);
    } else if (index == 5) {
      if (settingModel != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return MoreInfoScreen(
                Kind: "terms",
                text: lang == 'ar'
                    ? settingModel!.data!.termsAr!
                    : settingModel!.data!.termsEn!,
              );
            },
          ),
        );
      }
    } else if (index == 6) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return MoreInfoScreen(
          Kind: "privacy",
          text: lang == 'ar'
              ? settingModel!.data!.privacyAr!
              : settingModel!.data!.privacyEn!,
        );
      }));
    } else if (index == 7) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return MoreInfoScreen(
          Kind: "aboutUs",
          text: lang == 'ar'
              ? settingModel!.data!.aboutAr!
              : settingModel!.data!.aboutEn!,
        );
      }));
    } else if (index == 8) {
      Navigator.of(context).pushNamed(AppConstant.pageContactUsRoute);
    } else if (index == 9) {
    } else if (index == 10) {
      shareApp();
    } else if (index == 11) {
      SettingCubit cubit = BlocProvider.of(context);
      cubit.logout(context);
    }
  }

  void shareApp() async {
    String url = '';

    if (Platform.isAndroid) {
      url = 'https://play.google.com/store/apps/details?id=';
    } else if (Platform.isIOS) {
      url = 'https://apps.apple.com/us/app/';
    }
    FlutterShare.share(title: "Ezdihar", linkUrl: url);
  }
}
