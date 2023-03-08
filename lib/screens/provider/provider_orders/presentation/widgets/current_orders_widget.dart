import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../colors/colors.dart';
import '../../../../../constants/app_constant.dart';
import '../../../../../models/provider_order.dart';
import '../../../../../remote/notificationlisten.dart';
import '../../../../../widgets/app_widgets.dart';
import '../cubit/orders_cubit.dart';
import 'ItemsOrder.dart';

class CurrentOrdersWidget extends StatefulWidget {
  const CurrentOrdersWidget({Key? key}) : super(key: key);

  @override
  State<CurrentOrdersWidget> createState() => _CurrentOrdersWidgetState();
}

class _CurrentOrdersWidgetState extends State<CurrentOrdersWidget> {
  late Stream<LocalNotification> _notificationsStream;

  @override
  Widget build(BuildContext context) {
    context.read<OrdersCubit>().getLan(context);
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersTabChanged || state is OrdersLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrdersCubit>().getProviderAcceptOrder();
            },
            child: context.read<OrdersCubit>().mainAcceptOrders != null &&
                    context
                            .read<OrdersCubit>()
                            .mainAcceptOrders!
                            .orders
                            .length >
                        0
                ? ListView.builder(
                    itemCount: context
                        .read<OrdersCubit>()
                        .mainAcceptOrders!
                        .orders
                        .length,
                    itemBuilder: (context, index) {
                      ProviderOrder model = context
                          .read<OrdersCubit>()
                          .mainAcceptOrders!
                          .orders[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppConstant.OrdersDetialsScreenRoute,
                              arguments: model);
                        },
                        child: ItemsOrders().buildListItem(
                            context: context, model: model, index: index),
                      );
                    },
                  )
                : Center(
                    child: InkWell(
                      onTap: () {
                        context.read<OrdersCubit>().getProviderAcceptOrder();
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
      if (!event.data.keys.contains("chat")) {
        context.read<OrdersCubit>().getProviderAcceptOrder();
      }
    });
  }
}
