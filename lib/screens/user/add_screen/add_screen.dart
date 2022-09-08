import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/user/add_screen/add_widgets/add_screen_widgets.dart';
import 'package:ezdihar_apps/screens/user/add_screen/cubit/add_screen_cubit.dart';
import 'package:ezdihar_apps/screens/user/add_screen/navigation_screens/feasibility_screen/feasibility_screen.dart';
import 'package:ezdihar_apps/screens/user/add_screen/navigation_screens/investment_screen/investment_screen.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> with SingleTickerProviderStateMixin {
  final _cubit = AddScreenCubit();
  List<Widget> _screens = [];
  List<Widget> _tabs = [];
  late var _controller;

  @override
  void initState() {
    super.initState();
    _screens = [const FeasibilityPage(), const InvestmentPage()];
    _tabs = [
      BlocBuilder<AddScreenCubit, AddScreenState>(
        builder: (context, state) {
          int pos = 0;
          if (state is OnPositionChangedState) {
            pos = state.pos;
          }
          return _buildTabBarItem(
              context: context,
              title: 'feasibility'.tr(),
              imageName: 'feasibility.svg',
              color: pos == 0 ? AppColors.colorPrimary : AppColors.grey1);
        },
      ),
      BlocBuilder<AddScreenCubit, AddScreenState>(
        builder: (context, state) {
          int pos = 0;
          if (state is OnPositionChangedState) {
            pos = state.pos;
          }
          return _buildTabBarItem(
              context: context,
              title: 'investment'.tr(),
              imageName: 'investment.svg',
              color: pos == 1 ? AppColors.colorPrimary : AppColors.grey1);
        },
      )
    ];
    _controller = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        body: _buildAppBarSection(context: context),
      ),
    );
  }

  Widget _buildAppBarSection({required BuildContext context}) {
    return SafeArea(
      child: Container(
        color: AppColors.grey3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              BlocBuilder<AddScreenCubit, AddScreenState>(
                builder: (context, state) {
                  print("status=>${state.toString()}");
                  return SliverAppBar(
                    backgroundColor: AppColors.white,
                    pinned: true,
                    leading: AppWidget.buildBackArrow(context: context),
                    title: Text(
                      'add'.tr(),
                      style: const TextStyle(
                          fontSize: 16.0,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    centerTitle: true,
                    expandedHeight: _cubit.sliders.length > 0?320:0,
                    flexibleSpace: _cubit.sliders.length > 0 ? FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: AddScreenWidget().buildSliderSection(
                          context: context, images: _cubit.sliders),
                    )
                        : SizedBox(),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: _buildTabBarView(context: context),
                    ),
                  );
                },
              )
            ];
          },
          body: _buildBodySection(context: context),
        ),
      ),
    );
  }

  Widget _buildTabBarView({required BuildContext context}) {
    return Container(
      height: 60.0,
      color: AppColors.white,
      child: TabBar(
        controller: _controller,
        indicatorColor: AppColors.colorPrimary,
        indicatorWeight: 4.0,
        tabs: _tabs,
        onTap: (index) {
          _cubit.updatePos(pos: index);
        },
        unselectedLabelColor: AppColors.grey1,
        labelColor: AppColors.colorPrimary,
      ),
    );
  }

  Widget _buildTabBarItem({required BuildContext context,
    required String title,
    required String imageName,
    required Color color}) {
    return Tab(
      child: Row(
        children: [
          AppWidget.svg(imageName, color, 24.0, 24.0),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildBodySection({required BuildContext context}) {
    return BlocBuilder<AddScreenCubit, AddScreenState>(
      builder: (context, state) {
        int pos = 0;
        if (state is OnPositionChangedState) {
          pos = state.pos;
        }
        print('pos${pos}');
        return IndexedStack(
          index: pos,
          children: _screens,
        );
      },
    );
  }
}
