import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/more_screen/cubit/more_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreWidgets {
  Widget buildAvatar(BuildContext context) {
    MoreCubit cubit = BlocProvider.of(context);

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<MoreCubit, MoreState>(
        builder: (context, state) {
          if (state is OnUserModelGet) {
            UserModel userModel = state.userModel;
            return SizedBox(
              width: 96.0,
              height: 96.0,
              child: userModel.user.isLoggedIn
                  ? CachedNetworkImage(
                      imageUrl: userModel.user.image,
                      placeholder: (context, url) =>
                          AppWidget.circleAvatar(96.0, 96.0),
                      errorWidget: (context, url, error) =>
                          AppWidget.circleAvatar(96.0, 96.0),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                    )
                  : AppWidget.circleAvatar(96.0, 96.0),
            );
          } else {
            return SizedBox(
                width: 96.0,
                height: 96.0,
                child: AppWidget.circleAvatar(96.0, 96.0));
          }
        },
      ),
    );
  }

  Widget buildCard(
      {required BuildContext context,
      required String svgName,
      required String title,
      required String action,
      required Function onTaped}) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return SizedBox(
      height: 72.0,
      child: InkWell(
        onTap: () => onTaped(action: action),
        child: Card(
          elevation: 1.0,
          color: AppColors.grey3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppWidget.svg(svgName, AppColors.colorPrimary, 24.0, 24.0),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          color: AppColors.color3, fontSize: 16.0),
                    )
                  ],
                ),
                Container(
                  width: 24.0,
                  height: 24.0,
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Transform.rotate(
                      angle: lang == 'ar'
                          ? (180 * (3.14 / 180))
                          : (0 * (3.14 / 180)),
                      alignment: Alignment.center,
                      child: AppWidget.svg(
                          'arrow.svg', AppColors.black, 20.0, 20.0)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNameSection(Function onTapped,BuildContext context) {
    MoreCubit cubit = BlocProvider.of(context);

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 16.0),
      child: BlocProvider.value(
        value: cubit,
        child: BlocBuilder<MoreCubit, MoreState>(
          builder: (context, state) {
            if (state is OnUserModelGet) {
              UserModel userModel = state.userModel;

              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: !userModel.user.isLoggedIn
                        ? () {
                            onTapped();
                          }
                        : null,
                    child: Text(
                      userModel.user.isLoggedIn
                          ? '${userModel.user.firstName + " " + userModel.user.lastName}'
                          : 'login'.tr(),
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  userModel.user.isLoggedIn
                      ? Container(
                          width: 28.0,
                          height: 28.0,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: AppColors.color1,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: AppWidget.svg(
                              'edit.svg', AppColors.white, 20.0, 20.0),
                        )
                      : SizedBox()
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget buildSocialSection(
      {required BuildContext context, required Function onTaped}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'followUs'.tr(),
            style: const TextStyle(
                color: AppColors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () => onTaped(url: 'httpsssdf://www.facebook.com'),
                  child: Image.asset(
                    '${AppConstant.localImagePath}facebook.png',
                    width: 40.0,
                    height: 40.0,
                  )),
              const SizedBox(
                width: 16.0,
              ),
              InkWell(
                  onTap: () => onTaped(url: 'https://www.instagram.com'),
                  child: Image.asset(
                    '${AppConstant.localImagePath}instagram.png',
                    width: 40.0,
                    height: 40.0,
                  )),
              const SizedBox(
                width: 16.0,
              ),
              InkWell(
                  onTap: () => onTaped(url: 'https://www.twitter.com'),
                  child: Image.asset(
                    '${AppConstant.localImagePath}twitter.png',
                    width: 40.0,
                    height: 40.0,
                  )),
              const SizedBox(
                width: 16.0,
              ),
              InkWell(
                  onTap: () => onTaped(url: 'https://www.snapchat.com'),
                  child: Image.asset(
                    '${AppConstant.localImagePath}snapchat.png',
                    width: 40.0,
                    height: 40.0,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
