import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    _tabController = new TabController(vsync: this, length: 4, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: const Color(0XFFF5F5F5),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title:  Text(
              'orders'.tr(),
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: [
              BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  if (state is OrdersTabChanged) {
                    _tabController!.animateTo(state.index);
                    return Row(
                      children: [
                        TabBarWidget(
                          text: "new_order".tr(),
                          index: 0,
                        ),
                        TabBarWidget(
                          text: "current_order".tr(),
                          index: 1,
                        ),
                        TabBarWidget(
                          text: "completed_order".tr(),
                          index: 2,
                        ),
                        TabBarWidget(
                          text: "refused_order".tr(),
                          index: 3,
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        TabBarWidget(
                          text: "new_order".tr(),
                          index: 0,
                        ),
                        TabBarWidget(
                          text: "current_order".tr(),
                          index: 1,
                        ),
                        TabBarWidget(
                          text: "completed_order".tr(),
                          index: 2,
                        ),
                        TabBarWidget(
                          text: "refused_order".tr(),
                          index: 3,
                        ),
                      ],
                    );
                  }
                },
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),

                  controller: _tabController,
                  children: [
                    //NewOrderScreen(),
                    CurrentOrdersWidget(),
                    CompletedOrdersWidget(),
                    //RefusedOrdersWidget()
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
