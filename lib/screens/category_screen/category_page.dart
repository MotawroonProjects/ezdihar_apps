import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/screens/category_screen/cubit/category_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'category'.tr(),
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
        leading: AppWidget.buildBackArrow(context: context),
      ),
      backgroundColor: AppColors.grey2,
      body: buildBodySection(),
    );
  }

  buildBodySection() {
    CategoryCubit cubit = BlocProvider.of<CategoryCubit>(context);

    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is IsLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.colorPrimary,
            ),
          );
        }
        else if (state is OnDataSuccess) {
          return Column(
            children: [ buildListSection()],
          );
        } else {
          OnError error = state as OnError;
          return InkWell(
            onTap: (){cubit.getCategory();},
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppWidget.svg('reload.svg', AppColors.colorPrimary, 24.0, 24.0),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'reload'.tr(),
                    style:
                        TextStyle(color: AppColors.colorPrimary, fontSize: 15.0),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }


  buildListSection() {

    CategoryCubit cubit = BlocProvider.of<CategoryCubit>(context);
    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return Expanded(
      child: ListView.builder(
          itemCount: cubit.list.length,
          itemBuilder: (context, index) {
            CategoryModel model =cubit.list[index];
            return InkWell(
              onTap: (){
                Navigator.pop(context,model);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 1),
                color:AppColors.white,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lang=='ar'?model.title_ar:model.title_en,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: AppColors.black,fontSize: 15.0),),
                    Transform.rotate(child: AppWidget.svg('arrow.svg', AppColors.black, 24.0, 24.0), angle: lang=='ar'?3.14:0,)
                  ],
                )
              ),
            );
          }),
    );
  }
}
