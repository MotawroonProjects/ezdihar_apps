import 'package:ezdihar_apps/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/orders_cubit.dart';
import 'ItemsOrder.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<OrdersCubit>().getLan(context);
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersTabChanged) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrdersCubit>().getProviderNewOrder();
            },
            child: context.read<OrdersCubit>().mainNewOrders != null
                ? SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            ...List.generate(
                              context
                                  .read<OrdersCubit>()
                                  .mainNewOrders!
                                  .orders
                                  .length,
                              (index) => ItemsOrders(
                                mainOrdersModel: context
                                    .read<OrdersCubit>()
                                    .mainNewOrders!
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
              context.read<OrdersCubit>().getProviderNewOrder();
            },
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      ...List.generate(
                        context.read<OrdersCubit>().mainNewOrders!.orders.length,
                        (index) => ItemsOrders(
                          mainOrdersModel: context
                              .read<OrdersCubit>()
                              .mainNewOrders!
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
