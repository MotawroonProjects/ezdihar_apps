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
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rate_my_app/rate_my_app.dart';

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
   PackageInfo? packageInfo ;

  bool should=false;

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
                  print("ddkkdkdk${state.userModel.user.userType}");
                  if (state.userModel.user.userType.contains('freelancer')) {
                    print("ddkkdkdk${state.userModel.user.userType}");

                    return buildListView(13);
                  } else {
                    return buildListView(8);
                  }
                } else {
                  return buildListView(7);
                }
              }
              else if (state is OnSettingModelGet) {
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
            index: count == 13 ? index : (index >= 1 ? index + 5 : index),
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
      Navigator.of(context).pushNamed(AppConstant.pageAddPostRoute,
          );
    }

    else if (index == 2) {
      Navigator.of(context).pushNamed(AppConstant.pageInvestorSignUpRoleRoute,
          arguments: context.read<SettingCubit>().model.user);
    }
    else if (index == 3) {
      Navigator.of(context).pushNamed(AppConstant.pageUserProfileRoute);

    } else if (index == 4) {
      Navigator.pushNamed(context, AppConstant.pageControlServicesRoute);

    } else if (index == 5) {
      Navigator.of(context).pushNamed(AppConstant.pageWalletRoute);

    } else if (index == 6) {
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

    } else if (index == 7) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return MoreInfoScreen(
          Kind: "privacy",
          text: lang == 'ar'
              ? settingModel!.data!.privacyAr!
              : settingModel!.data!.privacyEn!,
        );
      }));

    } else if (index == 8) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return MoreInfoScreen(
          Kind: "aboutUs",
          text: lang == 'ar'
              ? settingModel!.data!.aboutAr!
              : settingModel!.data!.aboutEn!,
        );
      }));

    } else if (index == 9) {
      Navigator.of(context).pushNamed(AppConstant.pageContactUsRoute);

    } else if (index == 10) {
rateApp();
    } else if (index == 11) {
      shareApp();
    }
    else if (index == 12) {
      SettingCubit cubit = BlocProvider.of(context);
      cubit.logout(context);
    }
  }

  void shareApp() async {

    String url = '';
    String packgename=packageInfo!.packageName;

    if (Platform.isAndroid) {

    //  print("Dldlldld${packageInfo.packageName}");
      url = "https://play.google.com/store/apps/details?id=${packgename}";
    } else if (Platform.isIOS) {
      url = 'https://apps.apple.com/us/app/${packgename}';
    }
   await FlutterShare.share(title: "Ezdihar", linkUrl: url);
  }

  Future<void> rateApp() async {

    RateMyApp rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 0,
      minLaunches: 10,
      remindDays: 0,
      remindLaunches: 10,

    );

   await rateMyApp.init().then((value) async =>
       {if(rateMyApp.shouldOpenDialog) {
      rateMyApp.showRateDialog(

        context,
        title: 'Rate this app',
        message: 'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.',
        rateButton: 'RATE',
        noButton: 'NO THANKS',
        laterButton: 'MAYBE LATER',
      )
    }
    else{
          should=  (await rateMyApp.isNativeReviewDialogSupported)!,
      if(should){
      await rateMyApp.launchNativeReviewDialog()}
      else{
        rateMyApp.launchStore()
      }
   // print("ddkdkkdkdkjfj")
    }});


  }

  @override
  void initState() {
    super.initState();
   setuppackage();
  }

  Future<void> setuppackage() async {
  packageInfo=   await PackageInfo.fromPlatform();

  }
}
