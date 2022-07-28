import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/consultant_type_model.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/consulting_screen/cubit/consulting_cubit.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/consulting_screen/widgets/consulting_widgets.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';

class ConsultingPage extends StatefulWidget {
  const ConsultingPage({Key? key}) : super(key: key);

  @override
  State<ConsultingPage> createState() => _ConsultingPageState();
}

class _ConsultingPageState extends State<ConsultingPage> {
  @override
  Widget build(BuildContext context) {
    ConsultingCubit cubit = BlocProvider.of<ConsultingCubit>(context);

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ConsultingCubit, ConsultingState>(
        builder: (context, state) {
          if (state is IsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.colorPrimary,
              ),
            );
          }else if(state is OnError){
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
            List<ConsultantTypeModel> list = cubit.list;
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
                          ConsultantTypeModel model = list[index];
                          return InkWell(
                              onTap: () => _onTaped(model: model, index: index),
                              child: ConsultingWidgets().buildListItem(
                                  context: context,
                                  model: model,
                                  index: index));
                        }),
                  )
                : Center(
                    child: Text(
                      'no_consultants'.tr(),
                      style: TextStyle(color: AppColors.black, fontSize: 15.0),
                    ),
                  );
          }
        },
      ),
    );
  }

  void _onTaped({required ConsultantTypeModel model, required int index}) {
    Navigator.pushNamed(context, AppConstant.pageAccountingConsultantsRoute,arguments: model);
  }

  Future<void> onRefresh() async {
    ConsultingCubit cubit = BlocProvider.of<ConsultingCubit>(context);
    cubit.getData();
  }
}
