import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/consultant_type_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/screens/accounting_consulting_by_subCategory_screen/cubit/consultants_cubit.dart';
import 'package:ezdihar_apps/screens/accounting_consulting_by_subCategory_screen/widget/accounting_consultants_widgets.dart';

import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/user_data_model.dart';


class AccountingConsultantsBySubCategoryPage extends StatefulWidget {
  final CategoryModel categoryModel;

  const AccountingConsultantsBySubCategoryPage({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  State<AccountingConsultantsBySubCategoryPage> createState() =>
      _AccountingConsultantsBySubCategoryPageState(categoryModel: categoryModel);
}

class _AccountingConsultantsBySubCategoryPageState extends State<AccountingConsultantsBySubCategoryPage> {
  CategoryModel categoryModel;

  _AccountingConsultantsBySubCategoryPageState({required this.categoryModel});


  @override
  Widget build(BuildContext context) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          lang == 'ar'
              ? categoryModel.title_ar
              : categoryModel.title_en,
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

  Widget _buildBodySection() {
    return BlocProvider(
      create: (context) {
        ConsultantsCubit cubit =  ConsultantsCubit();
        cubit.getData(categoryModel.id);
        return cubit;
      },
      child: BlocBuilder<ConsultantsCubit, ConsultantsState>(
        builder: (context, state) {
          if (state is IsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.colorPrimary,
              ),
            );
          }
          else if (state is OnError) {
            return Center(
                child: InkWell(
              onTap:()=>onRefresh(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppWidget.svg(
                      'reload.svg', AppColors.colorPrimary, 24.0, 24.0),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'reload'.tr(),
                    style: TextStyle(
                        color: AppColors.colorPrimary, fontSize: 15.0),
                  )
                ],
              ),
            ));
          }
          else {
            ConsultantsCubit cubit = BlocProvider.of<ConsultantsCubit>(context);

            List<UserModel> list = cubit.data;
            if (list.length > 0) {
              return ListView.builder(
                  itemCount: list.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: ((context, index) {
                    UserModel model = list[index];
                    return InkWell(
                      onTap: () => _onTaped(userModel: model, index: index),
                      child: AccountingConsultantsWidgets().buildListItem(
                          context: context, model: model, index: index),
                    );
                  }));
            } else {
              return Center(
                  child: Text(
                'no_consultants'.tr(),
                style: TextStyle(color: AppColors.black, fontSize: 15.0),
              ));
            }
          }
        },
      ),
    );
  }

  void _onTaped({required UserModel userModel, required int index}) {
    Navigator.pushNamed(context, AppConstant.pageProviderDetailsRoute,arguments:  userModel);
  }

  Future<void> onRefresh(BuildContext context) async {
    ConsultantsCubit cubit = BlocProvider.of<ConsultantsCubit>(context);
    cubit.getData(categoryModel.id);
  }
}
