import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/models/project_model.dart';
import 'package:ezdihar_apps/screens/favorite_screen/cubit/favorite_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePageWidgets{
  Widget buildProjectRow(
      BuildContext context,
      ProjectModel model,
      int index,
      Function favourite) {
    FavoriteCubit cubit = BlocProvider.of<FavoriteCubit>(context);

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
                          favourite(index,model);
                        },
                        child: SizedBox(
                          child: AppWidget.svg(
                              'love.svg',
                              AppColors.colorPrimary,
                              24.0,
                              24.0),
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
              const SizedBox(
                height: 8.0,
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
}