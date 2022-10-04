import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../colors/colors.dart';
import '../cubit/orders_cubit.dart';
import 'ItemsOrder.dart';

class CurrentOrdersWidget extends StatelessWidget {
  const CurrentOrdersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<OrdersCubit>().getLan(context);
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersTabChanged) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrdersCubit>().getProviderAcceptOrder();
            },
            child: context.read<OrdersCubit>().mainAcceptOrders != null
                ? SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            ...List.generate(
                              context
                                  .read<OrdersCubit>()
                                  .mainAcceptOrders!
                                  .orders
                                  .length,
                              (index) => ItemsOrders(
                                mainOrdersModel: context
                                    .read<OrdersCubit>()
                                    .mainAcceptOrders!
                                    .orders[index],
                              ),
                            ),
                          ],
                        ),
                        Container(height: 800)
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: AppColors.colorPrimary,
                      ),
                    ),
                  ),
          );
        } else if (state is OrdersLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrdersCubit>().getProviderAcceptOrder();
            },
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      ...List.generate(
                        context.read<OrdersCubit>().mainAcceptOrders!.orders.length,
                        (index) => ItemsOrders(
                          mainOrdersModel: context
                              .read<OrdersCubit>()
                              .mainAcceptOrders!
                              .orders[index],
                        ),
                      ),
                    ],
                  ),
                  Container(height: 800)
                ],
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
