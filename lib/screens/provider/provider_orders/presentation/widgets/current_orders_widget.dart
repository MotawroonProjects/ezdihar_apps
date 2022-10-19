import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../colors/colors.dart';
import '../../../../../models/provider_order.dart';
import '../../../../../widgets/app_widgets.dart';
import '../cubit/orders_cubit.dart';
import 'ItemsOrder.dart';

class CurrentOrdersWidget extends StatelessWidget {
  const CurrentOrdersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<OrdersCubit>().getLan(context);
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersTabChanged||state is OrdersLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrdersCubit>().getProviderAcceptOrder();
            },
            child: context.read<OrdersCubit>().mainAcceptOrders != null&&context.read<OrdersCubit>().mainAcceptOrders!.orders.length>0
                ?
            Expanded(
              child: ListView.builder(
                  itemCount: context.read<OrdersCubit>().mainAcceptOrders!.orders.length,
                  itemBuilder: (context, index) {
                    ProviderOrder model =context.read<OrdersCubit>().mainAcceptOrders!.orders[index];
                    return InkWell(
                        onTap: (){
                          Navigator.pop(context,model);
                        },
                        child:
                           ItemsOrders().buildListItem(
                              context: context, model: model, index: index),


                    );
                  }),
            )  :
            Center(
                    child:   InkWell(
                onTap: (){
                  context.read<OrdersCubit>().getProviderAcceptOrder();
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
