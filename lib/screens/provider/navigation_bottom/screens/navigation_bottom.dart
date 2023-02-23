import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../colors/colors.dart';
import '../../../../constants/asset_manager.dart';
import '../../../../widgets/app_widgets.dart';
import '../../../settings_screen/setting_screen.dart';
import '../../../user/home_page/navigation_screens/conversation_screen/conversation_page.dart';
import '../../home_screen/screens/home_screen.dart';
import '../../provider_orders/presentation/screens/Order_Screen.dart';
import '../cubit/navigator_bottom_cubit.dart';
import '../widget/navigator_bottom_widget.dart';

class NavigationBottom extends StatefulWidget {
  NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 70,
          child: NavigatorBottomWidget(),
        ),
        body: BlocBuilder<NavigatorBottomCubit, NavigatorBottomState>(
          builder: (context, state) {
            if (context.read<NavigatorBottomCubit>().page == 0) {
              return ProviderHomeScreen();
            } else if (context.read<NavigatorBottomCubit>().page == 1) {
             return ConversationPage();
            } else if (context.read<NavigatorBottomCubit>().page == 2) {
              return OrderScreen();
            } else {
              return SettingPage();
            }
          },
        ));
  }
}
