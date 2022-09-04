import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/service_screen/cubit/services_cubit.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/service_screen/widgets/service_widgets.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';

import 'cubit/sub_services_cubit.dart';

class SubServicesPage extends StatefulWidget {
  final CategoryModel categoryModel;
  const SubServicesPage({Key? key, required this.categoryModel}) : super(key: key);

  @override
  State<SubServicesPage> createState() => _SubServicesPageState(categoryModel);
}

class _SubServicesPageState extends State<SubServicesPage> {
  CategoryModel categoryModel;

  _SubServicesPageState(this.categoryModel);
  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
            lang=='ar'?categoryModel.title_ar:categoryModel.title_en,

          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey3,
      body: _buildBodySection(),
    );

  }

  void _onTaped({required CategoryModel model, required int index}) {
    Navigator.pushNamed(context, AppConstant.pageAccountingbySubCategoryConsultantsRoute,arguments: model);
  }

  Future<void> onRefresh() async {
    SubServicesCubit cubit = BlocProvider.of<SubServicesCubit>(context);
    cubit.getData(categoryModel.id);
  }

  _buildBodySection() {
    return BlocProvider(
      create: (context) {
        SubServicesCubit cubit =  SubServicesCubit();
        cubit.getData(categoryModel.id);
        return cubit;
      },
      child: BlocBuilder<SubServicesCubit, SubServicesState>(
        builder: (context, state) {
          if (state is IsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.colorPrimary,
              ),
            );
          } else if (state is OnEror) {

            return Center(child:
            InkWell(
              onTap: onRefresh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppWidget.svg(
                      'reload.svg', AppColors.colorPrimary, 24.0, 24.0),
                  SizedBox(height: 8.0,),
                  Text('reload'.tr(), style: TextStyle(
                      color: AppColors.colorPrimary, fontSize: 15.0),)
                ],
              ),
            )
            );
          } else {
            SubServicesCubit cubit = BlocProvider.of<SubServicesCubit>(context);

            List<CategoryModel> list = cubit.list;
            return list.length > 0
                ? RefreshIndicator(
              color: AppColors.colorPrimary,
              onRefresh: onRefresh,
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: list.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: 1 / 1.27),
                  itemBuilder: (context, index) {
                    CategoryModel model = list[index];
                    return InkWell(
                        onTap: () => _onTaped(model: model, index: index),
                        child: ServiceWidgets().buildListItem(
                            context: context,
                            model: model,
                            index: index));
                  }),
            )
                : Center(
              child: Text(
                'no_services'.tr(),
                style: TextStyle(color: AppColors.black, fontSize: 15.0),
              ),
            );
          }
        },
      ),
    );

  }
}
