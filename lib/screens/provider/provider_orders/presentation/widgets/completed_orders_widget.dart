import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/provider_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../colors/colors.dart';
import '../../../../../constants/app_constant.dart';
import '../../../../../widgets/app_widgets.dart';
import '../cubit/orders_cubit.dart';
import 'ItemsOrder.dart';

class CompletedOrdersWidget extends StatelessWidget {
  const CompletedOrdersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<OrdersCubit>().getLan(context);
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersTabChanged||state is OrdersLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrdersCubit>().getProviderCompletedOrder();
            },
            child:

            context.read<OrdersCubit>().mainCompletedOrders != null&&context.read<OrdersCubit>().mainCompletedOrders!.orders.length>0
                ?
            Expanded(
              child: ListView.builder(
                  itemCount: context.read<OrdersCubit>().mainCompletedOrders!.orders.length,
                  itemBuilder: (context, index) {
                    ProviderOrder model =context.read<OrdersCubit>().mainCompletedOrders!.orders[index];
                    return InkWell(
                      onTap: (){
                        Navigator.pushNamed(

                            context,AppConstant.OrdersDetialsScreenRoute,
                            arguments: model);                      },
                      child: ItemsOrders().buildListItem(
                          context: context, model: model, index: index),



                    );
                  }),
            )                :
            Center(
              child:   InkWell(
                onTap: (){
                  context.read<OrdersCubit>().getProviderCompletedOrder();
                },
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
              ),
            ),
          );
        }
        // else if (state is OrdersLoaded) {
        //   return RefreshIndicator(
        //     onRefresh: () async {
        //       context.read<OrdersCubit>().getProviderCompletedOrder();
        //     },
        //     child: SingleChildScrollView(
        //       child: Stack(
        //         children: [
        //           Column(
        //             children: [
        //               ...List.generate(
        //                 context
        //                     .read<OrdersCubit>()
        //                     .mainCompletedOrders!
        //                     .orders
        //                     .length,
        //                 (index) => ItemsOrders(
        //                   mainOrdersModel: context
        //                       .read<OrdersCubit>()
        //                       .mainCompletedOrders!
        //                       .orders[index],
        //                 ),
        //               ),
        //             ],
        //           ),
        //           Container(height: 800,)
        //         ],
        //       ),
        //     ),
        //   );
        // }
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              color: AppColors.colorPrimary,
            ),
          ),
        );
      },
    );
  }
}
