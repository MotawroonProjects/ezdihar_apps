import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../remote/notificationlisten.dart';
import '../cubit/orders_cubit.dart';
import '../widgets/completed_orders_widget.dart';
import '../widgets/current_orders_widget.dart';
import '../widgets/tab_bar_widget.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  // TabBar get _tabBar => TabBar(
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0XFFF5F5F5),
          appBar: AppBar(
            toolbarHeight: 120,
            titleSpacing: 0,
            centerTitle: true,
            elevation: 0,
            title: Column(
              children: [
                Text(
                  'orders'.tr(),
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 8),
                BlocBuilder<OrdersCubit, OrdersState>(
                  builder: (context, state) {
                    if (state is OrdersTabChanged) {
                      // _tabController!.animateTo(state.index);
                      return Row(
                        children: [
                          TabBarWidget(
                            text: "current_order".tr(),
                            index: 0,
                          ),
                          TabBarWidget(
                            text: "completed_order".tr(),
                            index: 1,
                          )
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          TabBarWidget(
                            text: "current_order".tr(),
                            index: 0,
                          ),
                          TabBarWidget(
                            text: "completed_order".tr(),
                            index: 1,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
            backgroundColor: Colors.white,
          ),
          body: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              return context.read<OrdersCubit>().page == 0
                  ? CurrentOrdersWidget()
                  : CompletedOrdersWidget();
            },
          ),
        ));
  }
}
