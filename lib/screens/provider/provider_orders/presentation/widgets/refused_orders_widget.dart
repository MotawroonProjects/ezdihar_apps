import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../colors/colors.dart';
import '../cubit/orders_cubit.dart';
import 'ItemsOrder.dart';

class RefusedOrdersWidget extends StatelessWidget {
  const RefusedOrdersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<OrdersCubit>().getLan(context);
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersTabChanged) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrdersCubit>().getProviderRefusedOrder();
            },
            child: context.read<OrdersCubit>().mainRefusedOrders != null
                ? SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            ...List.generate(
                              context
                                  .read<OrdersCubit>()
                                  .mainRefusedOrders!
                                  .orders
                                  .length,
                              (index) => ItemsOrders(
                                mainOrdersModel: context
                                    .read<OrdersCubit>()
                                    .mainRefusedOrders!
                                    .orders[index],
                              ),
                            ),
                          ],
                        ),
                        Container(height: 800,)
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
              context.read<OrdersCubit>().getProviderRefusedOrder();
            },
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      ...List.generate(
                        context
                            .read<OrdersCubit>()
                            .mainRefusedOrders!
                            .orders
                            .length,
                        (index) => ItemsOrders(
                          mainOrdersModel: context
                              .read<OrdersCubit>()
                              .mainRefusedOrders!
                              .orders[index],
                        ),
                      ),
                    ],
                  ),
                  Container(height: 800,)
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
