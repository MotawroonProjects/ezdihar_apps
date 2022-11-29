import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/routes/app_routes.dart';
import 'package:ezdihar_apps/screens/user/add_screen/add_screen.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/consultants_screen/consultants_screen.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/conversation_screen/conversation_page.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/home_screen/cubit/home_page_cubit.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/investor_screen/investor_screen.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/main_screen/main_page.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/more_screen/more_screen.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/notification_screen/notification_screen.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constants/asset_manager.dart';
import '../user_order_screen/user_order_screen/user_order_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> screens = [
    const MainPage(),
    UserOrderPage(),
    const ConsultantsPage(),
    const ConversationPage(),
    const MorePage(),
    const NotificationPage(),
  ];
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        int index = 0;
        if (state is MainPageInitial) {
          index = (state).index;
        } else if (state is MainPageIndexUpdated) {

          index = state.index;

        }

        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildAppBar(context, "0"),
                  Expanded(
                    child: IndexedStack(
                      index: index,
                      children: screens,
                    ),
                  ),
                ],
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     Navigator.of(context).pushNamed(AppConstant.pageAddRoute);
            //   },
            //   backgroundColor: AppColors.color1,
            //   child: AppWidget.svg('add.svg', AppColors.white, 24, 24),
            // ),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              color: AppColors.white,
              elevation: 12.0,
              notchMargin: 10.0,
              shape: const CircularNotchedRectangle(),
              child: SizedBox(
                height: 77,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                        child: _buildBottomNavigationItem(
                            context,
                            'home.svg',
                            index == 0
                                ? AppColors.colorPrimary
                                : AppColors.grey1,
                            'home'.tr(),
                            0)),
                    Flexible(
                        child: _buildBottomNavigationItem(
                            context,
                            'order_icon.svg',
                            index == 1
                                ? AppColors.colorPrimary
                                : AppColors.grey1,
                            'orders'.tr(),
                            1)),
                    Flexible(
                        child: _buildBottomNavigationItem(
                            context,
                            'feasibility.svg',
                            index == 2
                                ? AppColors.colorPrimary
                                : AppColors.grey1,
                            'services'.tr(),
                            2)),
                    Flexible(
                        child: _buildBottomNavigationItem(
                            context,
                            'chat.svg',
                            index == 3
                                ? AppColors.colorPrimary
                                : AppColors.grey1,
                            'conversation'.tr(),
                            3)),
                    Flexible(
                        child: _buildBottomNavigationItem(
                            context,
                            'squares.svg',
                            index == 4
                                ? AppColors.colorPrimary
                                : AppColors.grey1,
                            'more'.tr(),
                            4)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context, String notificationCount) {
    double width = MediaQuery.of(context).size.width;
    return
      Container(
      width: width,
      height: 56.0,
      decoration: BoxDecoration(color: AppColors.white, boxShadow: [
        BoxShadow(
            color: AppColors.black.withOpacity(.2),
            offset: const Offset(0.0, 1.0),
            blurRadius: 8)
      ]),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 99.0,
            height: 36.0,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('${AppConstant.localImagePath}logo.png'))),
          ),
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).pushNamed(AppConstant.pageUserOrderRoute);            },
          //   child: Container(
          //
          //     child: Center(
          //       child: Stack(
          //         children: [
          //           Positioned(
          //               child: AppWidget.svg(
          //                   "order_icon.svg", AppColors.color1, 32, 32)),
          //
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          InkWell(
            onTap: () => AppRoutes.homePageCubit.updateIndex(4),
            child: Container(
              width: 48.0,
              height: 48.0,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                        child: AppWidget.svg(
                            "notifications.svg", AppColors.color1, 32, 32)),
                    Positioned(
                        child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "0",
                          style: TextStyle(
                              color: AppColors.white,
                              decoration: TextDecoration.none,
                              fontSize: 12.0),
                          maxLines: 1,
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomNavigationItem(
      BuildContext context, imageName, Color color, String title, int index) {
    return MaterialButton(
      onPressed: () {

        AppRoutes.homePageCubit.updateIndex(index);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppWidget.svg(imageName, color, 24.0, 24.0),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            title,
            maxLines: 1,
            style: TextStyle(color: color, fontSize: 10.0),
          )
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (AppRoutes.homePageCubit.index != 0) {
      AppRoutes.homePageCubit.updateIndex(0);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
  }
}
