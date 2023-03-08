import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/provider_order.dart';
import 'package:ezdihar_apps/screens/provider/provider_orders/presentation/widgets/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../colors/colors.dart';
import '../../../../../constants/app_constant.dart';
import '../../../../../remote/notificationlisten.dart';
import '../../../../../widgets/app_widgets.dart';
import '../cubit/orders_cubit.dart';
import 'ItemsOrder.dart';

class CompletedOrdersWidget extends StatefulWidget {
  const CompletedOrdersWidget({Key? key}) : super(key: key);

  @override
  State<CompletedOrdersWidget> createState() => _CompletedOrdersWidgetState();
}

class _CompletedOrdersWidgetState extends State<CompletedOrdersWidget> {
  late Stream<LocalNotification> _notificationsStream;

  @override
  Widget build(BuildContext context) {
    context.read<OrdersCubit>().getLan(context);
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersTabChanged || state is OrdersLoaded) {
          print("ddddddd");
          print(context.read<OrdersCubit>().mainCompletedOrders!.orders.length);
          return context.read<OrdersCubit>().mainCompletedOrders != null &&
                  context
                          .read<OrdersCubit>()
                          .mainCompletedOrders!
                          .orders
                          .length >
                      0
              ? RefreshIndicator(
                  onRefresh: () async {
                    context.read<OrdersCubit>().getProviderCompletedOrder();
                  },
                  child: ListView.builder(
                    itemCount: context
                        .read<OrdersCubit>()
                        .mainCompletedOrders!
                        .orders
                        .length,
                    itemBuilder: (context, index) {
                      ProviderOrder model = context
                          .read<OrdersCubit>()
                          .mainCompletedOrders!
                          .orders[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppConstant.OrdersDetialsScreenRoute,
                            arguments: model,
                          );
                        },
                        child: ItemsOrders().buildListItem(
                            context: context, model: model, index: index),
                      );
                    },
                  ))
              : Center(
                  child: InkWell(
                    onTap: () {
                      context.read<OrdersCubit>().getProviderCompletedOrder();
                    },
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppWidget.svg(
                            'reload.svg',
                            AppColors.colorPrimary,
                            24.0,
                            24.0,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'no_orders'.tr(),
                            style: TextStyle(
                              color: AppColors.colorPrimary,
                              fontSize: 15.0,
                            ),
                          )
                        ],
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

  @override
  void initState() {
    super.initState();
    _notificationsStream = NotificationsBloc.instance.notificationsStream;

    _notificationsStream.listen((event) {
      // print("Flflf}");
      if (!event.data.keys.contains("chat")) {
        context.read<OrdersCubit>().getProviderCompletedOrder();
      }
    });
  }
}
