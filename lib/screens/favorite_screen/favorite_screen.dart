import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/project_model.dart';
import 'package:ezdihar_apps/routes/app_routes.dart';
import 'package:ezdihar_apps/screens/favorite_screen/cubit/favorite_cubit.dart';
import 'package:ezdihar_apps/screens/favorite_screen/widgets/favorite_page_widgets.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'love'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey3,
      body: Container(child: _buildListView(),),
    );
  }

  Widget _buildListView() {
    FavoriteCubit cubit = BlocProvider.of<FavoriteCubit>(context);
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return BlocListener<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if(state is OnRemoveFavorite){
          AppRoutes.mainPageCubit.getData();
        }
      },
      child: BlocProvider.value(
        value: cubit,
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (state is IsLoadingData) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.colorPrimary,
                ),
              );
            } else if (state is OnError) {
              return Center(
                child: InkWell(
                  onTap: refreshData,
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
                ),
              );
            } else {
              List<ProjectModel> list = cubit.projects;

              if (list.length > 0) {
                return RefreshIndicator(
                  color: AppColors.colorPrimary,
                  onRefresh: refreshData,
                  child: ListView.builder(
                      itemCount: list.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        ProjectModel model = list[index];
                        return FavoritePageWidgets().buildProjectRow(
                            context,
                            model,
                            index,
                            addRemoveFavorite);
                      }),
                );
              } else {
                return Center(
                  child: Text(
                    'no_projects'.tr(),
                    style: TextStyle(color: AppColors.black, fontSize: 15.0),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Future<void> refreshData() async {
    FavoriteCubit cubit = BlocProvider.of<FavoriteCubit>(context);
    cubit.getData();
  }

  void addRemoveFavorite(int index, ProjectModel model) {
    FavoriteCubit cubit = BlocProvider.of<FavoriteCubit>(context);
    cubit.love_report_follow(index, model, AppConstant.actionLove);
  }
}
