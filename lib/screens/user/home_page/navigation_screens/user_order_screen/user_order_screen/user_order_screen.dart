import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';

import 'package:ezdihar_apps/models/provider_order.dart';

import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../constants/app_constant.dart';
import '../../../../../../remote/notificationlisten.dart';
import '../../../../../new_orders_screen/widget/ItemsOrder.dart';
import '../../../../../provider/provider_orders/presentation/cubit/orders_cubit.dart';
import '../../../../../provider/provider_orders/presentation/widgets/tab_bar_widget.dart';
import 'cubit/user_order_cubit.dart';

class UserOrderPage extends StatefulWidget {
  UserOrderPage({Key? key}) : super(key: key);

  @override
  State<UserOrderPage> createState() => _UserOrderPageState();
}

class _UserOrderPageState extends State<UserOrderPage>
    with SingleTickerProviderStateMixin {
  List<Widget> _tabs = [];
  List<Widget> _screens = [];
  late TabController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.grey3,
        child: body(),
      ),
    );
  }

  body() {
    OrdersCubit cubit = BlocProvider.of(context);
    return BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          int index = cubit.page;
          if (state is OrdersTabChanged) {
            index = state.index;
          }
          return IndexedStack(
            index: index,
            children: _screens,
          );
        },
      );
  }

  buildCurrentOrderList() {
    print('0123456789123456789');
    UserOrderCubit cubit = context.read<UserOrderCubit>();
    return BlocBuilder<UserOrderCubit, UserOrderState>(
      builder: (context, state) {
        if (state is UpdateIndex) {
          if (cubit.mainAcceptOrders != null) {
            List<ProviderOrder> list = cubit.mainAcceptOrders!.orders;
            if (list.length > 0) {
              return CurrentOrderWidget(list);
            } else {
              return Center(
                child: Text(
                  'me 1'.tr(),
                  style: TextStyle(color: AppColors.black, fontSize: 15.0),
                ),
              );
            }
          } else {
            return Center(
              child: Text(
                'me 2'.tr(),
                style: TextStyle(color: AppColors.black, fontSize: 15.0),
              ),
            );
          }
        }
        else if (state is IsLoadingData) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.colorPrimary,
            ),
          );
        }
        else if (state is OnError) {
          return Center(
            child: InkWell(
              onTap: refreshCurrent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppWidget.svg(
                      'reload.svg', AppColors.colorPrimary, 24.0, 24.0),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'reload'.tr(),
                    style: TextStyle(
                        color: AppColors.colorPrimary, fontSize: 15.0),
                  )
                ],
              ),
            ),
          );
        } else {
          List<ProviderOrder> list = cubit.mainAcceptOrders!.orders;
          if (list.length > 0) {
            return CurrentOrderWidget(list);
          } else {
            return Center(
              child: InkWell(
                onTap: () {
                  context.read<UserOrderCubit>().getUserAcceptOrder();
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
        }
      },
    );
  }

  CurrentOrderWidget(List<ProviderOrder> list) {
    return RefreshIndicator(
      onRefresh: refreshCurrent,
      color: AppColors.colorPrimary,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            ProviderOrder model = list[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                        context, AppConstant.OrdersDetialsScreenRoute,
                        arguments: model)
                    .then((value) => {refreshCurrent})
                    .whenComplete(() => {refreshData()});
              },
              child: ItemsOrders()
                  .buildListItem(context: context, model: model, index: index),
            );
          }),
    );
  }

  buildCompleteOrderList() {

    UserOrderCubit cubit = context.read<UserOrderCubit>();

    return BlocBuilder<UserOrderCubit, UserOrderState>(
      builder: (context, state) {
        if (state is UpdateIndex) {
          if (cubit.mainCompletedOrders != null &&
              cubit.mainCompletedOrders!.orders.length > 0) {
            return CompeleteWidget(cubit.mainCompletedOrders!.orders);
          } else {
            return Center(
              child: Text(
                'no_orders'.tr(),
                style: TextStyle(color: AppColors.black, fontSize: 15.0),
              ),
            );
          }
        }
        else if (state is IsLoadingData) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.colorPrimary,
            ),
          );
        }
        else if (state is OnError) {
          return Center(
            child: InkWell(
              onTap: refreshData,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppWidget.svg(
                      'reload.svg', AppColors.colorPrimary, 24.0, 24.0),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'reload'.tr(),
                    style: TextStyle(
                        color: AppColors.colorPrimary, fontSize: 15.0),
                  )
                ],
              ),
            ),
          );
        }
        else {
          List<ProviderOrder> list = cubit.mainCompletedOrders!.orders;

          if (list.length > 0) {
            return CompeleteWidget(list);
          }
          else {
            return Center(
              child: Text(
                'no_orders'.tr(),
                style: TextStyle(color: AppColors.black, fontSize: 15.0),
              ),
            );
          }
        }
      },
    );
  }

  CompeleteWidget(List<ProviderOrder> list) {
    print('====================================78787');

    String lang = EasyLocalization.of(context)!.locale.languageCode;
    return RefreshIndicator(
      color: AppColors.colorPrimary,
      onRefresh: refreshData,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            ProviderOrder model = list[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context, AppConstant.OrdersDetialsScreenRoute,
                    arguments: model);
              },
              child: ItemsOrders()
                  .buildListItem(context: context, model: model, index: index),
            );
          }),
    );
  }

  Future<void> refreshData() async {
    print('eeeeeeeeeeeeeeee  refreshData  eeeeeeeeeeeeeeeeeeee');

    UserOrderCubit cubit = BlocProvider.of<UserOrderCubit>(context);
    cubit.getUserCompletedOrder();
  }

  Future<void> refreshCurrent() async {
    print('wwwwwwwwwwwwwwwwwwww   refreshCurrent  wwwwwwwwwwwwwwwwwwwwwwwww');
    UserOrderCubit cubit = BlocProvider.of<UserOrderCubit>(context);
    cubit.getUserAcceptOrder();
  }

  Widget buildTab(String title, String icon, int index) {
    UserOrderCubit cubit = BlocProvider.of(context);
    return BlocBuilder<UserOrderCubit, UserOrderState>(
      builder: (context, state) {
        int selectedIndex = cubit.index;
        if (state is UpdateIndex) {
          selectedIndex = state.index;
        }
        return Tab(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppColors.colorPrimary
                    : AppColors.transparent,
                borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppWidget.svg(
                    icon,
                    selectedIndex == index ? AppColors.white : AppColors.color1,
                    24.0,
                    24.0),
                SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: selectedIndex == index
                          ? AppColors.white
                          : AppColors.color1,
                      fontSize: 14.0),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabs = [
      buildTab('current_order'.tr(), '', 0),
      buildTab('completed_order'.tr(), '', 1),
    ];
    _screens = [buildCurrentOrderList(), buildCompleteOrderList()];
    _controller = TabController(length: _tabs.length, vsync: this);
  }
}
