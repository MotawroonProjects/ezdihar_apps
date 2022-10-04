import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/screens/user/add_screen/navigation_screens/feasibility_screen/cubit/feasibility_cubit.dart';
import 'package:ezdihar_apps/screens/user/add_screen/navigation_screens/feasibility_screen/widgets/feasibility_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeasibilityPage extends StatefulWidget {
  const FeasibilityPage({Key? key}) : super(key: key);

  @override
  State<FeasibilityPage> createState() => _FeasibilityPageState();
}

class _FeasibilityPageState extends State<FeasibilityPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FeasibilityCubit cubit = BlocProvider.of<FeasibilityCubit>(context);
    return Container(
      color: AppColors.grey3,
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.colorPrimary,
        child: BlocBuilder<FeasibilityCubit, FeasibilityState>(
          builder: (context, state) {
            List<CategoryModel> categories = cubit.categories;
            if (state is IsCategoryLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.colorPrimary,
                ),
              );
            } else if (state is OnCategoryDataSuccess) {
              if (categories.length > 0) {
                return GridView.builder(
                  itemCount: categories.length,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    CategoryModel model = categories[index];
                    return const FeasibilityScreenWidgets().buildListItem(
                        context: context,
                        model: model,
                        index: index,
                        onTaped: _onTaped);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                );
              } else {
                return Center(
                  child: Text(
                    'no_departments'.tr(),
                    style: TextStyle(color: AppColors.black, fontSize: 15.0),
                  ),
                );
              }
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }

  void _onTaped({required CategoryModel model, required int index}) {
    Navigator.pushNamed(context, AppConstant.pageSendGeneralStudyRoute,
        arguments: model);
  }

  Future<void> _onRefresh() async {
    FeasibilityCubit cubit = BlocProvider.of<FeasibilityCubit>(context);
    cubit.getCategories();
  }
}
