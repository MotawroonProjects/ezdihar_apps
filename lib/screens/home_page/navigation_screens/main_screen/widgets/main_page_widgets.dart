import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/project_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/main_screen/cubit/main_page_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class MainPageWidgets {
  Widget buildProjectRow(
      BuildContext context,
      ProjectModel model,
      int index,
      Function favourite,
      Function navigateToDetails,
      Function showSheet,
      Animation colorAnimation,
      Animation scaleAnimation,
      AnimationController animationController) {
    MainPageCubit cubit = BlocProvider.of<MainPageCubit>(context);

    String lang = EasyLocalization.of(context)!.locale.languageCode;
    String approved = "";
    if (model.approvedFrom.length > 0) {
      approved = model.approvedFrom
          .map((e) => lang == 'ar' ? "#" + e.title_ar : "#" + e.title_en)
          .join(' ');
    }
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppColors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0))),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: CachedNetworkImage(
                  width: 60,
                    height: 60,
                    imageUrl: model.user.image,
                    placeholder: (context, url) =>
                        AppWidget.circleAvatar(60, 60),
                    errorWidget: (context, url, error) {
                      return Container(
                        color: AppColors.grey3,
                      );
                    },
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundImage: imageProvider,
                          radius: 60,
                        )),
                title: Text(
                  model.user.firstName + " " + model.user.lastName,
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  model.title,
                  style: TextStyle(
                    color: AppColors.grey1,
                    fontSize: 14.0,
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    showSheet(context, model, index);
                  },
                  child: AppWidget.svg(
                      'menu_dots.svg', AppColors.color1, 20.0, 20.0),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              AspectRatio(
                aspectRatio: 1 / .67,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    child: model.image.isNotEmpty
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: model.image,
                          )
                        : Container(
                            color: AppColors.grey3,
                          )),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (cubit.userModel != null &&
                              cubit.userModel!.user.isLoggedIn) {
                            favourite(model, index);
                          } else {
                            cubit.loginFirst();
                          }
                        },
                        child: SizedBox(
                          child: AnimatedBuilder(
                            animation: animationController,
                            builder: (BuildContext context, _) {
                              return AppWidget.svg(
                                  'love.svg',
                                  colorAnimation.value,
                                  scaleAnimation.value,
                                  scaleAnimation.value);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${model.likesCount}",
                        style:
                            TextStyle(fontSize: 14.0, color: AppColors.color1),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                        color: AppColors.grey1,
                        borderRadius: BorderRadius.circular(24.0)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: AppWidget.svg(
                              'donate.svg', AppColors.white, 24.0, 24.0),
                        ),
                        Text(
                          'donate'.tr(),
                          style: const TextStyle(
                              fontSize: 12.0, color: AppColors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: model.text,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: []),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              approved.isNotEmpty
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        approved,
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.colorPrimary, fontSize: 16.0),
                      ))
                  : SizedBox(),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSheet(
      {required BuildContext context,
      required ProjectModel model,
      required index,
      required MainPageCubit cubit,
      required Function onTaped}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
              leading:
                  AppWidget.svg('follow.svg', AppColors.color1, 24.0, 24.0),
              title: Text(
                '${'follow'.tr()} ${model.user.firstName + " " + model.user.lastName}',
                style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'followForUpdate'.tr(),
                style: const TextStyle(color: AppColors.grey1, fontSize: 12.0),
              ),
              onTap: () {
                if(cubit.userModel!.user.isLoggedIn){
                  onTaped(model: model, index: index, action: AppConstant.actionFollow);

                }else{
                  cubit.loginFirst();

                }

              }),
          ListTile(
            leading: AppWidget.svg('save.svg', AppColors.color1, 24.0, 24.0),
            title: Text(
              'save'.tr(),
              style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'saveToItems'.tr(),
              style: const TextStyle(color: AppColors.grey1, fontSize: 12.0),
            ),
              onTap: () {
                if(cubit.userModel!.user.isLoggedIn){
                  onTaped(model: model, index: index, action: AppConstant.actionSave);

                }else{
                  cubit.loginFirst();

                }

              }),
          ListTile(
            leading: AppWidget.svg('report.svg', AppColors.color1, 24.0, 24.0),
            title: Text(
              'report'.tr(),
              style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'reportWithWrong'.tr(),
              style: const TextStyle(color: AppColors.grey1, fontSize: 12.0),
            ),
              onTap: () {
                if(cubit.userModel!.user.isLoggedIn){
                  onTaped(model: model, index: index, action: AppConstant.actionReport);

                }else{
                  cubit.loginFirst();

                }

              }),
        ],
      ),
    );
  }

  Widget buildFilterSheet(
      {required BuildContext context,
      required MainPageCubit cubit,
      required Function onTapped}) {
    MainPageCubit cubit = BlocProvider.of<MainPageCubit>(context);
    String date = cubit.filterDate;
    String category_id = cubit.category_id;

    return BlocProvider.value(
        value: cubit,
        child: BlocBuilder<MainPageCubit, MainPageState>(
          builder: (context, state) {
            if (state is CalenderOnDateSelected) {
              date = DateFormat('dd-MM-yyyy').format(state.selectedDate);
            }
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'filterResult'.tr(),
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppWidget.svg(
                          'category.svg', AppColors.colorPrimary, 24.0, 24.0),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "category".tr(),
                        style:
                            TextStyle(fontSize: 16.0, color: AppColors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    height: 54.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                        color: AppColors.grey7,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: buildDropDown(context),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppWidget.svg(
                          'calender.svg', AppColors.colorPrimary, 24.0, 24.0),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "date".tr(),
                        style:
                            TextStyle(fontSize: 16.0, color: AppColors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  InkWell(
                    onTap: () {
                      onTapped();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      height: 54.0,
                      decoration: BoxDecoration(
                          color: AppColors.grey7,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            date,
                            style: TextStyle(
                                color: AppColors.black, fontSize: 14.0),
                          ),
                          AppWidget.svg(
                              'down_arrow.svg', AppColors.black, 16.0, 8.0)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                                cubit.getData();
                              },
                              height: 56,
                              color: AppColors.colorPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              child: Text(
                                'confirm'.tr(),
                                style: TextStyle(
                                    fontSize: 16.0, color: AppColors.white),
                              ),
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            flex: 1,
                            child: BlocBuilder<MainPageCubit, MainPageState>(
                              builder: (context, state) {
                                String date = cubit.filterDate;
                                category_id = cubit.category_id;

                                return MaterialButton(
                                  onPressed: date != 'all'.tr() ||
                                          category_id != 'all'.tr()
                                      ? () {
                                          Navigator.pop(context);
                                          //cubit.updateFilterDate('');
                                          cubit.clearFilter();
                                        }
                                      : null,
                                  height: 56,
                                  disabledColor: AppColors.grey3,
                                  color: date.isNotEmpty
                                      ? AppColors.grey6
                                      : AppColors.grey3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  child: Text(
                                    'clear'.tr(),
                                    style: TextStyle(
                                        fontSize: 16.0, color: AppColors.white),
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  buildDropDown(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    MainPageCubit cubit = BlocProvider.of<MainPageCubit>(context);
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<MainPageCubit, MainPageState>(
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                child: DropdownButton<CategoryModel>(
                    isExpanded: true,
                    underline: SizedBox(),
                    iconSize: 0,
                    value: cubit.selectedCategoryModel,
                    items: cubit.categories
                        .map((e) => DropdownMenuItem<CategoryModel>(
                            value: e,
                            child: Text(
                              lang == 'ar' ? e.title_ar : e.title_en,
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 14.0),
                            )))
                        .toList(),
                    onChanged: (value) {
                      cubit.updateSelectedCategory(value!);
                    }),
              ),
              AppWidget.svg('down_arrow.svg', AppColors.black, 16.0, 8.0)
            ],
          );
        },
      ),
    );
  }
}
