import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/login_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/routes/app_routes.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/more_screen/cubit/more_cubit.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/more_screen/more_widgets/more_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => MoreCubit(),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 173,
            child: Stack(
              children: [
                Positioned(
                    child: Container(
                  width: width,
                  height: 125.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              '${AppConstant.localImagePath}top_profile.png'),
                          fit: BoxFit.fill)),
                )),
                Positioned(
                  top: 77.0,
                  left: width / 2 - 48,
                  child: MoreWidgets().buildAvatar(context,_onTaped),
                ),
              ],
            ),
          ),
          MoreWidgets().buildNameSection(_onTaped, context),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Card(
              color: AppColors.white,
              elevation: 1.0,
              margin: const EdgeInsets.all(1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MoreWidgets().buildCard(
                        context: context,
                        svgName: 'profile.svg',
                        title: 'myProfile'.tr(),
                        action: 'myProfile',
                        onTaped: _onTaped),

                    const SizedBox(
                      height: 8.0,
                    ),
                    MoreWidgets().buildCard(
                        context: context,
                        svgName: 'wallet.svg',
                        title: 'wallet'.tr(),
                        action: 'wallet',
                        onTaped: _onTaped),
                    const SizedBox(
                      height: 8.0,
                    ),
                    MoreWidgets().buildCard(
                        context: context,
                        svgName: 'setting.svg',
                        title: 'setting'.tr(),
                        action: 'setting',
                        onTaped: _onTaped)
                  ],
                ),
              ),
            ),
          ),
          MoreWidgets()
              .buildSocialSection(context: context, onTaped: _openSocialUrl),
          SizedBox(
            height: 56,
          )
        ],
      ),
    );
  }

  void _openSocialUrl({required String url}) async {
    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,
          webViewConfiguration: const WebViewConfiguration(
              enableJavaScript: true, enableDomStorage: true));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'invalidUrl'.tr(),
          style: const TextStyle(fontSize: 18.0),
        ),
        backgroundColor: AppColors.colorPrimary,
        elevation: 8.0,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  void _onTaped({required action}) {
    switch (action) {
      case 'edit':
        navigateToUserSignUpActivity();
        break;
      case 'myProfile':
        Preferences.instance.getUserModel().then((value) {
          if (!value.user.isLoggedIn) {
            navigateToLoginActivity();
          } else {
            navigateToMyProfile();
          }
        });

        break;
      case 'wallet':
        Preferences.instance.getUserModel().then((value) {
          if (!value.user.isLoggedIn) {
            navigateToLoginActivity();
          } else {
            Navigator.of(context).pushNamed(AppConstant.pageWalletRoute);
          }
        });

        break;
      case 'setting':
        navigateToSettingActivity();
        break;

      case 'login':
        navigateToLoginActivity();
        break;
    }
  }

  void navigateToLoginActivity() async {
    var result =
        await Navigator.of(context).pushNamed(AppConstant.pageLoginRoute);
    if (result != null) {
      MoreCubit cubit = BlocProvider.of<MoreCubit>(context);
      cubit.getUserModel();
      AppRoutes.mainPageCubit.getData();
      AppRoutes.homePageCubit.updateFirebaseToken();
    }
  }

  void navigateToSettingActivity() async {
    var result =
        await Navigator.of(context).pushNamed(AppConstant.pageSettingRoute);
    if (result != null) {
      await Preferences.instance.clearUserData();
      AppRoutes.mainPageCubit.getData();
      MoreCubit cubit = BlocProvider.of<MoreCubit>(context);
      cubit.getUserModel();

    }
  }

  void navigateToUserSignUpActivity() async {
    UserModel model = await Preferences.instance.getUserModel();
    LoginModel loginModel = LoginModel();
    loginModel.phone_code = model.user.phoneCode;
    loginModel.phone = model.user.phone;

    var result = await Navigator.of(context).pushNamed(AppConstant.pageUserSignUpRoleRoute,arguments: loginModel);
    if (result != null) {
      MoreCubit cubit = BlocProvider.of<MoreCubit>(context);
      cubit.getUserModel();

    }
  }

  void navigateToMyProfile() async {
    var result =
    await Navigator.of(context).pushNamed(AppConstant.pageUserProfileRoute);
    if (result != null) {

    }
  }
}
