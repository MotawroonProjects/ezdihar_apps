import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/routes/app_routes.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/consulting_screen/consulting_screen.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/service_screen/service_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/consultants_cubit.dart';

class ConsultantsPage extends StatefulWidget {
  const ConsultantsPage({Key? key}) : super(key: key);

  @override
  State<ConsultantsPage> createState() => _ConsultantsPageState();
}

class _ConsultantsPageState extends State<ConsultantsPage>
    with SingleTickerProviderStateMixin {
  final ConsultantsCubit _consultantsCubit = ConsultantsCubit();
  List<Widget> _screens = [];
  List<Widget> _tabs = [];
  late var _controller;

  @override
  void initState() {
    super.initState();
    _screens = [
      const ServicesPage(),
      const ConsultingPage()
    ];
    _tabs = [
      _buildTabBarItem(context: context, title: 'services'.tr()),
      _buildTabBarItem(context: context, title: 'consulting'.tr())
    ];
    _controller = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _consultantsCubit,
      child: BlocBuilder<ConsultantsCubit, ConsultantsState>(
        builder: (context, state) {
          int index = 0;
          if(state is OnPagePosChangedState){
            index = state.index;
          }
          return Scaffold(
            body: Column(
              children: [
                const SizedBox(
                  height: 6.0,
                ),
                _buildTabBarView(context),
                Expanded(child:
                IndexedStack(
                  index: index,
                  children: _screens,
                )
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return Container(
      height: 60.0,
      color: AppColors.white,
      child: TabBar(
        controller: _controller,
        indicatorColor: AppColors.colorPrimary,
        indicatorWeight: 4.0,
        tabs: _tabs,
        onTap: (index){
          _consultantsCubit.updatePagePos(index);
        },
        unselectedLabelColor: AppColors.grey1,
        labelColor: AppColors.colorPrimary,
      ),
    );
  }

  Widget _buildTabBarItem(
      {required BuildContext context, required String title}) {
    return Tab(
      child: Text(title,
        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
    );
  }
}
