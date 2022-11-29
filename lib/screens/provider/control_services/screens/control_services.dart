import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/control_services_cubit.dart';
import '../widgets/choose_services_widget.dart';

class ControlServices extends StatelessWidget {
  const ControlServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'control_services'.tr(),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<ControlServicesCubit, ControlServicesState>(
        builder: (context, state) {
          if (state is ControlServicesLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.colorPrimary),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: context
                                .read<ControlServicesCubit>()
                                .model
                                .main_category!
                                .image!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                              color: AppColors.colorPrimary,
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              size: 30,
                              color: AppColors.colorPrimary,
                            ),
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              backgroundImage: imageProvider,
                            ),
                          ),
                          SizedBox(width: 25),
                          Text(lang=='ar'?
                            context
                                .read<ControlServicesCubit>()
                                .model
                                .main_category!
                                .title_ar!:context
                              .read<ControlServicesCubit>()
                              .model
                              .main_category!
                              .title_en!,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  ...List.generate(
                    context
                        .read<ControlServicesCubit>()
                        .categoryDataModel
                        .data
                        .length,
                    (index) => ChooseServiceWidget(
                      categoryModel: context
                          .read<ControlServicesCubit>()
                          .categoryDataModel
                          .data[index],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
